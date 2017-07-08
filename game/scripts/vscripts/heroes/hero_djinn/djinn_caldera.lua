--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 06.07.2017
-- Time: 20:40
-- To change this template use File | Settings | File Templates.
--

djinn_caldera = class({})

LinkLuaModifier("modifier_caldera_thinker", "heroes/hero_djinn/modifier_caldera_thinker.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_caldera_buff", "heroes/hero_djinn/modifier_caldera_buff.lua", LUA_MODIFIER_MOTION_NONE)

function djinn_caldera:OnSpellStart()
    local point = self:GetCursorPosition()
    local caster = self:GetCaster()
    local dummy = CreateUnitByName("npc_dota_thinker", point, false, caster, caster, caster:GetTeamNumber())
    dummy:AddNewModifier(caster, self, "modifier_caldera_thinker", {duration = self:GetDuration()})
    dummy:AddNewModifier(caster, self, "modifier_phased", {})
end

function djinn_caldera:GetInterval()
    return self:GetSpecialValueFor("interval")
end

function djinn_caldera:GetDuration()
    return self:GetSpecialValueFor("duration")
end

function djinn_caldera:GetRadius()
    return self:GetSpecialValueFor("radius")
end

function djinn_caldera:GetRingWidth()
    return self:GetSpecialValueFor("ring_width")
end

function djinn_caldera:GetCooldownReduction()
    return self:GetSpecialValueFor("cooldown_reduction")
end