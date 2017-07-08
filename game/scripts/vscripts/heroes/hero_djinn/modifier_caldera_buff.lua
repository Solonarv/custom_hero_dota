--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 06.07.2017
-- Time: 20:42
-- To change this template use File | Settings | File Templates.
--

modifier_caldera_buff = class({})


 -- Note: This modifier correctly provides Ember Might's attack damage and spell amp, but they are not displayed.
function modifier_caldera_buff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE_STACKING,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
    return funcs
end

function modifier_caldera_buff:IsAura()
    return false --true
end

function modifier_caldera_buff:IsPurgable()
    return false
end

function modifier_caldera_buff:GetModifierPercentageCooldownStacking()
    return self:GetAbility():GetCooldownReduction()
end

function modifier_caldera_buff:GetModifierPreAttack_BonusDamage()
    local ember_might = self:GetEmberMight()
    if ember_might then
        return ember_might:GetModifierPreAttack_BonusDamage()
    end
    return 0
end

function modifier_caldera_buff:GetModifierSpellAmplify_Percentage()
    local ember_might = self:GetEmberMight()
    if ember_might then
        return ember_might:GetModifierSpellAmplify_Percentage()
    end
    return 0
end

function modifier_caldera_buff:GetEmberMight()
    if IsServer() then
        if self.ember_might == nil then
            local ember_might = self:GetCaster():FindModifierByName("modifier_ember_might")
            if ember_might then
                self.ember_might = ember_might
            else
                self.ember_might = false
            end
        end
    end
    return self.ember_might
end

