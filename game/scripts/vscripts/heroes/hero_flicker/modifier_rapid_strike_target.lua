modifier_rapid_strike_target = class({})

function modifier_rapid_strike_target:OnDestroy()
    local caster = self:GetAbility():GetCaster()
    caster:RemoveModifierByName("modifier_rapid_strike")
end

function modifier_rapid_strike_target:IsHidden()
    return true
end

function modifier_rapid_strike_target:IsPurgable()
    return false
end