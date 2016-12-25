--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 12/25/2016
-- Time: 11:27 PM
-- To change this template use File | Settings | File Templates.
--

xirgil_essence_split = class({})

LinkLuaModifier("modifier_essence_split", "heroes/hero_xirgil/modifier_essence_split", LUA_MODIFIER_MOTION_HORIZONTAL)

function xirgil_essence_split:OnSpellStart()
    local caster = self:GetCaster()
    local casterpos = caster:GetAbsOrigin()
    local targetpos = self:GetCursorPosition()
    local max_distance = self:GetSpecialValueFor("dash_range")

    local fractured_self = caster:FindAbilityByName("xirgil_fractured_self")

    local distance = min(max_distance, (targetpos - casterpos):Length2D())
    local direction = (targetpos - casterpos):Normalized()

    local shadow_duration = self:GetSpecialValueFor("duration")
    local shadow_count = self:GetSpecialValueFor("shadow_count")
    local dash_angle = 360 / shadow_count

    for j=1,shadow_count do
        local shadow = fractured_self:MakeShadow(shadow_duration)

        if caster:HasModifier("modifier_fractal_rush") then
            print("Copying Fractal Rush to illusion!")
            local fractalrush = caster:FindModifierByName("modifier_fractal_rush")
            local fractalrush_new = shadow:AddNewModifier(caster, fractalrush:GetAbility(), "modifier_fractal_rush")
            fractalrush_new.distance = fractalrush.distance
            fractalrush_new.speed = fractalrush.speed
            fractalrush_new.direction = fractalrush.direction
            fractalrush_new.traveled_distance = fractalrush.traveled_distance
        else
            if j > 1 then
                -- BLACK MAGIC
                direction = RotatePosition(direction, QAngle(0, dash_angle, 0), Vector(0,0,0)) - direction
                direction = RotatePosition(direction, QAngle(0, dash_angle, 0), Vector(0,0,0)) - direction
                -- DO NOT TOUCH
                ability:ApplyDataDrivenModifier(caster, shadow, "modifier_essence_split", {
                    distance = distance,
                    direction = direction
                })
            end
        end
    end

    EmitSound("Hero_FacelessVoid.TimeWalk", caster)
end

function xirgil_essence_split:GetInterval()
    return self:GetSpecialValueFor("think_interval")
end

function xirgil_essence_split:GetSpeed()
    return self:GetSpecialValueFor("speed")
end