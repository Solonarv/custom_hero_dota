--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 19:31
-- To change this template use File | Settings | File Templates.
--

function DeepFreeze_DamageAndStun(kv)
    local target = kv.target
    local caster = kv.caster
    local stun_name = kv.stun_name
    local ability = kv.ability
    local damage_multiplier = ability:GetLevelSpecialValueFor("damage_per_movespeed", ability:GetLevel()-1)

    local movespeed = target:GetIdealSpeed()
    local basemovespeed = target:GetBaseMoveSpeed()

    if movespeed < basemovespeed then
        ApplyDamage({
            victim = target,
            attacker = caster,
            damage = damage_multiplier * (basemovespeed - movespeed),
            damage_type = ability:GetAbilityDamageType(),
            ability = ability
        })
    end
    if movespeed <= 100 then
        ability:ApplyDataDrivenModifier(caster, target, stun_name, {})
    end
end

