function GotDamage()
    print("got damage")
    PlayPainSoundMain()
end


function ControlDmg(unit)
    SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_LIFE) - 25)
end

function CheckFireballDamage(x, y)
    if IsCirclesIntersect(GetUnitX(slayer), GetUnitY(slayer), 40, x, y, 50) then
        GotDamage()
    end
    return
end


function CheckStoneDamage(x, y)
    if IsCirclesIntersect(GetUnitX(slayer), GetUnitY(slayer), 32, x, y, 60) then
        GotDamage()
        return true
    else
        return false
    end
end

function InitDamageTrigger()
    local DamageTrigger = CreateTrigger()
    TriggerRegisterUnitEvent(DamageTrigger, slayer, EVENT_UNIT_DAMAGED)
    TriggerAddCondition(DamageTrigger, Condition(ResetAfterDamage))
end

function ResetAfterDamage()
    GotDamage()
    SetUnitLookAt( slayer, "bone_turret", posdummy, 0, 0, 0 )
    SetUnitState(slayer, UNIT_STATE_LIFE, GetUnitState(slayer, UNIT_STATE_MAX_LIFE))
end



