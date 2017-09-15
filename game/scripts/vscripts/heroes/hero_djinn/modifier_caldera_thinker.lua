--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 06.07.2017
-- Time: 20:41
-- To change this template use File | Settings | File Templates.
--

modifier_caldera_thinker = class({})

function modifier_caldera_thinker:DeclareFunctions()
   local funcs = {

   }
   return funcs
end

function modifier_caldera_thinker:CheckState()
    local state = {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = 1
    }
    return state
end

function modifier_caldera_thinker:OnCreated()
    if IsServer() then
        self:StartIntervalThink(self:GetAbility():GetInterval())
    end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetAbility():GetRadius(), 0, 0))
end

function modifier_caldera_thinker:OnIntervalThink()
    local ability = self:GetAbility()
    local search_radius = ability:GetRadius() + ability:GetRingWidth()
    local loc = self:GetParent():GetAbsOrigin()
    local damage = ability:GetAbilityDamage() * ability:GetInterval()
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),
        loc,
        nil,
        search_radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false)
    for _, target in pairs(enemies) do
        if (loc - target:GetAbsOrigin()):Length2D() >= ability:GetRadius() then
            ApplyDamage({
                victim = target,
                attacker = self:GetCaster(),
                damage = damage,
                damage_type = ability:GetAbilityDamageType(),
                ability = ability
            })
        end
    end

    local allies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),
        loc,
        nil,
        search_radius,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_ALL,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false)
    for _, target in pairs(allies) do
        target:AddNewModifier(self:GetCaster(), ability, "modifier_caldera_buff", {duration = ability:GetInterval() * 2})
    end
end

--function modifier_caldera_thinker:GetAuraRadius()
--    return self:GetAbility():GetRadius()
--end
--
--function modifier_caldera_thinker:GetAuraSearchFlags()
--    return DOTA_UNIT_TARGET_FLAG_NONE
--end
--
--function modifier_caldera_thinker:GetAuraSearchTeam()
--    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
--end
--
--function modifier_caldera_thinker:GetAuraSearchType()
--    return DOTA_UNIT_TARGET_ALL
--end
--
--function modifier_caldera_thinker:GetModifierAura()
--    return "modifier_caldera_buff"
--end
--
--function modifier_caldera_thinker:GetAuraDuration()
--    return 0.1
--end

function modifier_caldera_thinker:OnDestroy()
    ParticleManager:DestroyParticle(self.particle, false)
    self:GetParent():RemoveSelf()
end