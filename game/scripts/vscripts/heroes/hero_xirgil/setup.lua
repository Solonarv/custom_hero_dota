function Learn_FracturedSelf()
    local fractured_self = thisEntity:FindAbilityByName("xirgil_fractured_self")
    fractured_self:SetLevel(1)
end

function Spawn(entityKV)
    Learn_FracturedSelf()
end