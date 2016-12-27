--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 12/24/2016
-- Time: 10:39 AM
-- To change this template use File | Settings | File Templates.
--

xirgil_fractured_self = class({})

LinkLuaModifier("modifier_fractured_self", "heroes/hero_xirgil/modifier_fractured_self.lua", LUA_MODIFIER_MOTION_NONE)

function xirgil_fractured_self:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    if target == nil then
        local vLoc = self:GetCursorTargetLocation()

        target = self:FindClosestShadow(vLoc)
    end

    if target ~= nil then
        local targetpos = target:GetAbsOrigin()
        local casterpos = caster:GetAbsOrigin()

        FindClearSpaceForUnit(caster, targetpos, false)
        FindClearSpaceForUnit(target, casterpos, false)

--        caster:SetAngles(targetangles.x, targetangles.y, targetangles.z)
--        target:SetAngles(casterangles.x,casterangles.y, casterangles.z)
    end
end

function xirgil_fractured_self:GetShadows()
    local owner =  self:GetCaster().owner
    owner.shadows = owner.shadows or {}
    return owner.shadows
end

function xirgil_fractured_self:GetSearchRadius()
    return self:GetSpecialValueFor("search_radius")
end

function xirgil_fractured_self:FindClosestShadow(vLoc)
    local allies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(),
                                    vLoc,
                                    nil,
                                    self:GetSearchRadius(),
                                    DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                    DOTA_UNIT_TARGET_HERO,
                                    DOTA_UNIT_TARGET_FLAG_NONE,
                                    FIND_CLOSEST,
                                    false ) or {}

    local player = self:GetCaster():GetMainControllingPlayer()
    for _, v in pairs(allies) do
        if v and v:HasModifier("modifier_fractured_self") and (v:GetMainControllingPlayer() == player) then
            return v
        end
    end
end

function xirgil_fractured_self:GetIntrinsicModifierName()
    return "modifier_fractured_self"
end

function xirgil_fractured_self:CastFilterResultLocation(vLoc)
    if self:FindClosestShadow(vLoc) ~= nil then
        return UF_SUCCESS
    else
        return UF_FAIL_CUSTOM
    end
end

function xirgil_fractured_self:GetCustomCastErrorLocation()
    return "#dota_hud_error_no_target"
end

function xirgil_fractured_self:MakeShadow(duration)
    local caster = self:GetCaster()
    local shadow = CreateUnitByName(caster:GetUnitName(), caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
    shadow:SetControllableByPlayer(caster:GetMainControllingPlayer(), true)
    local mod = shadow:FindModifierByName("modifier_fractured_self")
    mod:SetDuration(duration, true)
    mod.isShadow = true
    local xirgil = caster.owner
    xirgil.shadows = xirgil.shadows or {}
    table.insert(xirgil.shadows, shadow)
    shadow.owner = xirgil
    return shadow
end