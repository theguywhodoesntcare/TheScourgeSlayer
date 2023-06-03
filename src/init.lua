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
        for i = 1, 6 do
            CreateTestUnit()
        end
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
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 200, true)


        --------------------

        CreateBarrier()




        InitCameraScrollBar()
        InitDamageTrigger()
        --AttackTimer()
        CreateBlood()
        CreateBones()
    end
end