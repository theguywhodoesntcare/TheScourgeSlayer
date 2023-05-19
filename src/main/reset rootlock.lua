function InitResetRootLock()
    local ResetRootLockTrigger = CreateTrigger()
    TriggerRegisterUnitEvent(ResetRootLockTrigger, slayer, EVENT_UNIT_DAMAGED)
    TriggerAddCondition(ResetRootLockTrigger, Condition(ResetRootLock))
end

function ResetRootLock()
    SetUnitLookAt( slayer, "bone_turret", posdummy, 0, 0, 0 )
end


