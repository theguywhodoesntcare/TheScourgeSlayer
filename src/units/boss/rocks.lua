function ThrowStone()
    local bx, by = GetUnitPosition(boss)
    local sx, sy = RandomPointInCircleXY(GetUnitX(slayer), GetUnitY(slayer), 400)
    local targetX, targetY = FindIntersection(bx, by, sx, sy)
    local points = GetPointsOnLineWithRotation(bx, by, targetX, targetY, 50)
    local eff = AddSpecialEffect("models\\Rock3", bx, by)
    BlzSetSpecialEffectScale(eff, 0.75)
    BlzSetSpecialEffectZ(eff, 350)


    local t = CreateTimer()
    local i = 1
    local sharp = #points
    TimerStart(t, 1/32, true, function()
        local pt = points[i]
        BlzSetSpecialEffectPosition(eff, pt.x,pt.y, 350)
        if CheckStoneDamage(pt.x, pt.y) then
            PauseTimer(t)
            DestroyEffect(eff)
            PlayStoneSound()
            DestroyTimer(t)
        end
        --BlzSetSpecialEffectYaw(eff, pt.yaw)
        --BlzSetSpecialEffectPitch(eff, pt.pitch)
        --BlzSetSpecialEffectRoll(ff, pt.roll)
        BlzSetSpecialEffectOrientation(eff, pt.yaw, pt.pitch, pt.roll)
        i = i + 1
        if i > sharp then
            PauseTimer(t)
            DestroyEffect(eff)
            PlayStoneSoundMain(pt.x, pt.y)
            DestroyTimer(t)
        end
    end)
end

function ThrowStones(duration)
    local points = RotatePoints(GetUnitX(boss), GetUnitY(boss), 200, 5)
    local t = {}
    for i = 1, 4 do
        local eff = AddSpecialEffect("models\\Rock3", points[i][1][1], points[i][1][2])
        BlzSetSpecialEffectScale(eff, 0.75)
        BlzSetSpecialEffectYaw(eff, math.random(1, 3))
        BlzSetSpecialEffectZ(eff, 350)
        table.insert(t, eff)
    end
    local rotateTimer = CreateTimer()
    local cd = CreateTimer()
    local waitDuration = CreateTimer()


    local n = 1
    local sharp = #points[1]
    TimerStart(rotateTimer, 1/32, true, function()
        for a = 1, 4 do
            BlzSetSpecialEffectPosition(t[a], points[a][n][1], points[a][n][2], 350)
        end
        if n == sharp then
            n = 2
        else
            n=n+1
        end
    end)
    TimerStart(cd, 0.5, true, function()
        ThrowStone()
    end)
    TimerStart(waitDuration, duration, false, function()
        PauseTimer(cd)
        DestroyTimer(cd)
        PauseTimer(rotateTimer)
        DestroyTimer(rotateTimer)
        for m = 1, #t do
            DestroyEffect(t[m])
        end
        DestroyTimer(waitDuration)
    end)
end