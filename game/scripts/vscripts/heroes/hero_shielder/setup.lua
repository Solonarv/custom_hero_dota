function Learn_EnergyShield()
    local energy_shield = thisEntity:FindAbilityByName("shielder_energy_shield")
    if energy_shield then energy_shield:SetLevel(1) end
end

function Spawn(entityKV)
    Learn_EnergyShield()
end