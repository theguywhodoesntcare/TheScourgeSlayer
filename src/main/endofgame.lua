function Lost()
    DisableTrigger(ClickTrigger)
    DisableTrigger(ClickReleaseTrigger)
    DisableTrigger(MouseTrigger)
    DisableTrigger(ButtonPressedTrigger)
    DisableTrigger(ButtonReleasedTrigger)

    KillUnit(slayer)
    BlzDestroyFrame(bar2)
    TimerStart(CreateTimer(), 5, false, function()
        CustomDefeatBJ(GetLocalPlayer(), "You got no chance in Hell!")
    end)
end


function Win()
    SetUnitInvulnerable(slayer, true)
    KillUnit(boss)
    DestroyTimer(globalAttackTimer)
    BlzDestroyFrame(invul)
    BlzDestroyFrame(bar)
    TimerStart(CreateTimer(), 5, false, function()
        CustomVictoryBJ(GetLocalPlayer(), "You are the true Scourge Slayer!", false)
    end)
end