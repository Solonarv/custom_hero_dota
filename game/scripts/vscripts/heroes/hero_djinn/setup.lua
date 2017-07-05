--
-- Created by IntelliJ IDEA.
-- User: Solonarv
-- Date: 04.07.2017
-- Time: 21:14
-- To change this template use File | Settings | File Templates.
--

function Spawn(_)
    if IsServer() and thisEntity and thisEntity.FindAbilityByName then
        local innerflame = thisEntity:FindAbilityByName("djinn_inner_flame")
        if innerflame then innerflame:SetLevel(1) end
        local deflagration = thisEntity:FindAbilityByName("djinn_deflagration")
        if deflagration then deflagration:SetActivated(false) end
    end
end