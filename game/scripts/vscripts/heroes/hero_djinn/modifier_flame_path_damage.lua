--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 28.07.2017
-- Time: 16:05
-- To change this template use File | Settings | File Templates.
--


modifier_flame_path_damage = class({})

if IsServer() then

    function modifier_flame_path_damage:OnCreated()
        self.ability = self:GetAbility()
        self.interval = self.ability:GetInterval()
        self.damage = self.interval * self.ability:GetAbilityDamage()
        self:StartIntervalThink(self.interval)
    end

    function modifier_flame_path_damage:OnIntervalThink()
        ApplyDamage({
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = self.damage,
            damage_type = self.ability:GetAbilityDamageType(),
            ability = self.ability
        })
    end

end