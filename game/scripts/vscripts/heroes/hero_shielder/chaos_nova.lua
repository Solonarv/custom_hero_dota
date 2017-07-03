function ChaosNova(event)
    local caster = event.caster
    local ability = event.ability
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)
    local damage_pct = ability:GetLevelSpecialValueFor("damage_scale", ability:GetLevel() - 1) / 100

    local life_lost = caster:GetHealth() - 1
    local mana_lost = caster:GetMana()

    caster:SetHealth(1)
    caster:SetMana(0)

    local damage = damage_pct * (life_lost + mana_lost)

    local targets = FindUnitsInRadius(caster:GetTeamNumber(),
                                      caster:GetAbsOrigin(),
                                      nil,
                                      radius,
                                      DOTA_UNIT_TARGET_TEAM_ENEMY,
                                      DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                                      DOTA_UNIT_TARGET_FLAG_NONE,
                                      FIND_ANY_ORDER,
                                      false)

    for _, victim in pairs(targets) do
        ApplyDamage({
            victim = victim,
            attacker = caster,
            damage = damage,
            damage_type = ability:GetAbilityDamageType(),
            ability = ability
            })
    end
end