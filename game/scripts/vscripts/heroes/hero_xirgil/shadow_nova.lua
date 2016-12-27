-- Stolen from the Dota 2 Spell Library.
--[[
    Author: Ractidous
    Date: 29.01.2015.
    Get all illusions owned by the hero.
]]
function GetShadows( hero )
    local playerID = hero:GetPlayerID()

    local allies = FindUnitsInRadius( hero:GetTeamNumber(),
                                      hero:GetAbsOrigin(),
                                      nil,
                                      FIND_UNITS_EVERYWHERE,
                                      DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                      DOTA_UNIT_TARGET_HERO,
                                      DOTA_UNIT_TARGET_FLAG_NONE,
                                      FIND_ANY_ORDER,
                                      false )
    local shadows = {}

    for _,v in pairs( allies ) do
        if (v:GetUnitName() == hero:GetUnitName() or v:GetUnitName() == "npc_xirgil_shadow") and v:GetMainControllingPlayer() == v:GetMainControllingPlayer() then
            table.insert(shadows, v)
        end
    end

    return shadows

--  return hero.illusions or {}
end

function ShadowNova(event)
    local caster = event.caster
    local player = caster:GetPlayerID()
    local ability = event.ability
    local main_damage = ability:GetAbilityDamage()
    local snd_percent = ability:GetLevelSpecialValueFor("repeat_damage_percent", ability:GetLevel() - 1) / 100.0
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)

    local dummy_modifier_name = "modifier_shadow_nova_dummy"

    local victims = {}

    local find_victims = function(unit)
        unit.shadow_nova_victims = {}

        ability:ApplyDataDrivenModifier(unit, unit, dummy_modifier_name, {})
        unit:RemoveModifierByName(dummy_modifier_name)

        for _, v in pairs(unit.shadow_nova_victims) do
            if victims[v] == nil then
                victims[v] = {}
            end
            table.insert(victims[v], unit)
        end

        unit.shadow_nova_victims = nil

        -- Create effects
        local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", PATTACH_ABSORIGIN, unit )
        ParticleManager:SetParticleControl( pfx, 0, unit:GetAbsOrigin() )
        ParticleManager:SetParticleControl( pfx, 1, Vector( radius, radius, radius ) )
        ParticleManager:SetParticleControl( pfx, 3, Vector( 0.0, 0.0, 0.0 ) )

        StartSoundEvent( "Hero_Nevermore.Shadowraze", unit )
    end

    -- Cast from hero
    find_victims(caster)

    -- Cast from illusions
    local illusions = GetShadows(caster)
    for _,v in pairs(illusions) do
        if v and IsValidEntity(v) and v:IsAlive() then
            find_victims(v)
        end
    end

    -- Apply damage
    for victim, shadows in pairs(victims) do
        local damaged = false
        for _, shadow in pairs(shadows) do
            ApplyDamage({
                victim = victim,
                attacker = shadow,
                damage = damaged and main_damage * snd_percent or main_damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = ability
            })
            damaged = true
        end
    end
end

function ShadowNova_MarkAsVictim(event)
    local caster = event.caster
    local target = event.target
    table.insert(caster.shadow_nova_victims, target)
end