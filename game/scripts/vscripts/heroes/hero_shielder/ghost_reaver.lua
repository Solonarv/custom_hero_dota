function GR_EqualizeLevels(event)
    local caster = event.caster
    local gr_mana = caster:FindAbilityByName("shielder_ghost_reaver_mana")
    local gr_life = caster:FindAbilityByName("shielder_ghost_reaver_life")

    if gr_mana == nil or gr_life == nil then return end

    local mana_level = gr_mana:GetLevel()
    local life_level = gr_life:GetLevel()

    if mana_level > life_level then
        gr_life:SetLevel(mana_level)
    else
        if life_level > mana_level then
            gr_mana:SetLevel(life_level)
        end
    end

    event.shift_amount = 0
    GR_Shift(event)
end

function GR_Mana_On(event)
    local caster = event.caster
    local ability = event.ability
    local gr_life = caster:FindAbilityByName("shielder_ghost_reaver_life")
    if gr_life ~= nil then
        if gr_life:GetToggleState() == true then
            gr_life:ToggleAbility()
        end
    end
    ability:ApplyDataDrivenModifier(caster, caster, "modifier_ghost_reaver_mana_active", {})
end

function GR_Life_On(event)
    local caster = event.caster
    local ability = event.ability
    local gr_mana = caster:FindAbilityByName("shielder_ghost_reaver_mana")
    if gr_mana ~= nil then
        if gr_mana:GetToggleState() == true then
            gr_mana:ToggleAbility()
        end
    end
    ability:ApplyDataDrivenModifier(caster, caster, "modifier_ghost_reaver_life_active", {})
end

function GR_Mana_Off(event)
    event.caster:RemoveModifierByName("modifier_ghost_reaver_mana_active")
end

function GR_Life_Off(event)
    event.caster:RemoveModifierByName("modifier_ghost_reaver_life_active")
end

function GR_Shift(event)
    local caster = event.caster
    local shift = event.shift_amount

    if caster.ghost_reaver_portion == nil then
        caster.ghost_reaver_portion = 0
    end

    caster.ghost_reaver_portion = caster.ghost_reaver_portion + shift

    if caster.ghost_reaver_portion < 0 then
        caster.ghost_reaver_portion = 0
    end
    if caster.ghost_reaver_portion > 1 then
        caster.ghost_reaver_portion = 1
    end

    caster:SetModifierStackCount("modifier_ghost_reaver_mana_counter", caster, 100 *      caster.ghost_reaver_portion )
    caster:SetModifierStackCount("modifier_ghost_reaver_life_counter", caster, 100 * (1 - caster.ghost_reaver_portion))
end

function GR_Leech(event)
    -- This makes self-inflicted damage not able to leech
    if event.caster == event.unit and event.caster == event.attacker then
        return 
    end
    GR_LeechMana(event)
    GR_LeechLife(event)
end

function GR_LeechMana(event)
    local caster = event.caster
    local damage = event.damage_dealt
    local ability = event.ability
    local leech = ability:GetLevelSpecialValueFor("leech_pct", ability:GetLevel()) / 100

    local mana = leech * damage * caster.ghost_reaver_portion

    caster:GiveMana(mana)
end

function GR_LeechLife(event)
    local caster = event.caster
    local damage = event.damage_dealt
    local ability = event.ability
    local leech = ability:GetLevelSpecialValueFor("leech_pct", ability:GetLevel()) / 100

    local life = leech * damage * (1 - caster.ghost_reaver_portion)

    caster:Heal(life, ability)
end