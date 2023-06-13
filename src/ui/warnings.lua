function CreateWarnings()
    ammoFr = CreateBackdropTwoPoints(consoleFrame, 0, 0.5, 0.2, 0.42, "backdrops\\lowammo", 8)
    BlzFrameSetSize(ammoFr, 0.2, 0.08)
    BlzFrameClearAllPoints(ammoFr)
    BlzFrameSetVisible(ammoFr, false)
    healthFr = CreateBackdropTwoPoints(consoleFrame, 0.2, 0.15, 0.4, 0.07, "backdrops\\lowhealth", 8)
    BlzFrameSetSize(healthFr, 0.2, 0.08)
    BlzFrameClearAllPoints(healthFr)
    BlzFrameSetVisible(healthFr, false)

    ammoPoints = CirclePath(0.01, 0.1, 0.5, 9*math.pi / 180)
    healthPoints = CirclePath(0.01, 0.3, 0.11, 9*math.pi / 180)
end

function DisplayWarningAmmo()
    local i = 1
    local sharp = #ammoPoints
    local t = CreateTimer()
    BlzFrameSetVisible(ammoFr, true)

    TimerStart(t, 1/32, true, function()
        if lowAmmo then
            BlzFrameSetAbsPoint(ammoFr, FRAMEPOINT_CENTER, ammoPoints[i].x, ammoPoints[i].y)
            i = i + 1
            if i > sharp then
                i = 1
            end
        else
            BlzFrameSetVisible(ammoFr, false)
            DestroyTimer(t)
        end
    end)
end

function DisplayWarningHealth()
    local i = 1
    local sharp = #healthPoints
    local t = CreateTimer()

    BlzFrameSetVisible(healthFr, true)
    TimerStart(t, 1/32, true, function()
        if lowHealh then
            BlzFrameSetAbsPoint(healthFr, FRAMEPOINT_CENTER, healthPoints[i].x, healthPoints[i].y)
            i = i + 1
            if i > sharp then
                i = 1
            end
        else
            BlzFrameSetVisible(healthFr, false)
            DestroyTimer(t)
        end
    end)
end