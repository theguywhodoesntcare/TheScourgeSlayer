function HPBar()
    local bar = BlzCreateFrameByType("STATUSBAR", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    BlzFrameSetAbsPoint(bar, FRAMEPOINT_CENTER, 0.4, 0.57)
    -- Screen Size does not matter but has to be there
    BlzFrameSetSize(bar, 0.00001, 0.00001)

    -- Models don't care about Frame Size, But world Object Models are huge . To use them in the UI one has to scale them down alot.
    BlzFrameSetScale(bar, 1)

    --BlzFrameSetModel(bar, "ui/feedback/cooldown/ui-cooldown-indicator.mdx", 0)
    --BlzFrameSetModel(bar, "ui/feedback/XpBar/XpBarConsole.mdx", 0)
    BlzFrameSetModel(bar, "sprites/testbar.mdx", 0)
    --BlzFrameSetModel(bar, "ui/feedback/buildprogressbar/buildprogressbar.mdx", 0)
    --BlzFrameSetMinMaxValue(bar, 0, 100)
    BlzFrameSetValue(bar, 90)
    local i = 0
    TimerStart(CreateTimer(), 4, true, function()
        BlzFrameSetModel(bar, "sprites/testbar1.mdx", 0)
        --BlzFrameSetValue(bar, i)
        --i = i + 1
        --if i > 100 then
            --i = 0
        --end
        --i = GetRandomInt(0, 100)
        --print(BlzFrameGetValue(bar))
    end)
end