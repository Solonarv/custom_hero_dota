function RefreshCooldowns(kv)
    local caster = kv.caster

    local stabilize = caster:FindAbilityByName("flicker_stabilize")
    local rapid_strike = caster:FindAbilityByName("flicker_rapid_strike")
    local recall = caster:FindAbilityByName("flicker_recall")

    if stabilize ~= nil then
        stabilize:EndCooldown()
    end

    if rapid_strike ~= nil then
        rapid_strike:EndCooldown()
    end

    if recall ~= nil then
        local recall_cd = recall:GetCooldown(recall:GetLevel() - 1)
        print(recall_cd)
        if recall:GetCooldownTimeRemaining() > recall_cd then
            recall:EndCooldown()
            recall:StartCooldown(recall_cd)
        else
            recall:EndCooldown()
        end
    end

end

function GetAscensionReachMultiplier(flicker)
    if flicker:HasModifier("modifier_ascension") then
        local ascension = flicker:FindAbilityByName("flicker_ascension")
        if ascension ~= nil then
            return 1 + ascension:GetLevelSpecialValueFor("reach_increase", ascension:GetLevel() - 1) / 100
        end
    end
    return 1
end