require("heroes/hero_flicker/ascension")

function Stabilize_GiveCharges(event)
    local caster = event.caster
    local ability = event.ability
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)
    local charges_per_hit = 1 /  ability:GetLevelSpecialValueFor("hits_per_charge", ability:GetLevel() - 1)
    local charges_per_hero = ability:GetLevelSpecialValueFor("charges_per_hero", ability:GetLevel() - 1)
    local flicker_flash_step = caster:FindAbilityByName("flicker_flash_step")
    
    if (flicker_flash_step ~= nil) and (flicker_flash_step:GetLevel() > 0) then
        local units = FindUnitsInRadius( caster:GetTeamNumber(),
                                          caster:GetAbsOrigin(),
                                          nil,
                                          radius,
                                          DOTA_UNIT_TARGET_TEAM_ENEMY,
                                          DOTA_UNIT_TARGET_HERO ,
                                          DOTA_UNIT_TARGET_FLAG_NONE,
                                          FIND_ANY_ORDER,
                                          false )
        local charges = 1
        
        for _, u in pairs(units) do
            if u:IsConsideredHero() then
                charges = charges + charges_per_hero
            else
                charges = charges + charges_per_hit
            end
        end

        flicker_flash_step:RestoreCharge(charges)

    end
end

function Stabilize_GetRadius(stabilize)
    return stabilize:GetLevelSpecialValueFor("radius", stabilize:GetLevel() - 1) * GetAscensionReachMultiplier(stabilize:GetCaster())
end