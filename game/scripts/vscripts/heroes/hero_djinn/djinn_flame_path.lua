--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 22:15
-- To change this template use File | Settings | File Templates.
--

djinn_flame_path = class({})

LinkLuaModifier("modifier_flame_path", "heroes/hero_djinn/modifier_flame_path.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_flame_path_thinker", "heroes/hero_djinn/modifier_flame_path_thinker.lua", LUA_MODIFIER_MOTION_NONE)

function djinn_flame_path:OnSpellStart()
    if IsServer() then
        CreateModifierThinker(self:GetCaster(), self, "modifier_flame_path_thinker", {duration = self:GetDuration(), damage = self:GetAbilityDamage()}, self:GetCursorPosition(), self:GetCaster():GetTeamNumber(), false)
    end
    -- spend flame
    self:GetCaster().flame = self:GetCaster().flame - self:GetFlameCost()

    local pos = self:GetCursorPosition()
    local particleName = "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf"
    local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, caster )
    ParticleManager:SetParticleControl( pfx, 0, pos )
    ParticleManager:SetParticleControl( pfx, 1, pos )
    ParticleManager:SetParticleControl( pfx, 2, Vector( self:GetDuration(), 0, 0 ) )
    ParticleManager:SetParticleControl( pfx, 3, pos )
end

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