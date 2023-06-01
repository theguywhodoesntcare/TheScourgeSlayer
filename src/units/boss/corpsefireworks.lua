function CorpseBombs()
    local x, y = GetUnitPosition(slayer)
    CorpseBomb(x, y)
    local t = CreateTimer()
    local i = 0
    TimerStart(t, 1.5, true, function()
        local x, y = GetUnitPosition(slayer)
        --local endP = RandomPointInCircle(x, y, 600)
        CorpseBomb(x, y)
        --CorpseBomb(endP[1], endP[2])
        i = i + 1
        if i> 5 then
            DestroyTimer(t)
        end
    end)

end

function CorpseBomb(targetX, targetY)
    local startX, startY = GetUnitPosition(boss)
    local endX, endY = GetRandomPointOnCircle(GetUnitX(slayer), GetUnitY(slayer), 600)
    local maxZ = 1200
    local startZ = 400
    local endZ = 353

    local points = ComputePathWithRotation(startX, startY, startZ, targetX, targetY, endZ, maxZ, 50)
    local t = CreateTimer()
    local i = 1
    local sharp = #points
    local eff = AddSpecialEffect("models\\MeatWagon", startX, startY)
    BlzSetSpecialEffectScale(eff, 0.75)
    local marker = AddSpecialEffect("models\\marker", targetX, targetY)
    BlzSetSpecialEffectScale(marker, 1.5)
    TimerStart(t, 1/32, true, function()
        local p = points[i]
        BlzSetSpecialEffectPosition(eff, p.x, p.y, p.z)
        BlzSetSpecialEffectOrientation(eff, p.yaw, p.pitch, p.roll)

        i = i + 1
        if i > sharp then
            --BlzSetSpecialEffectOrientation(eff, 0, 0, 0)
            DestroyEffect(eff)
            local boom = AddSpecialEffect("Abilities\\Weapons\\FireBallMissile\\FireBallMissile", p.x, p.y)
            BlzSetSpecialEffectScale(boom, 2)
            DestroyEffect(boom)
            DestroyEffect(marker)
            BlzSetSpecialEffectRoll(eff, 0)
            BlzSetSpecialEffectPitch(eff, 0)
            CorpseFireworks(p.x, p.y, math.random(12, 24))
            CheckCorpseBombDamage(p.x, p.y)
            DestroyTimer(t)
        end
    end)
end

function CorpseFireworks(x, y, numb)
    for i = 1, numb do
        local eff = AddSpecialEffect("Abilities\\Weapons\\MeatwagonMissile\\MeatwagonMissile", x, y)
        local endP = RandomPointInCircle(x, y, 550)
        local marker = AddSpecialEffect("models\\marker", endP[1], endP[2])
        local maxZ = 820
        local startZ = 400
        local endZ = 320
        local points = ComputePath(x, y, startZ, endP[1], endP[2], endZ, maxZ, 20)

        local i = 1
        local sharp = #points
        local t = CreateTimer()
        TimerStart(t, 1/32, true, function()
            local p = points[i]
            BlzSetSpecialEffectPosition(eff, p.x, p.y, p.z)
            i = i + 1
            if i > sharp then
                PauseTimer(t)
                DestroyEffect(eff)
                DestroyEffect(marker)
                CheckCorpseFireworksDamage(p.x, p.y)
                DestroyTimer(t)
            end
        end)
    end
end