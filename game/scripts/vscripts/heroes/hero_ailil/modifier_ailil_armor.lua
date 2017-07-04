--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 18:03
-- To change this template use File | Settings | File Templates.
--

modifier_ailil_armor = class({})

function modifier_ailil_armor:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end


function modifier_ailil_armor:OnTakeDamage(kv)
    local ailil = self:GetParent()
    if kv.unit == ailil and bit.band(kv.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == 0 and kv.damage > self:GetAbility():GetDamageThreshold() then
        ailil:SetHealth(ailil:GetHealth() + kv.damage)
        -- Reflect damage only if it's not reflect damage
        if bit.band(kv.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == 0 then
            ApplyDamage({
                victim = kv.attacker,
                attacker = ailil,
                damage = kv.original_damage,
                damage_type = kv.damage_type,
                ability = self:GetAbility(),
                damage_flags = bit.bor(kv.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION)
            })
        end
        self:DecrementStackCount()
        if self:GetStackCount() < 1 then
            self:Destroy()
            -- Strong Dispel
            local RemovePositiveBuffs = false
            local RemoveDebuffs = true
            local BuffsCreatedThisFrameOnly = false
            local RemoveStuns = true
            local RemoveExceptions = false
            self:GetParent():Purge(RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
        end
    end
end