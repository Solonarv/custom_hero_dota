function Learn_FracturedSelf()
    print(tostring(thisEntity))
    local fractured_self = thisEntity:FindAbilityByName("xirgil_fractured_self")
    fractured_self:SetLevel(1)
    thisEntity.owner = thisEntity
end

function Spawn(entityKV)
    Learn_FracturedSelf()
end