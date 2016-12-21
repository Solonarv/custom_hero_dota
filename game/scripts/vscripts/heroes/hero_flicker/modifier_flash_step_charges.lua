--[[

Made by DoctorGester, found on the moddota forums.

http://moddota.com/forums/discussion/1205/making-any-ability-use-charges

Modified by Solonarv for updatable instances.

--]]

modifier_flash_step_charges = class({})

function modifier_flash_step_charges:Update()
    if self:GetDuration() == -1 then
        local rec_time = self:GetAbility():GetChargeRecoveryTime()
        self:SetDuration(rec_time, true)
        self:StartIntervalThink(rec_time)
    end

    if self:GetStackCount() == 0 then
        self:GetAbility():EndCooldown()
        self:GetAbility():GetRecall():EndCooldown()
        self:GetAbility():StartCooldown(self:GetRemainingTime())
        if not self:GetParent():HasModifier("modifier_ascension") then
            self:GetAbility():GetRecall():StartCooldown(self:GetRemainingTime())
        end
    end
end

function modifier_flash_step_charges:OnCreated(kv)
    self:SetStackCount(self:GetAbility():GetMaxCharges())
end

function modifier_flash_step_charges:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED
    }
    return funcs
end

function modifier_flash_step_charges:OnAbilityExecuted(params)
    if params.unit == self:GetParent() then
        local ability = params.ability

        if (ability == self:GetAbility()) or (ability == self:GetAbility():GetRecall() and not self:GetParent():HasModifier("modifier_ascension")) then
            self:DecrementStackCount()
            self:Update()
        end
    end

    return 0
end

function modifier_flash_step_charges:OnIntervalThink()
    local stacks = self:GetStackCount()

    if stacks < self:GetAbility():GetMaxCharges() then
        self:SetDuration(self:GetAbility():GetChargeRecoveryTime(), true)
        self:IncrementStackCount()

        if stacks == self:GetAbility():GetMaxCharges() - 1 then
            self:SetDuration(-1, true)
            self:StartIntervalThink(-1)
        end
    end
end

function modifier_flash_step_charges:DestroyOnExpire()
    return false
end

function modifier_flash_step_charges:IsPurgable()
    return false
end

function modifier_flash_step_charges:RemoveOnDeath()
    return false
end