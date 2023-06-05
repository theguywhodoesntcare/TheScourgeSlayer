do
    local real = MarkGameStarted
    function MarkGameStarted()
        FogMaskEnableOff()
        FogEnableOff()
        UseTimeOfDayBJ(false)
        CinematicFilterGenericBJ( 2, BLEND_MODE_BLEND, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100, 100, 100, 0.00, 100.00, 100.00, 100.00, 0.00 )
        StatusList()
        InitCustomUI()
        math.randomseed(os.time())
        GetUnitX = GetUnitRealX
        GetUnitY = GetUnitRealY
        CreateBoss()
        for i = 1, maxcreeps do
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
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 200, true)
        StopMusicBJ( false )
        ClearMapMusicBJ(  )

        CreateBarrier()
        InitCameraScrollBar()
        CreateBlood()
        CreateBones()


        local text = "|cffffffffMovement — [|cffffff00W|r][|cffffff00A|r][|cffffff00S|r][|cffffff00D|r]\n\nShooting — |cffffff00Left Mouse Button|r\n\nDash — [|cffffff00SPACE|r]\n\nChain — |cffffff00Right Mouse Button|r\n\nSAW THE UNDEAD BASTARD — [|cffff0000E|r]\n\nHave fun!|r"
        local descr = CreateText(consoleFrame, 0.4, 0.3, 0.4, text, 2)
        BlzFrameSetScale(descr, 3)
        BossFight(descr)
    end
end