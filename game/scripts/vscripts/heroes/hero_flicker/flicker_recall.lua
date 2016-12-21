flicker_recall = class({})

function flicker_recall:OnSpellStart()
    local caster = self:GetCaster()
    local allies = FindUnitsInRadius( caster:GetTeamNumber(),
                                      caster:GetAbsOrigin(),
                                      nil,
                                      FIND_UNITS_EVERYWHERE,
                                      DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                      DOTA_UNIT_TARGET_HERO,
                                      DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
                                      FIND_ANY_ORDER,
                                      false )

    local newest = -1
    local trace = nil

    for _, v in pairs(allies) do
        if v:HasModifier("modifier_flash_step_trace") and (v.owner == caster) and (v.time_created ~= nil) and v.time_created > newest then
            newest = v.time_created
            trace = v
        end
    end

    if trace then
        local pos = trace:GetAbsOrigin()

        trace:RemoveSelf()

        caster:SetAbsOrigin(pos)
        FindClearSpaceForUnit(caster, pos, false)
        ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf", PATTACH_ABSORIGIN, caster)
        StartSoundEvent("Hero_PhantomAssassin.Strike.End", caster)
        flash_step = caster:FindAbilityByName("flicker_flash_step")
        if flash_step then
            flash_step:StartCooldown(flash_step:GetCooldown(flash_step:GetLevel() - 1))
        end
    else
        self:EndCooldown()
        self:RefundManaCost()
    end
end


function flicker_recall:CastFilterResult()
    local caster = self:GetCaster()
    local allies = FindUnitsInRadius( caster:GetTeamNumber(),
                                      caster:GetAbsOrigin(),
                                      nil,
                                      FIND_UNITS_EVERYWHERE,
                                      DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                      DOTA_UNIT_TARGET_HERO,
                                      DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
                                      FIND_ANY_ORDER,
                                      false )
    for _, v in pairs(allies) do
        if v:HasModifier("modifier_flash_step_trace") and (v.owner == caster) and (v.time_created ~= nil) then
            return UF_SUCCESS
        end
    end
    return UF_FAIL_CUSTOM
end

function flicker_recall:GetCustomCastError()
    return "#dota_hud_error_no_target"
end