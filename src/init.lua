do
    local real = MarkGameStarted
    function MarkGameStarted()
        FogMaskEnableOff()
        FogEnableOff()
        InitCustomUI()
        StatusList()
        GetUnitX = GetUnitRealX
        GetUnitY = GetUnitRealY
        CreateBoss()
        CreateTestUnit()
        dummy1 = CreateDummy()
        dummy2 = CreateDummy()
        dummy3 = CreateDummy()
        posdummy = CreateDummy()
        impaleCasters = {dummy1, dummy2, dummy3}
        --BlzHideOriginFrames(true)
        CreateSlayer()
        SetUnitLookAt( slayer, "bone_turret", posdummy, 0, 0, 0 )
        globalX, globalY = GetUnitPosition(slayer)
        InitControlMouse()
        InitControlKeys()
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 0, true)


        --------------------
        CenterX = 1
        CenterY = 1
        Radius = 1800
        CreateBarrier()

        ClickBlocker = BlzCreateFrameByType("TEXT", "name", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
         CreateTextFrame(ClickBlocker, -0.1338, 0.6, 0.936020, 0, 1, "", 1)
            BlzFrameSetEnable(ClickBlocker, true)


        InitCameraScrollBar()
        InitDamageTrigger()
        --AttackTimer()

    end
end