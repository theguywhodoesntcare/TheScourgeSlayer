function Acid(numb, duration)
    local points = {}
    for i = 1, numb do
        table.insert(points, RandomPointInCircle(CenterX, CenterY, Radius))
    end

    --local acid = AddSpecialEffect("models\\puddle", 400, 400)
    --BlzSetSpecialEffectScale(acid, 1.5)
    local startX, startY = GetUnitPosition(boss)
    local t = CreateTimer()
    local a = 1
    SetUnitAnimationByIndex(boss, 7)
    PlayAcid()
    TimerStart(t, 1/32, true, function()
        AcidBomb(startX, startY, points[a][1], points[a][2])
        a=a+1
        if a > #points then
            PauseTimer(t)
            DestroyTimer(t)
        end
    end)

    ------------------

    local timerEnd = CreateTimer()
    local timerAlpha = CreateTimer()
    local alpha = 255
    TimerStart(timerEnd, duration, false, function()
        TimerStart(timerAlpha, 1/32, true, function()
            alpha = alpha - 2
            if alpha <= 0 then
                acidGlobal = false
                for ee = 1, #puddlesEffects do
                    BlzSetSpecialEffectAlpha(puddlesEffects[ee], 0)
                    DestroyEffect(puddlesEffects[ee])
                    puddlesEffects[ee] = nil
                    DestroyTimer(timerAlpha)
                end
                puddles = {}
                puddlesEffects = {}
            else
                for e = 1, #puddles do
                    BlzSetSpecialEffectAlpha(puddlesEffects[e], alpha)
                end
            end
            DestroyTimer(timerEnd)
        end)
    end)
end

function AcidBomb(startX, startY, endX, endY)
    if IsPointInCircle(endX, endY, CenterX, CenterY, Radius) then
        --SetUnitFacing(boss, angle*180 / math.pi)
        local maxZ = 820
        local startZ = 400
        local endZ = 220

        local points = ComputePath(startX, startY, startZ, endX, endY, endZ, maxZ, 30)
        local eff = AddSpecialEffect("Abilities\\Spells\\Other\\AcidBomb\\BottleMissile", startX, startY)
        --BlzSetSpecialEffectScale(eff, 1.5)
        local t = CreateTimer()
        local i = 1
        local sharp = #points

        TimerStart(t, 1/32, true, function()
            BlzSetSpecialEffectX(eff, points[i].x)
            BlzSetSpecialEffectY(eff, points[i].y)
            BlzSetSpecialEffectZ(eff, points[i].z)
            i = i + 1
            if i > sharp then
                PauseTimer(t)
                DestroyEffect(eff)

                local acid = AddSpecialEffect("models\\puddle2", points[i-2].x, points[i-2].y)
                BlzSetSpecialEffectYaw(acid, math.random() * 2 * math.pi)
                table.insert(puddles, {x = points[i-2].x, y = points[i-2].y})
                table.insert(puddlesEffects, acid)
                acidGlobal = true
                DestroyTimer(t)
            end
        end)
    end
end