require("heroes/hero_flicker/ascension")

flicker_rapid_strike = class({})

LinkLuaModifier("modifier_rapid_strike", "heroes/hero_flicker/modifier_rapid_strike.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rapid_strike_target", "heroes/hero_flicker/modifier_rapid_strike_target.lua", LUA_MODIFIER_MOTION_NONE)

function flicker_rapid_strike:OnSpellStart()
    local target = self:GetCursorTarget()
    target:AddNewModifier(self:GetCaster(), self, "modifier_rapid_strike_target", {})
    self:GetCaster().rapid_strike_target = target
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_rapid_strike", {})
end

function flicker_rapid_strike:GetBaseAttackTime()
    return self:GetSpecialValueFor("base_attack_time")
end

function flicker_rapid_strike:GetAttackCount()
    return self:GetSpecialValueFor("attack_count")
end

function flicker_rapid_strike:GetCastRange(vLocation, hTarget)
    return self.BaseClass.GetCastRange(self, vLocation, hTarget) * GetAscensionReachMultiplier(self:GetCaster())
end