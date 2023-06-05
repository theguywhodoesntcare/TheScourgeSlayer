function Safety()
    local fr = BlzCreateFrameByType("BACKDROP", "", consoleFrame, "", 1)
    BlzFrameSetLevel(fr, 2)
    BlzFrameSetAbsPoint(fr, FRAMEPOINT_CENTER, 0.4, 0.5)
    BlzFrameSetSize(fr, 0.34, 0.17)
    BlzFrameSetTexture(fr, "backdrops\\safety", 0, true)
    BlzFrameSetVisible(fr, true)

    local alpha = 255
    TimerStart(CreateTimer(), 1/32, true, function()
        alpha = alpha - 4
        if alpha <=0 then
            BlzFrameSetAlpha(fr, 0)
            BlzDestroyFrame(fr)
            DestroyTimer(GetExpiredTimer())
        else
            BlzFrameSetAlpha(fr, alpha)
        end
    end)
end