function EssenceSplit(event)
    local caster = event.caster
    local casterpos = caster:GetAbsOrigin()
    local targetpos = event.target_points[1]
    local ability = event.ability
    local modifier = event.modifier
    local max_distance = ability:GetLevelSpecialValueFor("dash_range", ability:GetLevel() - 1)

    local speed = ability:GetLevelSpecialValueFor("speed", (ability:GetLevel() - 1))
    local distance = min(max_distance, (targetpos - casterpos):Length2D())
    local direction = (targetpos - casterpos):Normalized()
    local duration = distance/speed

    ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
    caster.essence_split_distance = distance
    caster.essence_split_speed = speed * 1/30
    caster.essence_split_direction = direction
    caster.essence_split_traveled_distance = 0

    local player = caster:GetPlayerID()
    local unit_name = caster:GetUnitName()
    local duration = ability:GetLevelSpecialValueFor( "duration", ability:GetLevel() - 1 )
    local shadow_count = ability:GetLevelSpecialValueFor("shadow_count", ability:GetLevel() - 1)
    local outgoingDamage = ability:GetLevelSpecialValueFor( "shadow_outgoing_damage", ability:GetLevel() - 1 )
    local incomingDamage = ability:GetLevelSpecialValueFor( "shadow_incoming_damage", ability:GetLevel() - 1 )
    local casterLevel = caster:GetLevel()

    local fractalrushmod = "modifier_fractal_rush"

    for j=1,shadow_count do
        -- handle_UnitOwner needs to be nil, else it will crash the game.
        -- local illusion = CreateUnitByName(unit_name, casterpos, true, caster, nil, caster:GetTeamNumber())
        local illusion = CreateUnitByName("npc_xirgil_shadow", casterpos, true, caster, caster, caster:GetTeamNumber())
        -- illusion:SetPlayerID(caster:GetPlayerID())
        illusion:SetControllableByPlayer(player, true)

        -- -- Level Up the unit to the casters level
        -- for i=1,casterLevel-1 do
        --     illusion:HeroLevelUp(false)
        -- end

        local fractalrush = nil
        -- Set the skill points to 0 and learn the skills of the caster
        -- illusion:SetAbilityPoints(0)
        for abilitySlot=0,15 do
            local ability = caster:GetAbilityByIndex(abilitySlot)
            if ability ~= nil then 
                -- local abilityLevel = ability:GetLevel()
                local abilityName = ability:GetAbilityName()
                -- local illusionAbility = illusion:FindAbilityByName(abilityName)
                -- illusionAbility:SetLevel(abilityLevel)
                if ability:GetAbilityName() == "xirgil_fractal_rush" then
                    fractalrush = ability
                end
            end
        end

        -- -- Recreate the items of the caster
        -- for itemSlot=0,5 do
        --     local item = caster:GetItemInSlot(itemSlot)
        --     if item ~= nil then
        --         local itemName = item:GetName()
        --         local newItem = CreateItem(itemName, illusion, illusion)
        --         illusion:AddItem(newItem)
        --     end
        -- end


        if caster:HasModifier(fractalrushmod) and fractalrush ~= nil then
            print("Copying Fractal Rush to illusion!")
            fractalrush:ApplyDataDrivenModifier(caster, illusion, fractalrushmod, {})
            illusion.fractal_rush_distance = caster.fractal_rush_distance
            illusion.fractal_rush_speed = caster.fractal_rush_speed
            illusion.fractal_rush_direction = caster.fractal_rush_direction
            illusion.fractal_rush_traveled_distance = caster.fractal_rush_traveled_distance
        else
            if j > 1 then
                -- BLACK MAGIC
                direction = RotatePosition(direction, QAngle(0, 120, 0), Vector(0,0,0)) - direction
                direction = RotatePosition(direction, QAngle(0, 120, 0), Vector(0,0,0)) - direction
                -- DO NOT TOUCH
                ability:ApplyDataDrivenModifier(caster, illusion, modifier, {})
                illusion.essence_split_distance = distance
                illusion.essence_split_speed = speed * 1/20
                illusion.essence_split_direction = direction
                illusion.essence_split_traveled_distance = 0
            end
        end

        -- -- Set the unit as an illusion
        -- -- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle
        illusion:FindAbilityByName("xirgil_fractured_self"):ApplyDataDrivenModifier(illusion, illusion, "modifier_fractured_self_shadow_timer", {duration = duration})

        -- -- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
        -- illusion:MakeIllusion()
    end
end

function EssenceSplit_Motion(event)
    local unit = event.target

    if not unit:HasModifier("modifier_fractal_rush") then
        if unit.essence_split_traveled_distance < unit.essence_split_distance then
            unit:SetAbsOrigin(unit:GetAbsOrigin() + unit.essence_split_direction * unit.essence_split_speed)
            unit.essence_split_traveled_distance = unit.essence_split_traveled_distance + unit.essence_split_speed
        else
            unit:RemoveModifierByName("modifier_essence_split")
        end
    else
        unit:RemoveModifierByName("modifier_essence_split")
    end
end