function EnergyShield_Absorb(event)
    local caster = event.unit
    local damage = event.damage_taken
    local ability = event.ability

    -- This makes self-inflicted damage not get mitigated
    if event.caster == event.unit and event.caster == event.attacker then
        print(caster:GetHealth())
        return 
    end

    local mana = caster:GetMana()

    local life_pct = caster:GetHealthPercent() / 100

    local shift_pct = 1 - 0.7 * life_pct

    local shifted = min(mana, shift_pct * damage)
    local mana_remaining = mana - shifted

    local newHealth = ability.old_health - damage + shifted
    caster:SetHealth(newHealth)

    caster:SetMana(mana_remaining - shifted)

end

function EnergyShield_SaveHealth(event)
    local target = event.target
    local ability = event.ability
    ability.old_health = target:GetHealth()
end