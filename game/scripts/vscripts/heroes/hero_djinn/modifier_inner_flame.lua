--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 21:19
-- To change this template use File | Settings | File Templates.
--

modifier_inner_flame = class({})

function modifier_inner_flame:OnCreated(kv)
    self:GetCaster().flame = self:GetAbility():GetMaxFlame()
    self:StartIntervalThink(self:GetAbility():GetInterval())
end

function modifier_inner_flame:OnIntervalThink()
    if IsServer() then
        local ability = self:GetAbility()
        local regen_zero = ability:GetRegenAtZero()
        local regen_max = ability:GetRegenAtMax()
        local max_flame = ability:GetMaxFlame()
        local regen = (regen_zero + self:GetParent().flame * (regen_max - regen_zero) / max_flame) * ability:GetInterval()

        local intense_heat = self:GetParent():FindAbilityByName("djinn_intense_heat")
        if self:GetParent():HasModifier("modifier_intense_heat") and intense_heat then
            regen = regen * (1 + intense_heat:GetLevelSpecialValueFor("bonus_flame_regen", intense_heat:GetLevel()-1) / 100)
        end

        local new_flame = self:GetParent().flame + regen
        if new_flame > max_flame then
            new_flame = max_flame
        end
        self:GetParent().flame = new_flame
        self:SetStackCount(math.ceil(self:GetParent().flame))
    end
end

function modifier_inner_flame:GetFlameLevel()
    return self.flame / self:GetAbility():GetMaxFlame()
end