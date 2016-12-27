--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 12/27/2016
-- Time: 7:35 AM
-- To change this template use File | Settings | File Templates.
--

xirgil_shadow_nova = class({})

function xirgil_shadow_nova:OnSpellStart()
    local caster = self:GetCaster()
    local main_damage = self:GetAbilityDamage()
    local snd_percent = self:GetRepeatDamage()
    local radius = self:GetRadius()

    local fractured_self = caster:FindAbilityByName("xirgil_fractured_self")

    local victims = {}

    local find_victims = function(unit)

        local enemies = FindUnitsInRadius( unit:GetTeamNumber(),
                                            unit:GetAbsOrigin(),
                                            nil,
                                            radius,
                                            DOTA_UNIT_TARGET_TEAM_ENEMY,
                                            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_TEAM_BASIC,
                                            DOTA_UNIT_TARGET_FLAG_NONE,
                                            FIND_ANY_ORDER,
                                            false )

        for _, v in pairs(enemies) do
            if victims[v] == nil then
                victims[v] = {}
            end
            table.insert(victims[v], unit)
        end

        -- Create effects
        local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", PATTACH_ABSORIGIN, unit )
        ParticleManager:SetParticleControl( pfx, 0, unit:GetAbsOrigin() )
        ParticleManager:SetParticleControl( pfx, 1, Vector( radius, radius, radius ) )
        ParticleManager:SetParticleControl( pfx, 3, Vector( 0.0, 0.0, 0.0 ) )

        StartSoundEvent( "Hero_Nevermore.Shadowraze", unit )
    end

    -- Cast from hero
    find_victims(caster)

    -- Cast from shadows
    if fractured_self ~= nil then
        for _,v in pairs(fractured_self:GetShadows()) do
            if v and IsValidEntity(v) and v:IsAlive() then
                find_victims(v)
            end
        end
    end

    -- Apply damage
    for victim, shadows in pairs(victims) do
        local damaged = false
        for _, shadow in pairs(shadows) do
            ApplyDamage({
                victim = victim,
                attacker = shadow,
                damage = damaged and main_damage * snd_percent / 100 or main_damage,
                damage_type = self:GetAbilityDamageType(),
                ability = self
            })
            damaged = true
        end
    end
end

function xirgil_shadow_nova:GetRadius()
    return self:GetSpecialValueFor("radius")
end

function xirgil_shadow_nova:GetRepeatDamage()
    return self:GetSpecialValueFor("repeat_damage_percent")
end