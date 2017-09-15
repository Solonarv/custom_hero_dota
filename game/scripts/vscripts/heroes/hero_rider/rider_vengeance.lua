--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 9/15/2017
-- Time: 2:38 AM
-- To change this template use File | Settings | File Templates.
--

LinkLuaModifier("modifier_rider_vengeance_aura", "heroes/hero_rider/rider_vengeance.lua", MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rider_vengeance_passive", "heroes/hero_rider/rider_vengeance.lua", MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rider_vengeance_instance", "heroes/hero_rider/rider_vengeance.lua", MODIFIER_MOTION_NONE)

rider_vengeance = class({})

function rider_vengeance:GetIntrinsicModifierName()
    return "modifier_rider_vengeance_passive"
end

modifier_rider_vengeance_passive = class({})

modifier_rider_vengeance_aura = class({})

function modifier_rider_vengeance_aura:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end

function modifier_rider_vengeance_aura:OnTakeDamage(kv)
    local ability = self:GetAbility()
    local rider = self:GetCaster()
    local myTeam = rider:GetTeamNumber()
    local victim = self:GetParent()
    local attacker = kv.attacker

    if victim == kv.victim and myTeam ~= attacker:GetTeamNumber() and bit.band(kv.flags, DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_HPLOSS) == 0 then
        local damage = kv.original_damage
        local echo_damage = damage * ability:GetEchoDamageRatio()
        local attack_damage = damage * ability:GetAttackDamageRatio()
        local modTable = {
            Duration = ability:GetDuration(),
            damage = {
                damage = echo_damage,
                damage_type = kv.damage_type,
                flags = kv.damage_flags,
            },
            bonus_damage = attack_damage,
            starting_location = victim:GetAbsOrigin(),
            attacker = attacker,
            victim = victim
        }
        rider:AddNewModifier(rider, ability, "modifier_rider_vengeance_instance", modTable)
    end
end