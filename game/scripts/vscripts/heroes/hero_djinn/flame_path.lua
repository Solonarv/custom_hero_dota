--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 05.07.2017
-- Time: 01:10
-- To change this template use File | Settings | File Templates.
--

function CheckFlameCost(kv)
    if not kv.caster.flame or kv.caster.flame < kv.flame_cost then
        kv.caster:Interrupt()
    end
end

function CreateFlamePatch(kv)
    local ability = kv.ability
    local caster = kv.caster
    local point = kv.target_points[1]
    caster.flame = caster.flame - kv.flame_cost

    local emptyParticle = "particles/dev/empty_particle.vpcf"

    local endTime = GameRules:GetGameTime() + kv.duration

    local pfx = ParticleManager:CreateParticle(kv.particle, PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:SetParticleControl(pfx, 1, Vector(kv.radius, 0, 0))
--    print("Created Flame Path particle: "..pfx)

    local proj = ProjectileManager:CreateLinearProjectile({
        Ability = ability,
        EffectName = emptyParticle,
        vSpawnOrigin = point,
        fDistance = 64,
        fStartRadius = kv.radius,
        fEndRadius = kv.radius,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_ALL,
        fExpireTime = endTime,
        bDeleteOnHit = false,
        vVelocity = Vector(0, 0, 0), -- stay in place
        bProvidesVision = false
    })

    local dummy = CreateUnitByName("npc_dota_thinker", point, false, caster, caster, caster:GetTeamNumber())
    ability:ApplyDataDrivenModifier(caster, dummy, kv.thinker_modifier, {})
    ability:ApplyDataDrivenModifier(caster, dummy, "modifier_phased", {})

    ability.flame_patches = ability.flame_patches or {}
    ability.flame_patches[proj] = {
        projectile = proj,
        particle = pfx,
        location = point,
        radius = kv.radius,
        thinker  = dummy
    }
end

function TickDamageAndCheckRange(kv)
    local damage = kv.interval * kv.damage
    local tPos = kv.target:GetOrigin()
    local inRange = false
    for _, patch in pairs(kv.ability.flame_patches) do
        if (tPos - patch.location):Length2D() <= patch.radius then
            inRange = true
        end
    end
    if inRange then
        ApplyDamage({
            victim = kv.target,
            attacker = kv.caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = kv.ability
        })
    else
        kv.target:RemoveModifierByNameAndCaster(kv.modifier, kv.caster)
    end
end

function RemoveFlamePatch(kv)
    local thinker = kv.target
    local patch
    local idx
    for i, p in pairs(kv.ability.flame_patches) do
        if p.thinker == thinker then
            patch = p
            idx = i
        end
    end
    if patch then
        ParticleManager:DestroyParticle(patch.particle, false)
    end
    kv.ability.flame_patches[idx] = nil
end

function ApplySpeedBonus(kv)
    if kv.target == kv.caster then
        kv.ability:ApplyDataDrivenModifier(kv.caster, kv.caster, kv.modifier, {})
    end
end