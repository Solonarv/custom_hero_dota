--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 12/25/2016
-- Time: 11:29 PM
-- To change this template use File | Settings | File Templates.
--

modifier_essence_split = class({})

function modifier_essence_split:DeclareFunctions()
    local funcs = {

    }
    return funcs
end

function modifier_essence_split:CheckState()
    local states = {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_STUNNED]= true
    }
    return states
end

function modifier_essence_split:IsHidden()
    return true
end

function modifier_essence_split:OnCreated(kv)
    local ability = self:GetAbility()
    self.interval = ability:GetInterval()
    self.traveled_distance = 0
    self.distance = kv.distance
    self.distance_per_tick = ability:GetSpeed() / self.interval
end

function modifier_essence_split:OnIntervalThink()
    local unit = self:GetParent()

    if unit:HasModifier("modifier_fractal_rush") then
        unit:RemoveModifierByName("modifier_essence_split")
    else
        if self.traveled_distance < self.distance then
            unit:SetAbsOrigin(unit:GetAbsOrigin() + self.direction * self.distance_per_tick)
            self.traveled_distance = self.distance + self.distance_per_tick
        else
            unit:RemoveModifierByName("modifier_essence_split")
        end
    end
end

function modifier_essence_split:GetEffectName()
    return "particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf"
end

function modifier_essence_split:GetEffectAttachType()
    return "follow_origin"
end