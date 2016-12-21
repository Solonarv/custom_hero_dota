function CreateIllusion(event)
    local caster = event.caster
    local ability = event.ability
    local target = event.target
    local duration = event.duration
    local marker = event.soul_marker

    local casterpos = caster:GetAbsOrigin()
    local soulpos = caster:GetForwardVector() * math.random(100, 150) + casterpos

    if ability.soul and IsValidEntity(ability.soul) then
        ability.soul:ForceKill(false)
    end

    if caster:GetTeamNumber() == target:GetTeamNumber() then
        return nil
    end

    local soul = CreateUnitByName(target:GetUnitName(), soulpos, true, caster, nil, target:GetTeamNumber())

    for itemSlot=0,5 do
        local item = target:GetItemInSlot(itemSlot)
        if item ~= nil then
            local itemName = item:GetName()
            local newItem = CreateItem(itemName, illusion, illusion)
            soul:AddItem(newItem)
        end
    end

    soul:AddNewModifier(caster, ability, "modifier_illusion", { duration = duration, outgoing_damage = outgoingDamage, incoming_damage = incomingDamage })
    soul:MakeIllusion()

    ability:ApplyDataDrivenModifier(caster, soul, marker, {duration = duration})
    ability.soul = soul
    soul.original = target
    target.soul = soul
    soul.soul = soul
    soul:SetHealth(soul:GetMaxHealth())
end

function TransferDamage(event)
    local caster = event.caster
    local soul = event.unit
    local original = soul.original
    local damage = event.damage
    local transferred = event.transfer_pct * 1/100 * damage

    soul:SetHealth(soul:GetMaxHealth())

    if original then
        ApplyDamage({
            victim = original,
            attacker = caster,
            damage = transferred,
            damage_type = DAMAGE_TYPE_PURE
        })
    end
end

function RemoveSoul(event)
    local caster = event.caster
    local ability = event.ability
    local target = event.unit

    if target then
        if target.soul and IsValidEntity(target.soul) then
            target.soul:ForceKill(false)
        end
        target.soul = nil
    end
    
    ability.soul = nil
end