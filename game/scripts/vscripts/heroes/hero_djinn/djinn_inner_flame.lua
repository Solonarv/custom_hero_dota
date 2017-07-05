--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 21:16
-- To change this template use File | Settings | File Templates.
--

djinn_inner_flame = class({})

LinkLuaModifier("modifier_inner_flame", "heroes/hero_djinn/modifier_inner_flame.lua", LUA_MODIFIER_MOTION_NONE)

function djinn_inner_flame:GetIntrinsicModifierName()
    return "modifier_inner_flame"
end

function djinn_inner_flame:GetInterval()
    return self:GetSpecialValueFor("regen_interval")
end

function djinn_inner_flame:GetMaxFlame()
    return self:GetSpecialValueFor("max_flame")
end

function djinn_inner_flame:GetRegenAtZero()
    return self:GetSpecialValueFor("regen_at_0")
end

function djinn_inner_flame:GetRegenAtMax()
    return self:GetSpecialValueFor("regen_at_max")
end