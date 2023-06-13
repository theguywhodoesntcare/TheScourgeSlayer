function BossFight(frame)
    SetMusicVolume(90)
    PlayMusic( "sounds\\bfg_division1" )
    local length = GetSoundFileDuration("sounds\\bfg_division1.mp3") / 1000
    local musicTimer = CreateTimer()
    TimerStart(musicTimer, length, false, function()
        StopMusicBJ(false)
        ClearMapMusicBJ()
        PlayMusic("sounds\\fear.mp3")
        local length1 = GetSoundFileDuration("sounds\\fear.mp3") / 1000
        local musicTimer1 = CreateTimer()
        TimerStart(musicTimer1, length, false, function()
            StopMusicBJ(false)
            ClearMapMusicBJ()
            PlayMusic("sounds\\fear.mp3;sounds\\bfg_division1.mp3")
            DestroyTimer(musicTimer1)
        end)
        DestroyTimer(musicTimer)
    end)


    local t = CreateTimer()
    TimerStart(t, 14, false, function()
        CinematicFilterGenericBJ( 1, BLEND_MODE_BLEND, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100, 100, 100, 0.00, 0, 0, 0, 100 )
        SetTimeOfDay( 18 )
        InitControlMouse()
        InitControlKeys()

        InitDamageTrigger()
        AttackTimer()
        InitCreepsMovement()
        BlzDestroyFrame(frame)
        local t1 = CreateTimer()
        TimerStart(t1, 2, false, function()
            TripleImpale(30)
            DestroyTimer(t1)
        end)

    end)

end