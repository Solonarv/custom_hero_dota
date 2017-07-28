--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 22:47
-- To change this template use File | Settings | File Templates.
--

modifier_flame_path_thinker = class({})

LinkLuaModifier("modifier_flame_path_speed", "heroes/hero_djinn/modifier_flame_path_speed.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_flame_path_damage", "heroes/hero_djinn/modifier_flame_path_damage.lua", LUA_MODIFIER_MOTION_NONE)

function modifier_flame_path_thinker:OnCreated(_)
    if IsServer() then
        -- Snapshot values so that older flame patches aren't upgraded when the ability is levelled up
        self.movespeed_bonus = self:GetAbility():GetMovespeedBonus()
        self.interval = self:GetAbility():GetInterval()
        self.radius = self:GetAbility():GetRadius()

        self:StartIntervalThink(self.interval)
        self:OnIntervalThink() -- trigger the interval function manually so effects apply instantly

        self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_djinn/djinn_flame_path.vpcf", PATTACH_WORLDORIGIN, self:GetAbility():GetCaster())
        ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.radius, 0, 0))
    end
end

function modifier_flame_path_thinker:OnIntervalThink()
    local thinkerPos = self:GetParent():GetAbsOrigin()
    local casterPos = self:GetCaster():GetAbsOrigin()
    if (thinkerPos - casterPos):Length2D() <= self.radius then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_flame_path_speed", {movespeed_bonus = self.movespeed_bonus})
    end
end

function modifier_flame_path_thinker:OnDestroy()
    ParticleManager:DestroyParticle(self.pfx, false)
end

function modifier_flame_path_thinker:IsAura()
    return true
end

function modifier_flame_path_thinker:GetModifierAura()
    return "modifier_flame_path_damage"
end

function modifier_flame_path_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_flame_path_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_flame_path_thinker:GetAuraRadius()
    return self.radius
end