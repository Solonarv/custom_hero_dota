function SpiritBleed_OnTick(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    local path_width = ability:GetLevelSpecialValueFor("path_width", ability:GetLevel())
    local path_duration = ability:GetLevelSpecialValueFor("path_duration", ability:GetLevel())

    ProjectileManager:CreateLinearProjectile({
        Ability = ability,
        EffectName = "particles/units/heroes/hero_spectre/spectre_shadow_path.vpcf",
        vSpawnOrigin = target:GetAbsOrigin(),
        fDistance = path_width,
        fStartRadius = path_width,
        fEndRadius = path_width,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam     = DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        iUnitTargetFlags    = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType     = DOTA_UNIT_TARGET_HERO,
        fExpireTime = GameRules:GetGameTime() + path_duration,
        bDeleteOnHit = false,
        vVelocity = Vector(0, 0, 0),
        bProvidesVision = false
        })
end

function SpiritBleed_CheckRange(event)
    local caster = event.caster
    local ability = event.ability
    local target = event.target
    local buff_duration = event.buff_duration
    local buff = event.buff

    if caster:GetPlayerID() == target:GetPlayerID()  then
        ability:ApplyDataDrivenModifier(caster, caster, buff, {Duration = buff_duration})
    end
end

function SpiritBleed_OnMove(event)
    local target = event.target
    local targetpos = target:GetAbsOrigin()
    local ability = event.ability
    local mana_per_100 = ability:GetLevelSpecialValueFor("mana_gain", ability:GetLevel()) / 100

    if target.last_position ~= nil then
        local dist = (targetpos - target.last_position):Length2D()
        local mana = dist * mana_per_100
        target:GiveMana(dist * mana_per_100)
    end
    target.last_position = targetpos

end

function SpiritBleed_RemovePosTracker(event)
    event.target.last_position = nil
end