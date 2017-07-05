--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 05.07.2017
-- Time: 03:18
-- To change this template use File | Settings | File Templates.
--

function EnableDeflagration(kv)
    local deflagration = kv.caster:FindAbilityByName(kv.deflagration)
    if deflagration then deflagration:SetActivated(true) end
end

function DisableDeflagration(kv)
    local deflagration = kv.caster:FindAbilityByName(kv.deflagration)
    if deflagration then deflagration:SetActivated(false) end
end

function DeflagrationSetup(kv)
    if IsServer() then

        local thinker = kv.target
        thinker.deflagration = {
            currentRadius = 0,
            maxRadius = kv.radius,
            ringWidth = kv.ring_width,
            expandPerTick = kv.ring_speed * kv.interval,
            damage = kv.damage + kv.damage_mult * kv.caster.flame / 10,
            unitsHit = {}
        }
    end
end

function DeflagrationThinkerTick(kv)
    if IsServer() then
        local def = kv.target.deflagration
        local loc = kv.target:GetOrigin()
        def.currentRadius = def.currentRadius + def.expandPerTick
        local targets = FindUnitsInRadius(kv.caster:GetTeamNumber(),
            loc,
            nil,
            def.currentRadius + def.ringWidth / 2,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_ALL,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER,
            false)
        for _, unit in pairs(targets) do
            if (unit:GetOrigin() - loc):Length2D() >= def.currentRadius - def.ringWidth / 2 and not def.unitsHit[unit] then
                ApplyDamage({
                    victim = unit,
                    attacker = kv.caster,
                    damage = def.damage,
                    damage_type = DAMAGE_TYPE_MAGICAL,
                    ability = kv.ability
                })
                def.unitsHit[unit] = true
            end
        end
        if def.currentRadius >= def.maxRadius then
            kv.target:RemoveSelf()
        end
    end
end