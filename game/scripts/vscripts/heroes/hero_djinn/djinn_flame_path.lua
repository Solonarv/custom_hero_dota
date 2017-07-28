--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 22:15
-- To change this template use File | Settings | File Templates.
--

djinn_flame_path = class({})

LinkLuaModifier("modifier_flame_path_thinker", "heroes/hero_djinn/modifier_flame_path_thinker.lua", LUA_MODIFIER_MOTION_NONE)

function djinn_flame_path:OnSpellStart()
    -- spend flame
    self:GetCaster().flame = self:GetCaster().flame - self:GetFlameCost()

    local pos = self:GetCursorPosition()
    local caster = self:GetCaster()
    local radius = self:GetRadius()
    local duration = self:GetDuration()

    local dummy = CreateUnitByName("npc_dota_thinker", pos, false, caster, caster, caster:GetTeamNumber())
    dummy:AddNewModifier(caster, self, "modifier_flame_path_thinker", {duration = duration})
    dummy:AddNewModifier(caster, self, "modifier_phased", {})
end

--function djinn_flame_path:OnAbilityPhaseStart()
--    if not self:CanAffordFlame() then
--        print("Can't afford flame, interrupting")
--        self:GetCaster():Interrupt()
--    end
--end

function djinn_flame_path:CastFilterResultLocation(hLoc)
    if self:CanAffordFlame() then
        return self.BaseClass.CastFilterResultLocation(self, hLoc)
    else
        return UF_FAIL_CUSTOM
    end
end

function djinn_flame_path:GetCustomCastErrorLocation(hLoc)
    if self:CanAffordFlame() then
        return self.BaseClass.GetCustomCastErrorLocation(self, hLoc)
    else
        return "#dota_hud_error_not_enough_flame"
    end
end

function djinn_flame_path:CanAffordFlame()
    local flame_cost = self:GetFlameCost()
    return self:GetCaster().flame and self:GetCaster().flame >= flame_cost
end

function djinn_flame_path:GetRadius()
    return self:GetSpecialValueFor("radius")
end

function djinn_flame_path:GetFlameCost()
    return self:GetSpecialValueFor("flame_cost")
end

function djinn_flame_path:GetMovespeedBonus()
    return self:GetSpecialValueFor("movespeed_bonus")
end

function djinn_flame_path:GetInterval()
    return self:GetSpecialValueFor("interval")
end

function djinn_flame_path:GetDuration()
    return self:GetSpecialValueFor("duration")
end