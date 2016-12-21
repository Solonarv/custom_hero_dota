function Resurrect(event)
    local caster = event.caster
    local ability = event.ability
    local hp_cost = event.health_cost / 100 * caster:GetMaxHealth()
    local mana_cost = ability:GetManaCost(ability:GetLevel() - 1)
    local target = event.target_points[1]
    local radius = event.search_radius

    local health_frac = event.res_health / 100
    local mana_frac = event.res_mana / 100

    local corpse = FindResurrectTarget(caster, target, radius)

    -- Check if the caster can pay the health cost and a valid target was found.
    -- If not, refund mana and cooldown, then cancel the ability
    if caster:GetHealth() < hp_cost + 1 or not corpse then
        ability:EndCooldown()
        caster:GiveMana(mana_cost)
        return
    end

    print("HP cost is"..hp_cost)

    -- Take the HP cost
    caster:SetHealth(caster:GetHealth() - hp_cost)

    local corpse_loc = corpse:GetAbsOrigin()
    corpse:SetRespawnPosition(corpse_loc)
    corpse:RespawnHero(false, false, true)

    corpse:SetHealth(corpse:GetMaxHealth() * health_frac)
    corpse:SetMana(corpse:GetMaxMana() * mana_frac)

end

function Resurrect_Cancel(event)
    local caster = event.caster
    local ability = event.ability
    local mana_cost = ability:GetManaCost(ability:GetLevel() - 1)

    caster:GiveMana(mana_cost)
    ability:EndCooldown()
end

function Resurrect_PreCastCheck(event)
    local caster = event.caster
    local ability = event.ability
    local hp_cost = event.health_cost
    local target = event.target_points[1]
    local radius = event.search_radius

    -- Check if the caster can pay the health cost
    if caster:GetHealth() < hp_cost + 1 then
        caster:Interrupt()
        return
    end

    -- Check if there's a valid target
    if not FindResurrectTarget(caster, target, radius) then
        caster:Interrupt()
    end
end

-- Find the closest dead allied hero to the target point
function FindResurrectTarget(caster, point, radius)
    local dead_allies = FindUnitsInRadius(caster:GetTeamNumber(),
                                      point,
                                      nil,
                                      radius,
                                      DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                      DOTA_UNIT_TARGET_HERO,
                                      DOTA_UNIT_TARGET_FLAG_DEAD,
                                      FIND_CLOSEST,
                                      false)

    for _, u in pairs(dead_allies) do
        if not u:IsAlive() then
            return u
        end
    end
end