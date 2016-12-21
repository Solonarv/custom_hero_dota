function BlinkArrow(event)
    local ability = event.ability
    local caster = event.caster
    local direction = caster:GetForwardVector()
    local caster_pos = caster:GetAbsOrigin()
    local proj_speed = caster:GetProjectileSpeed()
    local target = event.target_points[1]
    local distance = (target - caster_pos):Length2D()


    ProjectileManager:CreateLinearProjectile({
            EffectName = "particles/dev/empty_particle.vpcf",
            Ability = ability,
            vSpawnOrigin = caster_pos,
            vVelocity = direction * proj_speed,
            fDistance = distance,
            fStartRadius = 0,
            fEndRadius = 0,
            Source = caster,
            bHasFrontalCone = false,
            bReplaceExisting = false,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
            iUnitTargetFlags = DOTA_UNIT_TARGET_NONE,
            iUnitTargetType = DOTA_UNIT_TARGET_NONE
            })
end

function ConjureImage(event)
    local caster = event.caster
    local player = caster:GetPlayerID()
    local ability = event.ability
    local target_pos = event.target_points[1]
    local unit_name = caster:GetUnitName()
    -- local duration = ability:GetLevelSpecialValueFor( "illusion_duration", ability:GetLevel() - 1 )
    -- local outgoingDamage = ability:GetLevelSpecialValueFor( "illusion_outgoing_damage", ability:GetLevel() - 1 )
    -- local incomingDamage = ability:GetLevelSpecialValueFor( "illusion_incoming_damage", ability:GetLevel() - 1 )

    -- -- handle_UnitOwner needs to be nil, else it will crash the game.
    -- local illusion = CreateUnitByName(unit_name, caster:GetAbsOrigin(), true, caster, nil, caster:GetTeamNumber())
    -- illusion:SetPlayerID(caster:GetPlayerID())
    -- illusion:SetControllableByPlayer(player, true)
    
    -- -- Level Up the unit to the casters level
    -- local casterLevel = caster:GetLevel()
    -- for i=1,casterLevel-1 do
    --     illusion:HeroLevelUp(false)
    -- end

    -- -- Set the skill points to 0 and learn the skills of the caster
    -- illusion:SetAbilityPoints(0)
    -- for abilitySlot=15,0,-1 do
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
    -- illusion:AddNewModifier(caster, ability, "modifier_illusion", { duration = duration, outgoing_damage = outgoingDamage, incoming_damage = incomingDamage })
    
    -- -- Without MakeIllusion the unit counts as a hero, e.g. if it dies to neutrals it says killed by neutrals, it respawns, etc.
    -- illusion:MakeIllusion()

    FindClearSpaceForUnit(caster, target_pos, false)
    ProjectileManager:ProjectileDodge(caster)
end