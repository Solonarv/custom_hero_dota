--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 22:47
-- To change this template use File | Settings | File Templates.
--

modifier_flame_path_thinker = class({})

function modifier_flame_path_thinker:OnCreated(kv)
    if IsServer() then
        -- Snapshot values so that older flame patches aren't upgraded when the ability is levelled up
        self.movespeed_bonus = self:GetAbility():GetMovespeedBonus()
        self.interval = self:GetAbility():GetInterval()
        self.radius = self:GetAbility():GetRadius()
        self.damage = kv.damage * self.interval

        self:StartIntervalThink(self.interval)
        self:OnIntervalThink() -- trigger the interval function manually so effects apply instantly
    end
end

function modifier_flame_path_thinker:OnIntervalThink()
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),
                        self:GetParent():GetAbsOrigin(),
                        nil,
                        self.radius,
                        DOTA_UNIT_TARGET_TEAM_ENEMY,
                        DOTA_UNIT_TARGET_ALL,
                        DOTA_UNIT_TARGET_FLAG_NONE,
                        FIND_ANY_ORDER,
                        false)
    for _, target in pairs(enemies) do
        ApplyDamage({
            victim = target,
            attacker = self:GetCaster(),
            damage = self.damage,
            damage_type = self:GetAbility():GetAbilityDamageType(),
            ability = self:GetAbility()
        })
    end
    local thinkerPos = self:GetParent():GetAbsOrigin()
    local casterPos = self:GetCaster():GetAbsOrigin()
    if (thinkerPos - casterPos):Length2D() <= self.radius then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_flame_path", {movespeed_bonus = self.movespeed_bonus})
    end
end