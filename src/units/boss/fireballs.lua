function FireBall(startX, startY, endX, endY)
    --local angle = CalculateAngle(startX, endX, GetUnitX(slayer), GetUnitY(slayer))
    if IsPointInCircle(endX, endY, CenterX, CenterY, Radius) then
        --SetUnitFacing(boss, angle*180 / math.pi)
        SetUnitAnimationByIndex(boss, 7)
        local marker = AddSpecialEffect("models\\marker", endX, endY)
        BlzSetSpecialEffectScale(marker, 0.8)
        local maxZ = 820
        local startZ = 400
        local endZ = 220

        local points = ComputePath(startX, startY, startZ, endX, endY, endZ, maxZ, 30)
        local eff = AddSpecialEffect("Abilities\\Weapons\\FireBallMissile\\FireBallMissile", startX, startY)
        BlzSetSpecialEffectScale(eff, 1.5)
        local t = CreateTimer()
        local i = 1
        local sharp = #points

        TimerStart(t, 1/32, true, function()
            BlzSetSpecialEffectX(eff, points[i].x)
            BlzSetSpecialEffectY(eff, points[i].y)
            BlzSetSpecialEffectZ(eff, points[i].z)
            i = i + 1
            if i >= sharp then
                PauseTimer(t)
                CheckFireballDamage(points[i].x, points[i].y)
                DestroyEffect(marker)
                DestroyEffect(eff)
                DestroyTimer(t)
            end
        end)
    end
end

function FireBalls(time, bigCircleValue, littleCircleValue)
    --local time = 0.15
    --local bigCircleValue = 10
    --local littleCircleValue = 20


    local startX, startY = GetUnitPosition(boss)
    local endX, endY = GetUnitPosition(slayer)

    local targets = {}
    table.insert(targets, {endX, endY})

    for i = 1, littleCircleValue do
        table.insert(targets, RandomPointInCircle(endX, endY, 425))
    end
    for ii = 1, bigCircleValue do
        table.insert(targets, RandomPointInCircle(CenterX, CenterY, Radius))
    end
    local t = CreateTimer()
    local a = 1
    TimerStart(t, time, true, function()
        FireBall(startX, startY, targets[a][1], targets[a][2])
        a=a+1
        if a > #targets then
            PauseTimer(t)
            DestroyTimer(t)
        end
    end)
end