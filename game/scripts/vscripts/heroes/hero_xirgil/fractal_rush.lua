function CheckUnits(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability

    if ability.units == nil then
        ability.units = {}
    end

    if ability.unit_count == nil then
        ability.unit_count = 0
    end

    -- Checks that the unit is either the caster or one of his units, and applies the banish
    if (target:GetUnitName() == caster:GetUnitName() or target:GetUnitName() == "npc_xirgil_shadow") and target:GetMainControllingPlayer() == caster:GetMainControllingPlayer() then
        ability.unit_count = ability.unit_count + 1
        ability.units[target] = true
    end
end

function FractalRush(event)
    local caster = event.caster
    local pivot = event.target_points[1]
    local ability = event.ability
    local units = ability.units
    local modifier = event.modifier
    local dash_time = ability:GetLevelSpecialValueFor("travel_time", ability:GetLevel() - 1)
    local shadow_count = ability:GetLevelSpecialValueFor("shadow_threshold", ability:GetLevel() - 1)
    local outgoingDamage = ability:GetLevelSpecialValueFor( "shadow_outgoing_damage", ability:GetLevel() - 1 )
    local incomingDamage = ability:GetLevelSpecialValueFor( "shadow_incoming_damage", ability:GetLevel() - 1 )
    local duration = ability:GetLevelSpecialValueFor("duration", ability:GetLevel() - 1)
    local range = ability:GetCastRange()
    local unit_name = caster:GetUnitName()
    local casterpos = caster:GetAbsOrigin()
    local player = caster:GetPlayerID()
    local casterLevel = caster:GetLevel()

    local unit_count = ability.unit_count

    local missing_units = max(0, shadow_count - unit_count + 1)

    for j=1,missing_units do

        local rand_distance = math.random(0, range)
        local rand_position = casterpos + RandomVector(range)

        local illusion = CreateUnitByName("npc_xirgil_shadow", rand_position, true, caster, caster, caster:GetTeamNumber())
        -- illusion:SetPlayerID(caster:GetPlayerID())
        illusion:SetControllableByPlayer(player, true)

        -- Level Up the unit to the casters level
        -- for i=1,casterLevel-1 do
        --     illusion:HeroLevelUp(false)
        -- end

        -- -- Set the skill points to 0 and learn the skills of the caster
        -- illusion:SetAbilityPoints(0)
        -- for abilitySlot=0,15 do
        --     local ability = caster:GetAbilityByIndex(abilitySlot)
        --     if ability ~= nil then 
        --         local abilityLevel = ability:GetLevel()
        --         local abilityName = ability:GetAbilityName()
        --         local illusionAbility = illusion:FindAbilityByName(abilityName)
        --         illusionAbility:SetLevel(abilityLevel)
        --     end
        -- end

        -- -- Recreate the items of the caster
        -- for itemSlot=0,5 do
        --     local item = caster:GetItemInSlot(itemSlot)
        --     if item ~= nil then
        --         local itemName = item:GetName()
        --         local newItem = CreateItem(itemName, illusion, illusion)
        --         illusion:AddItem(newItem)
        --     end
        -- end

        -- -- Set the unit as an illusion
        -- -- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle
        illusion:FindAbilityByName("xirgil_fractured_self"):ApplyDataDrivenModifier(illusion, illusion, "modifier_fractured_self_shadow_timer", {duration = duration})

        -- -- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
        -- illusion:MakeIllusion()

        units[illusion] = true
        unit_count = unit_count + 1
    end

    for unit, _ in pairs(units) do
        local unit_pos = unit:GetAbsOrigin()
        local delta = (pivot - unit_pos) * 2
        local distance = delta:Length2D()
        local direction = delta:Normalized()
        local speed = distance / dash_time * 1/20

        unit.fractal_rush_distance = distance
        unit.fractal_rush_speed = speed
        unit.fractal_rush_direction = direction
        unit.fractal_rush_traveled_distance = 0
        ability:ApplyDataDrivenModifier(caster, unit, modifier, {})

    end

    ability.units = {}
    ability.unit_count = 0
end

function FractalRush_Think(event)
    local unit = event.target
    local ability = event.ability
    local width = ability:GetLevelSpecialValueFor("damage_width", ability:GetLevel() - 1)
    local damage = ability:GetAbilityDamage()
    
    unit:RemoveModifierByName("modifier_essence_split")

    if unit.fractal_rush_traveled_distance < unit.fractal_rush_distance then
        unit:SetAbsOrigin(unit:GetAbsOrigin() + unit.fractal_rush_direction * unit.fractal_rush_speed)
        unit.fractal_rush_traveled_distance = unit.fractal_rush_traveled_distance + unit.fractal_rush_speed
        
        local remaining_time = (unit.fractal_rush_distance - unit.fractal_rush_traveled_distance) / (unit.fractal_rush_speed * 20)

        local enemies = FindUnitsInRadius(unit:GetTeamNumber(),
                                      unit:GetAbsOrigin(),
                                      nil,
                                      width,
                                      DOTA_UNIT_TARGET_TEAM_ENEMY,
                                      DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                                      DOTA_UNIT_TARGET_FLAG_NONE,
                                      FIND_ANY_ORDER,
                                      false)

        for _,e in pairs(enemies) do
        if e.fractal_rush_damaged == nil then
            e.fractal_rush_damaged = {}
        end
        local now = GameRules:GetGameTime()
        if e.fractal_rush_damaged[unit] == nil or e.fractal_rush_damaged[unit] < now then
            ApplyDamage({
                victim = e,
                attacker = unit,
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = ability
            })
            e.fractal_rush_damaged[unit] = now + remaining_time
        end
    end
        unit:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
    else
        unit:RemoveModifierByName("modifier_fractal_rush")
        unit:SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
    end
end