function GracefulAssault(event)
    local caster = event.caster
    local stacks = caster.graceful_assault_charges
    local ability = event.ability
    local modifier = "modifier_graceful_assault"
    local stack_mod = "modifier_graceful_assault_proc"
    local duration_per_stack = ability:GetLevelSpecialValueFor("duration_per_stack", ability:GetLevel() - 1)
    
    ability:ApplyDataDrivenModifier(caster, caster, modifier, {Duration = duration_per_stack * stacks})
    for i=1,stacks do 
        caster:RemoveModifierByName(stack_mod)
    end
end

function GracefulAssault_RemoveStack(event)
    local caster = event.caster
    caster.graceful_assault_charges = max(0, caster.graceful_assault_charges - 1)
end

function GracefulAssault_AddStack(event)
    local caster = event.caster
    local ability = event.ability
    if caster.graceful_assault_charges == nil then
        caster.graceful_assault_charges = 0
    end
    caster.graceful_assault_charges = caster.graceful_assault_charges + 1
end

function GracefulAssault_CheckCastable(event)
    local caster = event.caster
    local charges = caster.graceful_assault_charges
    if charges == nil or charges == 0 then
        caster:Interrupt()
    end
end