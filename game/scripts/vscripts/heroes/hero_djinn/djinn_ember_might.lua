--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 05.07.2017
-- Time: 04:13
-- To change this template use File | Settings | File Templates.
--

djinn_ember_might = class({})

LinkLuaModifier("modifier_ember_might", "heroes/hero_djinn/modifier_ember_might.lua", LUA_MODIFIER_MOTION_NONE)

function djinn_ember_might:GetIntrinsicModifierName()
    return "modifier_ember_might"
end

function djinn_ember_might:GetSpellAmpPer10()
    return self:GetSpecialValueFor("spellamp_per_10")
end

function djinn_ember_might:GetAttackDamagePer10()
    return self:GetSpecialValueFor("attack_per_10")
end