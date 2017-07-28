--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 22:25
-- To change this template use File | Settings | File Templates.
--

modifier_flame_path_speed = class({})

function modifier_flame_path_speed:DeclareFunctions()
    local funcs = {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
        }
    return funcs
end

function modifier_flame_path_speed:OnCreated(kv)
    if IsServer() then
        self.movespeed_bonus = kv.movespeed_bonus
        self.removeOnNextInterval = 3
        self:StartIntervalThink(self:GetAbility():GetInterval())
    end
end

function modifier_flame_path_speed:OnRefresh(_)
--    if kv.movespeed_bonus > self.movespeed_bonus then
--        self.movespeed_bonus = kv.movespeed_bonus
--    end
    self.removeOnNextInterval = 3
end

function modifier_flame_path_speed:OnIntervalThink()
    if self.removeOnNextInterval <= 0 then
        self:Destroy()
    else
        self.removeOnNextInterval = self.removeOnNextInterval - 1
    end
end

function modifier_flame_path_speed:GetModifierMoveSpeedBonus_Percentage()
    return self.movespeed_bonus
end

function modifier_flame_path_speed:IsDebuff()
    return false
end

function modifier_flame_path_speed:IsPurgable()
    return false
end