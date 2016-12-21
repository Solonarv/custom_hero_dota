require("heroes/hero_flicker/ascension")

flicker_flash_step = class({})

LinkLuaModifier("modifier_flash_step_charges", "heroes/hero_flicker/modifier_flash_step_charges.lua",  LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_flash_step_trace", "heroes/hero_flicker/modifier_flash_step_trace.lua", LUA_MODIFIER_MOTION_NONE)

function flicker_flash_step:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorPosition()

    local cLoc = caster:GetAbsOrigin()

    local diff = target - cLoc

    if diff:Length2D() > self:GetBlinkRange() then
        target = cLoc + diff:Normalized() * self:GetBlinkRange()
    end

    local trace = CreateUnitByName(caster:GetName(), cLoc, false, caster, nil, caster:GetTeamNumber())
    trace:AddNewModifier(caster, self, "modifier_flash_step_trace", {Duration = self:GetTraceDuration()})
    trace.time_created = GameRules:GetGameTime()
    trace.owner = caster

    caster:SetAbsOrigin(target)
    FindClearSpaceForUnit(caster, target, false)

    ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf", PATTACH_ABSORIGIN, caster)
    StartSoundEvent("Hero_PhantomAssassin.Strike.End", caster)
    if self.recall then
        self.recall:StartCooldown(self.recall:GetCooldown(1))
    end
end

function flicker_flash_step:OnUpgrade()
    local caster = self:GetCaster()
    local max_charges = self:GetMaxCharges()
    local charge_replenish_time = self:GetChargeRecoveryTime()

    local recall = caster:FindAbilityByName("flicker_recall")

    if recall then
        recall:SetLevel(1)
        self.recall = recall
    end

    if not caster:HasModifier("modifier_flash_step_charges") then
        caster:AddNewModifier(caster, self, "modifier_flash_step_charges", {})
    end
end

function flicker_flash_step:RestoreCharge(count, overmax)
    local caster = self:GetCaster()

    count = count or 1

    local max_charges = self:GetMaxCharges()
    local charge_replenish_time = self:GetChargeRecoveryTime()

    local new_charges = count + caster:GetModifierStackCount("modifier_flash_step_charges", caster)

    if (not overmax) and (new_charges > max_charges) then
        new_charges = max_charges
    end

    caster:SetModifierStackCount("modifier_flash_step_charges", ability, new_charges)

    self:EndCooldown()
    self:GetRecall():EndCooldown()

    caster:FindModifierByName("modifier_flash_step_charges"):Update()
end

function flicker_flash_step:GetSpecialValueFor(key)
    local val = self.BaseClass.GetSpecialValueFor(self, key)
    if key == "blink_range" then
       val = val * GetAscensionReachMultiplier(self:GetCaster())
   end
   return val
end


function flicker_flash_step:GetBlinkRange()
    return self:GetSpecialValueFor("blink_range")
end

function flicker_flash_step:GetChargeRecoveryTime()
    return self:GetSpecialValueFor("charge_restore_time")
end

function flicker_flash_step:GetMaxCharges()
    return self:GetSpecialValueFor("max_charges")
end

function flicker_flash_step:GetTraceDuration()
    return self:GetSpecialValueFor("trace_duration")
end

function flicker_flash_step:GetRecall()
    return self.recall
end