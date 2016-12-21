function ShrapnelShot(event)
    local ability = event.ability
    local caster = event.caster
    local target = event.target
    local fwd = caster:GetForwardVector():Normalized()
    local casterpos = caster:GetAbsOrigin()
    local targetpos = target:GetAbsOrigin()

    local delta = targetpos - casterpos

    print(tostring(fwd))
    print(tostring(delta:Normalized()))
    print(math.cos(event.angle / 360 * 2 * math.pi))
    print(fwd:Dot(delta:Normalized()))

    if fwd:Dot(delta:Normalized()) >= math.cos(event.angle / 360 * 2 * math.pi) then
        ApplyDamage({
            victim = target,
            attacker = caster,
            damage = ability:GetAbilityDamage(),
            damage_type = ability:GetAbilityDamageType(),
            ability = ability
        })

        if delta:Length2D() <= event.stun_range then
            ability:ApplyDataDrivenModifier(caster, target, "modifier_shrapnel_shot_stun", {duration = event.duration})
        end
    end
end