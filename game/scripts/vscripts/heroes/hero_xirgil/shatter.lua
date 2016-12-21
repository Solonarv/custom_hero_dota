-- This is all taken and modifier on PL's Doppelganger from the Dota 2 Spell Library.

--[[Author: YOLOSPAGHETTI
    Date: February 16, 2016
    Draws all unit models, places them in random positions in the aoe, and creates the doppelganger illusions]]
function ShatterEnd( event )
    local caster = event.caster
    local target = event.target
    local ability = event.ability   
    local radius = ability:GetLevelSpecialValueFor( "radius", ability:GetLevel() - 1 )
    
    -- Draws the unit's model
    target:RemoveNoDraw()   
    -- Sets them in a random position in the target aoe
    target:SetAbsOrigin(target.shatter_position)
    FindClearSpaceForUnit(target, target.shatter_position, true)
    
    if target == caster then
        local player = caster:GetPlayerID()
        local unit_name = caster:GetUnitName()
        local duration = ability:GetLevelSpecialValueFor( "duration", ability:GetLevel() - 1 )
        local shadow_count = ability:GetLevelSpecialValueFor("shadow_count", ability:GetLevel() - 1)
        local outgoingDamage = ability:GetLevelSpecialValueFor( "shadow_outgoing_damage", ability:GetLevel() - 1 )
        local incomingDamage = ability:GetLevelSpecialValueFor( "shadow_incoming_damage", ability:GetLevel() - 1 )

        -- Creates the extra illusions
        for j=1,shadow_count do
            local rand_distance = math.random(0,radius)
            local origin = caster:GetAbsOrigin() + RandomVector(rand_distance)

            -- handle_UnitOwner needs to be nil, else it will crash the game.
            local illusion = CreateUnitByName("npc_xirgil_shadow", origin, true, caster, caster, caster:GetTeamNumber())
            --illusion:SetPlayerID(caster:GetPlayerID())
            illusion:SetControllableByPlayer(player, true)
    
            -- -- Level Up the unit to the casters level
            -- local casterLevel = caster:GetLevel()
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

            -- Set the unit as an illusion
            -- modifier_illusion controls many illusion properties like +Green damage not adding to the unit damage, not being able to cast spells and the team-only blue particle
        illusion:FindAbilityByName("xirgil_fractured_self"):ApplyDataDrivenModifier(illusion, illusion, "modifier_fractured_self_shadow_timer", {duration = duration})
    
            -- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
            -- illusion:MakeIllusion()
        end
    end
end

--[[Author: YOLOSPAGHETTI
    Date: February 16, 2016
    Applies a basic dispel to the unit and removes the model]]
function ShatterStart( keys )
    local target = keys.target

    -- Basic Dispel
    local RemovePositiveBuffs = false
    local RemoveDebuffs = true
    local BuffsCreatedThisFrameOnly = false
    local RemoveStuns = false
    local RemoveExceptions = false
    target:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
    
    -- Removes the unit's model
    target:AddNoDraw()
end

--[[Author: YOLOSPAGHETTI
    Date: February 16, 2016
    Applies the banish to the caster and all of his illusions in the area]]
function CheckUnits(keys)
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local duration = ability:GetLevelSpecialValueFor( "untargetable_duration", ability:GetLevel() - 1 )
    local radius = ability:GetLevelSpecialValueFor( "radius", ability:GetLevel() - 1 )

    -- Checks that the unit is either the caster or one of his illusions, and applies the banish
    if target:GetUnitName() == caster:GetUnitName() and target:GetMainControllingPlayer() == caster:GetMainControllingPlayer() then

        -- Calculate the random positions for the illusions and caster
        local rand_distance = math.random(0,radius) 
        local rand_position = caster:GetAbsOrigin() + RandomVector(rand_distance)
        target.shatter_position = rand_position

        -- Create the dopple disappear effect
        local dopple_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_lancer/phantom_lancer_doppleganger_illlmove.vpcf",PATTACH_CUSTOMORIGIN,caster)
        ParticleManager:SetParticleControl(dopple_particle,0,target:GetAbsOrigin())
        ParticleManager:SetParticleControl(dopple_particle,1,rand_position)
        ParticleManager:ReleaseParticleIndex(dopple_particle)

        ability:ApplyDataDrivenModifier(caster, target, "modifier_shatter", {Duration = duration})
    end
end