function Judgment(event)
    local ability = event.ability
    local caster = event.caster
    local target = event.target
    local damage = event.damage
    local healing = event.healing
    local marker = event.marker

    local partiality = 1 - event.partiality / 100

    if target:HasModifier(marker) then
        if target:GetTeamNumber() ~= caster:GetTeamNumber() then
            healing = healing * partiality
        end
        target:Heal(healing, ability)
    else
        if target:GetTeamNumber() == caster:GetTeamNumber() then
            damage = damage * partiality
            damage = math.min(damage, target:GetHealth() * (1 - target:GetMagicalArmorValue()) - 1)
        end
        ApplyDamage({
            victim = target,
            attacker = caster,
            damage = damage,
            damage_type = ability:GetAbilityDamageType(),
            ability = ability
        })
    end
end