modifier_flash_step_trace = class({})

function modifier_flash_step_trace:DeclareFunctions()
    local funcs = {

    }
    return funcs
end

function modifier_flash_step_trace:OnCreated()
    ParticleManager:CreateParticle("particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf", PATTACH_ABSORIGIN, self:GetParent())
end

function modifier_flash_step_trace:CheckState()
    local state = {
        [MODIFIER_STATE_INVULNERABLE]       = true,
        [MODIFIER_STATE_NO_HEALTH_BAR]      = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP]     = true,
        [MODIFIER_STATE_UNSELECTABLE]       = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_FROZEN]             = true,
        [MODIFIER_STATE_ROOTED]             = true
    }
    return state
end

if IsServer() then
    function modifier_flash_step_trace:OnDestroy()
        self:GetParent():RemoveSelf()
    end
end