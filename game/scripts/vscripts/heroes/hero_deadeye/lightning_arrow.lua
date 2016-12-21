-- Rotate a vector in the horizontal plane. Because RotatePosition is fucking retarded.
function RotateVector(vec, angle)
    local x = vec.x
    local y = vec.y
    local z = vec.z
    local cs = math.cos(angle)
    local sn = math.sin(angle)
    local nx = x*cs - y*sn
    local ny = x*sn + y*cs
    return Vector(nx, ny, z)
end


function LightningArrow(event)
    local ability = event.ability
    local caster = event.caster
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)
    local proj_count = ability:GetLevelSpecialValueFor("proj_count", ability:GetLevel() - 1)
    local shoot_direction = caster:GetForwardVector()
    local caster_pos = caster:GetAbsOrigin()
    local proj_speed = caster:GetProjectileSpeed()
    local range = ability:GetCastRange()

    local directions = {shoot_direction}

    if proj_count >= 3 then
        table.insert(directions, RotateVector(shoot_direction, math.pi/12))
        table.insert(directions, RotateVector(shoot_direction, -math.pi/12))
    end

    if proj_count >= 5 then
        table.insert(directions, RotateVector(shoot_direction, math.pi/6))
        table.insert(directions, RotateVector(shoot_direction, -math.pi/6))
    end

    for _, direction in pairs(directions) do
        ProjectileManager:CreateLinearProjectile({
            EffectName = "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf",
            Ability = ability,
            vSpawnOrigin = caster_pos,
            vVelocity = direction * proj_speed,
            fDistance = range,
            fStartRadius = radius / 2,
            fEndRadius = radius / 2,
            Source = caster,
            bHasFrontalCone = false,
            bReplaceExisting = false,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
            })
    end

    if caster:HasModifier("modifier_endless_munitions") then
        ability:EndCooldown()
        ability:StartCooldown(caster:GetSecondsPerAttack() - 0.3)
        print(caster:GetSecondsPerAttack() - 0.3)
        caster:GiveMana(ability:GetManaCost(ability:GetLevel() - 1) * 0.8)
    end
end

function LightningArrow_OnHit(event)
    local ability = event.ability
    local caster = event.caster
    local target = event.target
    local base_damage = ability:GetAbilityDamage()
    local scale_damage = ability:GetLevelSpecialValueFor("scale_damage", ability:GetLevel() - 1) * 1/100
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)
    local max_hits = ability:GetLevelSpecialValueFor("max_secondary_hits", ability:GetLevel() - 1)
    local particle = "particles/units/heroes/hero_zuus/zuus_static_field.vpcf"
    local target_is_creep = not target:IsHero()

    local enemies = FindUnitsInRadius(caster:GetTeamNumber(),
                                      target:GetAbsOrigin(),
                                      nil,
                                      radius,
                                      DOTA_UNIT_TARGET_TEAM_ENEMY,
                                      DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                                      DOTA_UNIT_TARGET_FLAG_NONE,
                                      FIND_ANY_ORDER,
                                      false)
    
    local HitIt = function(victim)
        local attack_damage = caster:GetAttackDamage()
        local damage = base_damage + scale_damage * attack_damage
        if target_is_creep and victim:IsHero() then
            damage = damage / 2
        end
        ApplyDamage({
            victim = victim,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = ability
            })-- Create effects
        local pfx = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN, victim)
        ParticleManager:SetParticleControl(pfx, 0, victim:GetAbsOrigin())

    end

    HitIt(target)

    local count = 0
    for _, victim in pairs(enemies) do
        if victim ~= target then
            HitIt(victim)
            count = count + 1
        end
        if count >= max_hits then
            break
        end
    end

end