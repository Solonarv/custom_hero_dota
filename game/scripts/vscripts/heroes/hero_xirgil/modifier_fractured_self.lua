--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 12/24/2016
-- Time: 10:01 AM
-- To change this template use File | Settings | File Templates.
--

modifier_fractured_self = class({})

function modifier_fractured_self:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        MODIFIER_PROPERTY_IS_ILLUSION,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED
    }
    return funcs
end

function modifier_fractured_self:OnCreated()
    self.isShadow = self:GetParent() == self:GetOwner()
end

function modifier_fractured_self:GetDisableAutoAttack()
    return self.isShadow
end

function modifier_fractured_self:GetIsIllusion()
    return self.isShadow
end

function modifier_fractured_self:GetModifierDamageOutgoing_Percentage_Illusion()
    return self.isShadow and 0 or 1
end

function modifier_fractured_self:OnAbilityExecuted(kv)
    local parent = self:GetParent()
    local ability = kv.ability
    local shadows = self:GetAbility():GetShadows()
    for _, u in pairs(shadows) do
        if u ~= parent then
            local ability_shadow = u:FindAbilityByName()
            ability_shadow:EndCooldown()
            ability_shadow:StartCooldown(ability:GetCooldownTimeRemaining())
        end
    end
end

function modifier_fractured_self:OnDestroy()
    if self.isShadow then
        self:GetParent():RemoveSelf()
    end
end