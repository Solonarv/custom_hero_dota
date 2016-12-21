function EssenceDrain(event)
    local caster = event.caster
    local ability = event.ability
    local target = event.target
    local lvl = ability:GetLevel() - 1
    local modifier = event.modifier
    local buff = event.buff

    local think_interval = ability:GetLevelSpecialValueFor("think_interval", lvl)
    local damage = ability:GetLevelSpecialValueFor("damage", lvl) * think_interval
    local buffer = ability:GetLevelSpecialValueFor("buffer", lvl)
    local leash_range = ability:GetCastRange() + buffer
    if caster.ghost_reaver_portion == nil then
        caster.ghost_reaver_portion = 0
    end

    if (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() < leash_range then
        local restore = ApplyDamage({
            ability = ability,
            attacker = caster,
            victim = target,
            damage = damage,
            damage_type = ability:GetAbilityDamageType(),
            })

        caster:GiveMana(restore * caster.ghost_reaver_portion)
        caster:Heal(restore * (1 - caster.ghost_reaver_portion), ability)
    else
        target:RemoveModifierByName(modifier)
        caster:RemoveModifierByName(buff)
    end
end