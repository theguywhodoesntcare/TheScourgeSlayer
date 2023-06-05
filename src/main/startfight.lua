function BossFight(frame)
    PlayMusic( "sounds\\bfg_division" )
    local length = GetSoundFileDuration("sounds\\bfg_division")
    local musicTimer = CreateTimer()
    TimerStart(musicTimer, length, false, function()
        ClearMapMusicBJ()
        PlayMusic("sounds\\fear.flac;sounds\\bfg_division.flac")
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