function CheckMana(event)
    local caster = event.caster
    local threshold = event.threshold
    local mod = event.modifier

    if caster:GetMana() < threshold then
        caster:RemoveModifierByName(mod)
    end
end