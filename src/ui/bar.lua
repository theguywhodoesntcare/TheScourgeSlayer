function HPBar()
    consoleFrame = BlzGetFrameByName("ConsoleUIBackdrop", 0)
    bar = BlzCreateFrameByType("STATUSBAR", "", consoleFrame, "", 0)

    BlzFrameSetAbsPoint(bar, FRAMEPOINT_CENTER, 0.4, 0.57)
    -- Screen Size does not matter but has to be there
    BlzFrameSetSize(bar, 0.00001, 0.00001)

    -- Models don't care about Frame Size, But world Object Models are huge . To use them in the UI one has to scale them down alot.
    BlzFrameSetScale(bar, 1)

    --BlzFrameSetModel(bar, "ui/feedback/cooldown/ui-cooldown-indicator.mdx", 0)
    --BlzFrameSetModel(bar, "ui/feedback/XpBar/XpBarConsole.mdx", 0)
    BlzFrameSetModel(bar, "sprites/testbar.mdx", 0)
    --BlzFrameSetModel(bar, "ui/feedback/buildprogressbar/buildprogressbar.mdx", 0)
    BlzFrameSetMinMaxValue(bar, 0, bossHPConst+1)
    BlzFrameSetValue(bar, bossHPConst)
    local i = 0
    TimerStart(CreateTimer(), 4, false, function()
        --BlzFrameSetModel(bar, "sprites/testbar1.mdx", 0)
        --BlzFrameSetValue(bar, i)
        --i = i + 1
        --if i > 100 then
            --i = 0
        --end
        --i = GetRandomInt(0, 100)
        --print(BlzFrameGetValue(bar))
    end)

    invul = BlzCreateFrameByType("BACKDROP", "", bar, "", 1)

    BlzFrameSetAbsPoint(invul, FRAMEPOINT_CENTER, 0.4, 0.58)
    BlzFrameSetSize(invul, 0.34, 0.17)
    BlzFrameSetTexture(invul, "backdrops\\invul", 0, true)
    BlzFrameSetVisible(invul, true)
    ------------

    bar2 = BlzCreateFrameByType("STATUSBAR", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    BlzFrameSetAbsPoint(bar2, FRAMEPOINT_CENTER, 0.4, 0.03)
    -- Screen Size does not matter but has to be there
    BlzFrameSetSize(bar2, 0.00001, 0.00001)

    -- Models don't care about Frame Size, But world Object Models are huge . To use them in the UI one has to scale them down alot.
    BlzFrameSetScale(bar2, 1)

    --BlzFrameSetModel(bar, "ui/feedback/cooldown/ui-cooldown-indicator.mdx", 0)
    --BlzFrameSetModel(bar, "ui/feedback/XpBar/XpBarConsole.mdx", 0)
    BlzFrameSetModel(bar2, "sprites/testbar2.mdx", 0)
    --BlzFrameSetModel(bar, "ui/feedback/buildprogressbar/buildprogressbar.mdx", 0)
    BlzFrameSetMinMaxValue(bar2, 1, slayerHPConst+1)
    BlzFrameSetValue(bar2, slayerHPConst)
end