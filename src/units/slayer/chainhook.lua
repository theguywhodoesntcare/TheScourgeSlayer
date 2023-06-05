function ChainHook()
    if chainCharges > 0 then
        if chainMarker and not Chaining  then --and not chaincooldown
            chainMarker = false
            local function MoveToTheTarget(points, effects, sharp, unittarget)
                local i = 1
                local t2 = CreateTimer()
                TimerStart( t2, 1/64, true, function()
                    p = points[i]
                    DestroyEffect(effects[i])
                    if IsPointInCircle(p.x, p.y, CenterX, CenterY, Radius) then
                        if not CageOn then --блок для проверки на границы костяной тюрьмы, нужно вынести в отдельную функцию
                            SetUnitPosition(slayer, p.x, p.y)
                            --SetUnitPathing(slayer, false)
                            FixCursor(p.x, p.y)
                        elseif SlayerInsideCage then
                            local xx, yy = GetPointOnLine(p.x, p.y, points[sharp].x, points[sharp].y, 20)
                            if not IsPointInHexagon(xx, yy, hexPoints) then
                                for e = 1, #effects do
                                    DestroyEffect(effects[e])
                                end
                                IssueImmediateOrder(slayer, "stop")
                                EnableTrigger(ClickTrigger)
                                SetUnitInvulnerable(slayer, false)
                                InitWalkTimer()
                                --PauseUnit(slayer, false)
                                SetUnitMoveSpeed(slayer, 522)
                                Chaining = false
                                SetUnitMoveSpeed(unittarget, 75)
                                DestroyTimer(t2)
                            else
                                SetUnitPosition(slayer, p.x, p.y)
                                FixCursor(p.x, p.y)
                            end
                        else
                            local xx, yy = GetPointOnLine(p.x, p.y, points[sharp].x, points[sharp].y, 80)
                            if IsPointInHexagon(xx, yy, hexPoints) then
                                for e = 1, #effects do
                                    DestroyEffect(effects[e])
                                end
                                IssueImmediateOrder(slayer, "stop")
                                EnableTrigger(ClickTrigger)
                                SetUnitInvulnerable(slayer, false)
                                InitWalkTimer()
                                --PauseUnit(slayer, false)
                                SetUnitMoveSpeed(slayer, 522)
                                Chaining = false
                                DestroyTimer(t2)
                            else
                                SetUnitPosition(slayer, p.x, p.y)
                                FixCursor(p.x, p.y)
                            end
                        end
                    end
                    i = i + 1
                    if i > sharp - 8 then
                        Chaining = false
                    end
                    if i > sharp then
                        PauseTimer(t2)
                        EnableTrigger(ClickTrigger)
                        SetUnitInvulnerable(slayer, false)
                        InitWalkTimer()
                        --PauseUnit(slayer, false)
                        SetUnitMoveSpeed(slayer, 522)
                        Chaining = false
                        --local pathingTimer = CreateTimer()
                        --TimerStart(pathingTimer, 2, false, function()
                            --SetUnitPathing(slayer, true)
                           -- DestroyTimer(pathingTimer)
                        --end)
                        DestroyTimer(t2)
                    end
                end)
            end

            local targets = {}
            local cursorX = BlzGetTriggerPlayerMouseX()
            local cursorY = BlzGetTriggerPlayerMouseY()
            if IsPointInCircle(cursorX, cursorY, CenterX, CenterY, Radius) then
                local x, y = GetUnitPosition(slayer)


                local target = FindClosestUnit(chainTargets, cursorX, cursorY)
                local tX, tY = GetUnitPosition(target)

                if IsPointInCircle(x, y, CenterX, CenterY, Radius) and IsPointInCircle(tX, tY, x, y, 870) and IsPointInCircle(tX, tY, cursorX, cursorY, 150) then
                    IssueImmediateOrder(target, "stop")
                    SetUnitMoveSpeed(target, 0)
                    Chaining = true
                    --chaincooldown = true
                    chainCharges = chainCharges - 1
                    if chainCharges <= 0 then
                        SetIconEnable(iconsUI[4], false)
                    end
                    UpdateCharges(4, chainCharges)
                    DisplayCooldown(true)
                    --local cdtimer = CreateTimer()
                    --TimerStart(cdtimer, 2, false, function()
                        --chaincooldown = false
                        --DestroyTimer(cdtimer)
                    --end)
                    DisableTrigger(ClickTrigger)
                    DestroyTimer(walkTimer)
                    SetUnitInvulnerable(slayer, true)
                    PlayChain()
                    --PauseUnit(slayer, true)
                    SetUnitMoveSpeed(slayer, 0)
                    IssueImmediateOrder(slayer, "stop")
                    local x1, y1 = GetPointOnLine(tX, tY, x, y, 36)
                    local points = GetPointsOnLine(x, y, x1, y1, 34)
                    table.remove(points, #points)
                    local i = 1
                    local sharp = #points
                    local angle = CalculateAngle(x, y, x1, y1)
                    local t = CreateTimer()
                    local effects = {}

                    TimerStart( t, 1/64, true, function()
                        p = points[i]
                        eff = AddSpecialEffect("models\\chainlink1", p.x, p.y)
                        BlzSetSpecialEffectYaw( eff, angle )
                        table.insert(effects, eff)
                        i = i + 1
                        if i > sharp then
                            PauseTimer(t)
                            MoveToTheTarget(points, effects, sharp, target)
                            DestroyTimer(t)
                        end
                    end)
                else
                    PlayBrokenChain()
                end
            end
        end
    end
end

--globalMarkerDistance = 0
function FindChainTarget()
    --print(chainCharges)
    ------fix double circle
    if (not chainMarker) or (not rmbpressed) then
        for b = 1, #slayerEffects do
            DestroyEffect(slayerEffects[b])
        end
        for b = 1, #slayerEffectsRed do
            DestroyEffect(slayerEffectsRed[b])
        end
        for b = 1, #targetEffects do
            DestroyEffect(targetEffects[b])
        end
        slayerEffects = {}
        slayerEffectsRed = {}
        targetEffects = {}
    end
    --------
    if chainMarker == false and chainCharges > 0 then
        for i = 1, 32 do --создали пул эффектов вне зоны видимости
            local eff = AddSpecialEffect("models\\aoe_indicator", -6000, -6000)
            BlzSetSpecialEffectScale(eff, 0.5)
            BlzSetSpecialEffectColor(eff, 0, 255, 0)
            table.insert(slayerEffects, eff)
            local effr = AddSpecialEffect("models\\aoe_indicator", -6000, -6000)
            BlzSetSpecialEffectScale(effr, 0.5)
            BlzSetSpecialEffectColor(effr, 255, 0, 0)
            table.insert(slayerEffectsRed, effr)
        end

        local effT = AddSpecialEffect("models\\aoe_indicator", -6000, -6000) --models\\greencircle
        BlzSetSpecialEffectColor(effT, 0, 255, 0)
        BlzSetSpecialEffectScale(effT, 2)
        table.insert(targetEffects, effT)
        local effTr = AddSpecialEffect("models\\aoe_indicator", -6000, -6000)
        BlzSetSpecialEffectColor(effTr, 255, 0, 0)
        BlzSetSpecialEffectScale(effTr, 2)
        table.insert(targetEffects, 2, effTr)
        local effST = AddSpecialEffect("models\\aoe_indicator", -6000, -6000)
        BlzSetSpecialEffectScale(effST, 11)
        BlzSetSpecialEffectColor(effST, 0, 255, 0)
        table.insert(targetEffects, 3, effST)

        chainMarker = true
        local t = CreateTimer()
        TimerStart(t, 1/32, true, function()
            local ux, uy = GetUnitPosition(slayer)
            local target = FindClosestUnit(chainTargets, globalCursorX, globalCursorY)

            local tX, tY = GetUnitPosition(target)

            BlzSetSpecialEffectPosition(targetEffects[3], ux, uy, 320)


            local mx = BlzGetTriggerPlayerMouseX()
            --print(globalCursorX)
            local points = GetPointsOnLine(ux, uy, tX, tY, 60)
            local thetable = {}
            if IsPointInCircle(tX, tY, globalCursorX, globalCursorY, 150) then
                BlzSetSpecialEffectPosition(targetEffects[2], -6000, -6000, 320)
                BlzSetSpecialEffectPosition(targetEffects[1], tX, tY, 320)
            else
                BlzSetSpecialEffectPosition(targetEffects[1], -6000, -6000, 320)
                BlzSetSpecialEffectPosition(targetEffects[2], tX, tY, 320)
            end
            if IsPointInCircle(ux, uy, CenterX, CenterY, Radius) and IsPointInCircle(tX, tY, ux, uy, 870) then

                for a = 1, #slayerEffectsRed do
                    BlzSetSpecialEffectPosition(slayerEffectsRed[a], -6000, -6000, 370)
                end

                for a = 1, #points do
                    BlzSetSpecialEffectPosition(slayerEffects[a], points[a].x, points[a].y, 370)
                end

                for a = #points + 1, #slayerEffects do
                    BlzSetSpecialEffectPosition(slayerEffects[a], -6000, -6000, 370)
                end
            else
                if not IsPointInCircle(ux, uy, CenterX, CenterY, Radius) then
                    chainMarker = false
                    for b = 1, #slayerEffects do
                        DestroyEffect(slayerEffects[b])
                    end
                    for b = 1, #slayerEffectsRed do
                        DestroyEffect(slayerEffectsRed[b])
                    end
                    DestroyTimer(t)
                end

                for a = 1, #slayerEffects do
                    BlzSetSpecialEffectPosition(slayerEffects[a], -6000, -6000, 370)
                end

                for a = 1, #points do
                    BlzSetSpecialEffectPosition(slayerEffectsRed[a], points[a].x, points[a].y, 370)
                end

                for a = #points + 1, #slayerEffectsRed do
                    BlzSetSpecialEffectPosition(slayerEffectsRed[a], -6000, -6000, 370)
                end
            end

            if (not chainMarker) or (not rmbpressed) then
                for b = 1, #slayerEffects do
                    DestroyEffect(slayerEffects[b])
                end
                for b = 1, #slayerEffectsRed do
                    DestroyEffect(slayerEffectsRed[b])
                end
                for b = 1, #targetEffects do
                    DestroyEffect(targetEffects[b])
                end
                slayerEffects = {}
                slayerEffectsRed = {}
                targetEffects = {}
                DestroyTimer(t)
            end
        end)
    elseif chainCharges == 0 then
        PlayBrokenChain()
    end
end