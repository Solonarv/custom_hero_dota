modifier_rapid_strike = class({})

function modifier_rapid_strike:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT
    }
    return funcs
end

function modifier_rapid_strike:GetModifierBaseAttackTimeConstant()
    return self:GetAbility():GetBaseAttackTime()
end

function modifier_rapid_strike:CheckState()
    local state = {
        [MODIFIER_STATE_INVULNERABLE]       = true,
        [MODIFIER_STATE_NO_HEALTH_BAR]      = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
        [MODIFIER_STATE_SILENCED]           = true,
        [MODIFIER_STATE_ROOTED]             = true,
        [MODIFIER_STATE_UNSELECTABLE]       = true
    }
    return state
end

function modifier_rapid_strike:OnCreated(kv)
    if IsServer() then
        self.target = self:GetParent().rapid_strike_target
        self.attacks = 0
        self.old_loc = self:GetParent():GetAbsOrigin()
        self:Teleport()
        self:GetParent():MoveToTargetToAttack(self.target)
        --self:StartIntervalThink(1 / self:GetParent():GetAttacksPerSecond())
    end
end

function modifier_rapid_strike:OnAttackLanded(kv)
    if IsServer() then
        if kv.attacker == self:GetParent() then
            self.attacks = self.attacks + 1
            if self.attacks < self:GetAbility():GetAttackCount() then
                self:Teleport()
            else
                self:GetParent():RemoveModifierByNameAndCaster("modifier_rapid_strike", self:GetCaster())
            end

            if self.attacks < self:GetAbility():GetAttackCount() - 1 then
                self:StartIntervalThink(1 / self:GetParent():GetAttacksPerSecond())
            end

        end
    end
end

function modifier_rapid_strike:Teleport()
    if IsServer() then
        local parent = self:GetParent()
        local a_loc = parent:GetOrigin()
        local t_loc = self.target:GetOrigin()
        local dist = parent:GetAttackRange() --+ parent:BoundingRadius2D() + self.target:BoundingRadius2D()

        local new_dir = (a_loc - t_loc):Normalized()
        local new_dir = RotatePosition(new_dir, QAngle(0, RandomFloat(-20, 20) + RandomFloat(-20, 20) + RandomFloat(-20, 20), 0), Vector(0, 0, 0)) - new_dir        local new_pos = t_loc + new_dir * dist --* 0.8

        FindClearSpaceForUnit(self:GetParent(), new_pos, false)
    end
end

function modifier_rapid_strike:OnDestroy()
    local caster = self:GetParent()

    if IsServer() then
        FindClearSpaceForUnit(caster, self.old_loc, false)

        caster:Stop()
    end

    caster.rapid_strike_target = nil
end