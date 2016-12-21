local upgrades = {
    deadeye_lightning_arrow = "deadeye_lightning_arrow_i",
    deadeye_lightning_arrow_i = "deadeye_lightning_arrow_ii",
    deadeye_lightning_arrow_ii = "deadeye_lightning_arrow_iii",
    deadeye_blink_arrow = "deadeye_blink_arrow_i",
    deadeye_blink_arrow_i = "deadeye_blink_arrow_ii",
    deadeye_blink_arrow_ii = "deadeye_blink_arrow_iii"
}

function ReplaceAbility(event)
    print("Hello!")
    local slot = event.ability_slot
    local caster = event.caster
    local old = caster:GetAbilityByIndex(slot)
    local oldname = old:GetAbilityName()
    local newname = upgrades[oldname]

    caster:AddAbility(newname)
    caster:SwapAbilities(oldname, newname, false, true)
    caster:FindAbilityByName(newname):SetLevel(old:GetLevel())
    caster:RemoveAbility(oldname)
end