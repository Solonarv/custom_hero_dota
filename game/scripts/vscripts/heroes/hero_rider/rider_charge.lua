--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 9/15/2017
-- Time: 1:26 AM
-- To change this template use File | Settings | File Templates.
--

LinkLuaModifier("modifier_rider_charge", "heroes/hero_rider/rider_charge.lua", MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rider_charge_dummy", "heroes/hero_rider/rider_charge.lua", MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rider_charge_stun", "heroes/hero_rider/rider_charge.lua", MODIFIER_MOTION_NONE)

rider_charge = class({})

function rider_charge:OnSpellStart()
    local caster = self:GetCaster()
    local modArgs = {
        Duration = self:GetDuration(),
        stunDuration = self:GetStunDuration(),
        damage = self:GetAbilityDamage(),
        collisionRadius = self:GetCollisionRadius(),
        fullSpeedAngle = self:GetFullSpeedAngle(),
        halfSpeedAngle = self:GetHalfSpeedAngle(),
        speedBonus = self:GetSpeedBonus(),
        speedDetectionRadis = self:GetSpeedDetectionRadius()
    }
    caster:AddNewModifier(caster, self, "modifier_rider_charge", modArgs)
end


modifier_rider_charge = class({})

function modifier_rider_charge:OnCreated(kv)
    self.stunDuration = kv.stunDuration
    self.damage = kv.damage
    self.collisionRadius = kv.collisionRadius
    self.fullSpeedAngleCos = Math.cos(kv.fullSpeedAngle)
    self.halfSpeedAngleCos = Math.cos(kv.halfSpeedAngle)
    self.speedBonus = kv.speedBonus
    self.speedDetectionRadius = kv.speedDetectionRadius

    self:OnIntervalThink()
    self:StartIntervalThink(0.2)
end

function modifier_rider_charge:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
    return funcs
end

function modifier_rider_charge:OnIntervalThink()
    local bonus = 0
    local myFacing = self:GetParent():GetForwardVector()
    myFacing.y = 0
    myFacing = myFacing:Normalized()
    local myLoc = self:GetParent():GetAbsOrigin()
    local heroes = FindUnitsInRadius(self:GetParent():GetTeamNumber(),
        self:GetParent():GetAbsOrigin(),
        nil,
        self.speedDetectionRadius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false)
    for _, hero in pairs(heroes) do
        local towards = hero:GetAbsOrigin() - myLoc
        towards.y = 0
        towards = towards:Normalized()
        local dot = towards:Dot(myFacing)
        if dot >= self.fullSpeedAngleCos then
            bonus = self.speedBonus
        elseif dot >= self.halfSpeedAngleCos and bonus < self.speedBonus then
            bonus = self.speedBonus / 2
        end
    end
    self.actualBonusSpeed = bonus
end

function modifier_rider_charge:OnCollision(victim)
    if self.hasImpacted then return end
    local ability = self:GetAbility()
    local caster = self:GetCaster()
    ApplyDamage({
        victim = victim,
        attacker = caster,
        damage = self.damage,
        damage_type = ability:GetAbilityDamageType(),
        ability = ability
    })
    local myLoc = self:GetCaster():GetAbsOrigin()
    local vLoc = victim:GetAbsOrigin()
    local center = (myLoc + vLoc) / 2
    local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(),
        center,
        nil,
        self.collisionRadius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false)
    for _, enemy in pairs(enemies) do
        enemy:AddNewModifier(caster, ability, "modifier_rider_charge_stun", {Duration = self.stunDuration})
    end
    self:Destroy()
end

function modifier_rider_charge:GetModifierMoveSpeedBonus_Percentage()
    -- recalculated every 0.2s
    return self.actualSpeedBonus
end

function modifier_rider_charge:IsAura()
    return true
end

function modifier_rider_charge:GetModifierAura()
    return "modifier_rider_charge_dummy"
end

function modifier_rider_charge:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_rider_charge:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_rider_charge:GetAuraRadius()
    return self.collisionRadius
end

modifier_rider_charge_dummy = class({})

function modifier_rider_charge_dummy:OnCreated(kv)
    local creatorMod = kv.caster:GetModifierByName("modifier_rider_charge")
    creatorMod:OnCollision(self:GetParent())
end

modifier_rider_charge_stun = class({})

function modifier_rider_charge_stun:CheckState()
    local state = {
            [MODIFIER_STATE_STUNNED] = true
    }
    return state
end

function modifier_rider_charge_stun:IsDebuff()
    return true
end

function modifier_rider_charge_stun:IsStunDebuff()
    return true
end

function modifier_rider_charge_stun:GetEffectName()
    return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_rider_charge_stun:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_rider_charge_stun:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
    return funcs
end

function modifier_rider_charge_stun:GetOverrideAnimation( params )
    return ACT_DOTA_DISABLED
end