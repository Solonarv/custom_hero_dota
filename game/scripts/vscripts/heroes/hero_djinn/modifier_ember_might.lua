--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 05.07.2017
-- Time: 04:15
-- To change this template use File | Settings | File Templates.
--

modifier_ember_might = class({})

function modifier_ember_might:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
    return funcs
end

function modifier_ember_might:GetModifierSpellAmplify_Percentage()
    return self:GetFlame() * self:GetAbility():GetSpellAmpPer10() / 10
end

function modifier_ember_might:GetModifierPreAttack_BonusDamage()
    return self:GetFlame() * self:GetAbility():GetAttackDamagePer10() / 10
end

function modifier_ember_might:GetFlame()
    return self:GetParent().flame or 0
end

function modifier_ember_might:IsHidden()
    return true
end

function modifier_ember_might:IsPurgable()
    return false
end