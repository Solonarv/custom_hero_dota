--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 07.07.2017
-- Time: 01:37
-- To change this template use File | Settings | File Templates.
--

function Setup(_)
    LinkLuaModifier("modifier_winters_arrow_speed", "heroes/hero_ailil/modifier_winters_arrow_speed.lua", LUA_MODIFIER_MOTION_NONE)
end

modifier_winters_arrow_speed = class({})

function modifier_winters_arrow_speed:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_winters_arrow_speed:OnCreated(_)
    self:Update()
end

function modifier_winters_arrow_speed:OnRefresh(_)
    self:Update()
end

function modifier_winters_arrow_speed:Update()
    print("Speed modifier update!")
    if IsServer() then
        local mods = self:GetParent():FindAllModifiersByName("modifier_winters_arrow_speed_hidden")
        local modsFromCaster = {}
        local duration = 0
        local maxStacks = self:GetAbility():GetSpecialValueFor("max_stacks")
        for _, mod in pairs(mods) do
            if mod:GetCaster() == self:GetCaster() then
                table.insert(modsFromCaster, mod)
                local modDuration = mod:GetDuration()
                if modDuration >= duration then
                    duration = modDuration
                end
            end
        end
        table.sort(modsFromCaster, function(x, y) return x:GetDuration() < y:GetDuration() end)
        while #modsFromCaster > maxStacks do
            table.remove(modsFromCaster, 1)
        end
        if 0 == #modsFromCaster then
            self:Destroy()
        else
            self:SetDuration(duration, true)
            self:SetStackCount(#modsFromCaster)
        end
    end
end


function modifier_winters_arrow_speed:IsHidden()
    return false
end

function modifier_winters_arrow_speed:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("movement_speed_stolen") * self:GetStackCount()
end

