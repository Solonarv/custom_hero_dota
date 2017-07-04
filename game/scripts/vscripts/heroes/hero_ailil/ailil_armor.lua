ailil_armor = class({})

LinkLuaModifier("modifier_ailil_armor", "heroes/hero_ailil/modifier_ailil_armor.lua", LUA_MODIFIER_MOTION_NONE)


function ailil_armor:OnSpellStart()
    local mod = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_ailil_armor", {duration = self:GetDuration()})
    mod:SetStackCount(self:GetInstances())
end

function ailil_armor:GetInstances()
    return self:GetSpecialValueFor("instances")
end

function ailil_armor:GetDuration()
    return self:GetSpecialValueFor("duration")
end

function ailil_armor:GetDamageThreshold()
    return self:GetSpecialValueFor("damage_threshold")
end