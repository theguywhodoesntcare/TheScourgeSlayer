do
    local real = MarkGameStarted
    function MarkGameStarted()
        FogMaskEnableOff()
        FogEnableOff()

        StatusList()
       InitCustomUI()

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




        InitCameraScrollBar()
        InitDamageTrigger()
        --AttackTimer()

    end
end