function TripleImpale(d)
    --print("triple impale")

    local targetX, targetY = GetUnitPosition(slayer)
    if IsPointInCircle(targetX, targetY, CenterX, CenterY, Radius) then
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
        --print(GetUnitPosition(impaleCasters[1]))

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
                --print(#effects)
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
end