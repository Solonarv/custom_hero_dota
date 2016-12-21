-- Stolen from the Dota 2 Spell Library, then modified a bit.
-- Returns the closest illusion to the given point owned by the given hero
function GetClosestIllusions(hero, point)
    local playerID = hero:GetPlayerID()

    local allies = FindUnitsInRadius( hero:GetTeamNumber(),
                                      point,
                                      nil,
                                      FIND_UNITS_EVERYWHERE,
                                      DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                      DOTA_UNIT_TARGET_HERO,
                                      DOTA_UNIT_TARGET_FLAG_NONE,
                                      FIND_CLOSEST,
                                      false )

    local illusions = {}

    for _,v in pairs(allies) do
        if v:GetPlayerID() == playerID and v:IsIllusion() then
            table.insert(illusions, v)
        end
    end

    return illusions
end

function FracturedSelf(event)
    local caster = event.caster
    local castpos = event.target_points[1]
    local ability = event.ability
    local modifier_dummy_phasing = "modifier_fractured_self_dummy_phasing"
    local range = ability:GetLevelSpecialValueFor("actual_range", (ability:GetLevel() - 1))

    local targets = GetClosestIllusions(caster, castpos)

    for _, target in pairs(targets) do
        if target ~= nil then
            local targetpos = target:GetAbsOrigin()
            local targetangles = target:GetAngles()
            local casterpos = caster:GetAbsOrigin()
            local casterangles = caster:GetAngles()
            local delta = targetpos - casterpos

            if delta:Length2D() <= range + 50 --[[ buffer ]] then

                ability:ApplyDataDrivenModifier(caster, caster, modifier_dummy_phasing, {})
                ability:ApplyDataDrivenModifier(caster, target, modifier_dummy_phasing, {})

                FindClearSpaceForUnit(caster, targetpos, false)
                FindClearSpaceForUnit(target, casterpos, false)

                caster:SetAngles(targetangles.x, targetangles.y, targetangles.z)
                target:SetAngles(casterangles.x,casterangles.y, casterangles.z)

                caster:RemoveModifierByName(modifier_dummy_phasing)
                target:RemoveModifierByName(modifier_dummy_phasing)

                -- Bail out to indicate success
                return nil
            end
        end
    end

    -- If we're still here, the ability didn't succeed, so the cooldown is reset.
    ability:EndCooldown()
end

function ApplyIllusionChange(event)
    local ability = event.ability
    local caster = event.caster
    local nerf = event.nerf

    if caster:IsIllusion() and not caster:HasModifier(nerf) then
        print("Nerfed illusion!")
        caster:Interrupt()
        ability:ApplyDataDrivenModifier(caster, caster, nerf, {})
        caster:RemoveModifierByName("modifier_fractured_self_check")
        for itemSlot=0,5 do
            local item = caster:GetItemInSlot(itemSlot)
            -- Illusions aren't allowed to have MKB
            if item ~= nil and item:GetName() == "item_monkey_king_bar" then
                caster:RemoveItem(item)
            end
        end
    end
end

function DeleteUnit(event)
    local ability = event.ability
    local unit = event.target
    unit:RemoveSelf()
end