function CreateBoss()
    boss = CreateUnit(Player(1), _('Uanb'), 0, 0, bj_UNIT_FACING)
    SetHeroLevel(boss, 10, false)
    --SelectHeroSkill(boss, _('AUim'))
    SetUnitInvulnerable(boss, true)
    print("works")
    Invulnerable()
end

function TripleImpale(d)
    print("triple impale")

    local targetX, targetY = GetUnitPosition(slayer)
    local target1 = {targetX, targetY}

    local casterX, casterY = GetUnitPosition(boss)
    local casterX, casterY = GetPointOnLine(casterX, casterY, targetX, targetY, 80)


    local angle, distance = CalculateAngleAndDistance(casterX, casterY, targetX, targetY)
    SetUnitFacing(boss, angle*180 / math.pi)
    SetUnitAnimationByIndex(boss, 7)

    local leftAngle = angle + math.rad(d)
    local rightAngle = angle - math.rad(d)

    local target1X = casterX + distance * math.cos(leftAngle)
    local target1Y = casterY + distance * math.sin(leftAngle)
    local target2 = {target1X, target1Y}

    local target2X = casterX + distance * math.cos(rightAngle)
    local target2Y = casterY + distance * math.sin(rightAngle)
    local target3 = {target2X, target2Y}

    local targets = {target1, target2, target3}
    local angles = {angle, leftAngle, rightAngle}
    local points = {}
    local endpoints = {}

    for i = 1, #impaleCasters do
        local endpointX, endpointY = FindIntersection(casterX, casterY, targets[i][1], targets[i][2])
        table.insert(endpoints, i, {endpointX, endpointY})
        local trueDistance = CalculateDistance(casterX, casterY, endpointX, endpointY)
        local impspll = BlzGetUnitAbility(impaleCasters[i], _('AUim'))
        BlzSetAbilityRealLevelField(impspll, ABILITY_RLF_WAVE_DISTANCE, 0, trueDistance)
        SetUnitPositionWithFacing(impaleCasters[i], casterX, casterY, angles[i])
        local linePoints = GetPointsOnLine(casterX, casterY, endpointX, endpointY, 100)
        table.insert(points, i, linePoints)


    end
    print(GetUnitPosition(impaleCasters[1]))

    local effects = {}
    local iTable = {1, 1, 1}
    for l = 1, 3 do
        TimerStart( CreateTimer(), 1/#points[l], true, function()
            eff = AddSpecialEffect("models\\redtriangle3", points[l][iTable[l]].x, points[l][iTable[l]].y)
            BlzSetSpecialEffectYaw( eff, angles[l] )
            PlayImpaleMarkerSound(points[l][iTable[l]].x, points[l][iTable[l]].y)
            table.insert(effects, eff)
            iTable[l] = iTable[l] + 1
            if iTable[l] == #points[l] then
                PauseTimer(GetExpiredTimer())
                DestroyTimer(GetExpiredTimer())
            end
        end)
    end

    local castDelay = CreateTimer()
    TimerStart(castDelay, 0.75, false, function()


        IssuePointOrder(dummy1, "impale", endpoints[1][1], endpoints[1][2])

        IssuePointOrder(dummy2, "impale", endpoints[2][1], endpoints[2][2])

        IssuePointOrder(dummy3, "impale", endpoints[3][1], endpoints[3][2])


        local t1 = CreateTimer()
        TimerStart(t1, 0.4, false, function()
            CameraSetEQNoiseForPlayer( Player(0), 30.00 )
            PlayImpaleSound()
            DestroyTimer(t1)
        end)

        local t2 = CreateTimer()
        TimerStart(t2, 0.65, false, function()
            CameraClearNoiseForPlayer( Player(0) )
            print(#effects)
            for e = 1, #effects do
                DestroyEffect(effects[e])
            end
            DestroyTimer(t2)
        end)

        local t = CreateTimer()
        TimerStart(t, 0.75, false, function()
            for i = 1, 3 do
                SetUnitPosition(impaleCasters[i], -1500, -1500)
            end
            DestroyTimer(t)
        end)
        DestroyTimer(castDelay)
    end)
end

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

function FireBalls()
    local time = 0.15
    local bigCircleValue = 10
    local littleCircleValue = 20


    local startX, startY = GetUnitPosition(boss)
    local endX, endY = GetUnitPosition(slayer)

    local targets = {}
    table.insert(targets, {endX, endY})

    for i = 1, littleCircleValue do
        table.insert(targets, RandomPointInCircle(endX, endY, 600))
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

function Bugs()
    local x1, y1 = GetRandomPointOnCircle(CenterX, CenterY, Radius)
    local x2, y2 = GetOppositePointOnCircle(CenterX, CenterY, x1, y1)

    local x3, y3, x4, y4 = GetPerpendicularDiameter(Radius, x1, y1, x2, y2)
    BugLine(x1, y1, x2, y2)
    BugLine(x3, y3, x4, y4)
end

function BugLine(x1, y1, x2, y2)
    local diameterPoints = GetPointsOnLine(x1, y1, x2, y2, 160)
    for n = #diameterPoints, 1, -1 do
        if IsPointInCircle(diameterPoints[n].x, diameterPoints[n].y, GetUnitX(boss), GetUnitY(boss), 20) then
            table.remove(diameterPoints, n)
            print("wrong bug")
        end
    end
    table.insert(diameterPoints, 1, {x = x1, y = y1})
    local angle = CalculateAngle(x1, y1, x2, y2)
    local effects = {}
    for a = 1, #diameterPoints do
        local eff = AddSpecialEffect("models\\bug", diameterPoints[a].x, diameterPoints[a].y)
        if a <= #diameterPoints/2 then
            BlzSetSpecialEffectYaw(eff, angle + math.pi/2)
        else
            BlzSetSpecialEffectYaw(eff, angle - math.pi/2)
        end
        local t = CreateTimer()
        TimerStart(t, 1, false, function()
            BlzPlaySpecialEffect(eff, ANIM_TYPE_WALK)
            DestroyTimer(t)
        end)
        table.insert(effects, eff)
    end

    local newAngle = 0
    local tim = CreateTimer()
    TimerStart(tim, 1/32, true, function()
        local points = RotateDiameter(diameterPoints, CenterX, CenterY, newAngle * math.pi/180)
        local yaw = CalculateAngle(points[1].x, points[1].y, points[#points].x, points[#points].y)
        for i = 1, #effects do
            local p = points[i]
            BlzSetSpecialEffectPosition(effects[i], p.x, p.y, 320)
            BlzSetSpecialEffectScale(effects[i], 2)
            if i <= #diameterPoints/2 then
                BlzSetSpecialEffectYaw(effects[i], yaw + math.pi/2)
            else
                BlzSetSpecialEffectYaw(effects[i], yaw -  math.pi/2)
            end

        end
        newAngle = newAngle + 1.5
        if newAngle > 360 then
            newAngle = 0
        end
    end)
end

function Invulnerable()
    SetUnitColor(boss, PLAYER_COLOR_RED)
end

function Acid(numb)
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
    TimerStart(timerEnd, 45, false, function()
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

function Cage(radius, duration)
    local x, y = GetUnitPosition(slayer)
    local effects = {}
    hexPoints = GetHexagonPoints(x, y, radius, radius/2.5)
    local pointsChain = GetHexagonPoints(x, y, radius, 40)
    print(#hexPoints)
    local d = 1
    local sharp = #pointsChain
    local chainTimer = CreateTimer()
    PlayCage()
    TimerStart(chainTimer, 1/64, true, function()
        local p1 = pointsChain[d]
        local chain = AddSpecialEffect("models\\chainlink2", p1.x, p1.y )
        if d < #pointsChain then
            local angleChain = CalculateAngle(p1.x, p1.y, pointsChain[d+1].x, pointsChain[d+1].y)
            BlzSetSpecialEffectYaw(chain, angleChain)
            BlzSetSpecialEffectScale(chain, 1.15)
            table.insert(effects, chain)
        else
            local angleChain = CalculateAngle(p1.x, p1.y, pointsChain[1].x, pointsChain[1].y)
            BlzSetSpecialEffectYaw(chain, angleChain)
            BlzSetSpecialEffectScale(chain, 1.1)
            table.insert(effects, chain)
        end
        d = d + 1
        if d > sharp then
            for i = 1, #hexPoints do
                local p = hexPoints[i]
                local eff = AddSpecialEffect("models\\skeleton", p.x, p.y)
                local angle = CalculateAngle(p.x, p.y, x, y)
                BlzSetSpecialEffectYaw(eff, angle)
                table.insert(effects, eff)
            end
            CageOn = true
            local spriteframe = CageFrame()
            if IsPointInHexagon(GetUnitX(slayer), GetUnitY(slayer), hexPoints) then
                BlzFrameSetVisible(spriteframe, true)
                SlayerInsideCage = true
                local frameTimer = CreateTimer()
                local pos = 1.1
                TimerStart(frameTimer, 1/32, true, function()
                    pos = pos - 0.02
                    BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, pos, -0.036)
                    if pos <= 0.82 then
                        DestroyTimer(frameTimer)
                    end
                end)
            end
            local cageTimer = CreateTimer()
            TimerStart(cageTimer, duration, false, function()
                for e = 1, #effects do
                    DestroyEffect(effects[e])
                end
                SlayerInsideCage = false
                CageOn = false
                local frameTimer1 = CreateTimer()
                local pos = 0.82
                TimerStart(frameTimer1, 1/32, true, function()
                    pos = pos + 0.02
                    BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, pos, -0.036)
                    if pos >= 1.1 then
                        BlzDestroyFrame(spriteframe)
                        DestroyTimer(frameTimer1)
                    end
                end)
                hexPoints = {}
                DestroyTimer(cageTimer)
            end)
            DestroyTimer(chainTimer)
        end
    end)
    print(IsPointInHexagon(x, y, hexPoints))
end

function CageFrame()
    local spriteframe = BlzCreateFrameByType("SPRITE", "SpriteName", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
    BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, 1.1, -0.036)
    BlzFrameSetSize(spriteframe, 0.001, 0.001)
    BlzFrameSetScale(spriteframe, 1)
    BlzFrameSetLevel(spriteframe, 3)
    BlzFrameSetModel(spriteframe, "models\\skeletonsprite2", 1)
    BlzFrameSetSpriteAnimate(spriteframe, 2, 2)
    BlzFrameSetVisible(spriteframe, false)

    return spriteframe
end

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

function BeetleLaunch()
    local maxZ = 820
    local startZ = 400
    local endZ = 330
    local x, y = GetUnitPosition(slayer)
    local startX, startY = GetUnitPosition(boss)
    local eff = AddSpecialEffect("Units\\Undead\\ScarabLvl3\\ScarabLvl3", startX, startY)
    BlzPlaySpecialEffect(eff, ANIM_TYPE_WALK)
    BlzSetSpecialEffectScale(eff, 1.5)
    local angle = CalculateAngle(startX, startY, x, y)
    BlzSetSpecialEffectYaw(eff, angle)
    local points = ComputePath(startX, startY, startZ, x, y, endZ, maxZ, 30)

    local i = 1
    local sharp = #points
    local t = CreateTimer()

    TimerStart(t, 1/32, true, function()
        p = points[i]
        BlzSetSpecialEffectPosition(eff, p.x, p.y, p.z)
        local xx, yy = GetUnitPosition(slayer)
        local angle = CalculateAngle(p.x, p.y, xx, yy)
        BlzSetSpecialEffectYaw(eff, angle)
        i = i + 1
        if i > sharp then
            PauseTimer(t)
            BeetleCharge(eff, p.x, p.y, p.z)
            DestroyTimer(t)
        end
    end)
end

function BeetleCharge(beetle, x, y, z)
    local ux, uy = GetUnitPosition(slayer)
    local endX, endY = FindIntersection(x, y, ux, uy)
    local points = GetPointsOnLine(x, y, endX, endY, 15)
    local angle = CalculateAngle(x, y, endX, endY)
    BlzSetSpecialEffectYaw(beetle, angle)

    local i = 1
    local sharp = #points
    local t = CreateTimer()
    TimerStart(t, 1/64, true, function()
        local p = points[i]
        BlzSetSpecialEffectPosition(beetle, p.x, p.y, z)
        if CheckBeetleDamage(p.x, p.y) then
            DestroyEffect(beetle)
            DestroyTimer(t)
        end
        i = i + 1
        if i > sharp then
            DestroyEffect(beetle)
            DestroyTimer(t)
        end
    end)
end