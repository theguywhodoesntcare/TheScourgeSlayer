function CreateSlayer()
    slayer = CreateUnit(Player(1), _('hrif'), 600, 200, bj_UNIT_FACING)
    SetUnitPathing(slayer, false)
    --SelectHeroSkill(boss, _('AUim'))
    SetUnitMoveSpeed(slayer, 522)
    slayerEffects = {}
    slayerEffectsRed = {}
    targetEffects = {}
end

cooldown = false
chaincooldown = false

function MakeShot(x, y)
    local startx, starty = GetUnitPosition(slayer)
    if IsPointInCircle(startx, starty, CenterX, CenterY, Radius - 20) then
        if not cooldown then
            --cooldown = true
            --local cooldownTimer = CreateTimer()
            --TimerStart(cooldownTimer, 0.2, false, function()
                --cooldown = false
            --end)
            local projectile = AddSpecialEffect("Abilities\\Weapons\\GyroCopter\\GyroCopterMissile", startx, starty)


            local targetx = BlzGetTriggerPlayerMouseX()
            local targety = BlzGetTriggerPlayerMouseY()

            local angle, distance = CalculateAngle(startx, starty, targetx, targety)
            BlzSetSpecialEffectYaw( projectile, angle )
            BlzSetSpecialEffectZ(projectile, 350)
            local endpointX, endpointY = FindIntersection(startx, starty, targetx, targety)
            local hitplaceX, hitplaceY = RayCircleIntersection(startx, starty, endpointX, endpointY, GetUnitX(boss), GetUnitY(boss), 120)

            local movePoints = GetPointsOnLine(startx, starty, endpointX, endpointY, 20)
            local sharp = #movePoints
            local i = 1
            local t = CreateTimer()
            if hitplaceX == nill then
                TimerStart(t, 1/64, true, function()
                    BlzSetSpecialEffectX(projectile, movePoints[i].x)
                    BlzSetSpecialEffectY(projectile, movePoints[i].y)
                    BlzSetSpecialEffectZ(projectile, 350)

                    for a = 1, #creeps do
                        local testX, testY = GetUnitPosition(creeps[a])
                        if IsPointInCircle(movePoints[i].x, movePoints[i].y, testX, testY, 40) then
                            PauseTimer(t)
                            DestroyEffect(projectile)
                            ControlDmg(creeps[a])
                            DestroyTimer(t)
                        end
                    end
                    i = i+1
                    if i > sharp then
                        PauseTimer(t)
                        DestroyEffect(projectile)
                        DestroyTimer(t)
                    end
                end)
            else
                TimerStart(t, 1/64, true, function()
                    BlzSetSpecialEffectX(projectile, movePoints[i].x)
                    BlzSetSpecialEffectY(projectile, movePoints[i].y)
                    BlzSetSpecialEffectZ(projectile, 350)
                    local d = CalculateDistance(movePoints[i].x, movePoints[i].y, hitplaceX, hitplaceY)
                    local testX, testY = GetUnitPosition(testUnit)
                    for a = 1, #creeps do
                        local testX, testY = GetUnitPosition(creeps[a])
                        if IsPointInCircle(movePoints[i].x, movePoints[i].y, testX, testY, 40) then
                            PauseTimer(t)
                            DestroyEffect(projectile)
                            ControlDmg(creeps[a])
                            DestroyTimer(t)
                        end
                    end
                    if d <= 10 then
                        PauseTimer(t)
                        DestroyEffect(projectile)
                        DestroyTimer(t)
                    end
                    i = i+1
                    if i > sharp then
                        PauseTimer(t)
                        DestroyEffect(projectile)
                        DestroyTimer(t)
                    end
                end)
            end
        end
    end
end

function Sawing()
    local targets = {}
    local x, y = GetUnitPosition(slayer)


    local target = FindClosestUnit(creeps, x, y)
    local tX, tY = GetUnitPosition(target)
    if IsPointInCircle(tX, tY, x, y, 350) then
        SetUnitPosition(slayer, tX, tY)
        CameraSetFocalDistance(50)
    end
    local spriteframe = BlzCreateFrameByType("SPRITE", "SpriteName", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)

    PlaySawFleshSound()
    PlayScream()
    BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, 0.4, 0.3)
    BlzFrameSetLevel(spriteframe, 3)
    BlzFrameSetModel(spriteframe, "acowtf2", 0)
    BlzFrameSetSpriteAnimate(spriteframe, 0, 0)
    -- birth = 0
    -- death = 1
    -- stand = 2
    -- morph = 3
    -- alternate = 4
    BlzFrameSetVisible(spriteframe, true)
    Mask = BlzCreateFrameByType("BACKDROP", "Mask", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 1)
    BlzFrameSetLevel(Mask,4)
    BlzFrameSetAbsPoint(Mask, FRAMEPOINT_TOPLEFT, -0.14, 0.6)
    BlzFrameSetAbsPoint(Mask, FRAMEPOINT_BOTTOMRIGHT, 0.95, 0.0)
    BlzFrameSetTexture(Mask, "backdrops\\blood2", 0, true)
    BlzFrameSetAlpha(Mask, 0)
    local alpha = 0
    TimerStart(CreateTimer(), 1/32, true, function()
        alpha = alpha + 4
        if alpha >=255 then
            BlzFrameSetAlpha(Mask, 255)
            DestroyTimer(GetExpiredTimer())
        else
            BlzFrameSetAlpha(Mask, alpha)
        end
    end)

    local focal = 50

    TimerStart(CreateTimer(), 3.2, false, function()
        BlzDestroyFrame(spriteframe)
        TimerStart(CreateTimer(), 1/32, true, function()
            focal = focal + 10
            if focal >=500 then
                CameraSetFocalDistance(0)
                DestroyTimer(GetExpiredTimer())
            else
                CameraSetFocalDistance(focal)
            end
        end)
        TimerStart(CreateTimer(), 1/32, true, function()
            alpha = alpha - 4
            if alpha <=0 then
                BlzFrameSetAlpha(Mask, 0)
                DestroyTimer(GetExpiredTimer())
            else
                BlzFrameSetAlpha(Mask, alpha)
            end
        end)

        DestroyTimer(GetExpiredTimer())
    end)
end

function Dash()
    local distance = 400
    --local mouseX = BlzGetTriggerPlayerMouseX()
    --local mouseY = BlzGetTriggerPlayerMouseY()
    local mouseX, mouseY = GetUnitPosition(posdummy)

    local slayerX, slayerY = GetUnitPosition(slayer)

    local x, y = GetPointOnLine(slayerX, slayerY, mouseX, mouseY, distance)

    local points = GetPointsOnLine(slayerX, slayerY, x, y, 40)
    local i = 1
    local sharp = #points
    PlayDashSound()
    local t = CreateTimer()
    TimerStart(t, 1/64, true, function()
        if (GetUnitAbilityLevel(slayer, _('BUim')) == 0) then
            local p = points[i]
            local eff = AddSpecialEffect("models\\riflemanTrack", p.x, p.y)
            DestroyEffect(eff)
            SetUnitPosition(slayer, p.x, p.y)
            SetUnitPosition(posdummy, p.x + (mouseX - slayerX), p.y + (mouseY - slayerY))
            i = i + 1
            if i > sharp then
                DestroyTimer(t)
            end
        else
            DestroyTimer(t)
        end
    end)
end

Chaining = false
function ChainHook()
    if chainMarker and not Chaining and not chaincooldown then
        chainMarker = false
        local function MoveToTheTarget(points, effects, sharp)
            local i = 1
            local t2 = CreateTimer()
            TimerStart( t2, 1/64, true, function()
                p = points[i]
                DestroyEffect(effects[i])
                --print(p.x.." "..p.y)
                if IsPointInCircle(p.x, p.y, CenterX, CenterY, Radius) then
                    SetUnitPosition(slayer, p.x, p.y)
                    FixCursor(p.x, p.y)
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
                    DestroyTimer(t2)
                end
            end)
        end

        local targets = {}
        local cursorX = BlzGetTriggerPlayerMouseX()
        local cursorY = BlzGetTriggerPlayerMouseY()
        if IsPointInCircle(cursorX, cursorY, CenterX, CenterY, Radius) then
            local x, y = GetUnitPosition(slayer)


            local target = FindClosestUnit(creeps, cursorX, cursorY)
            local tX, tY = GetUnitPosition(target)

            if IsPointInCircle(x, y, CenterX, CenterY, Radius) and IsPointInCircle(tX, tY, x, y, 870) and IsPointInCircle(tX, tY, cursorX, cursorY, 150) then
                Chaining = true
                chaincooldown = true
                local cdtimer = CreateTimer()
                TimerStart(cdtimer, 2, false, function()
                    chaincooldown = false
                    DestroyTimer(cdtimer)
                end)
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
                    --IssueImmediateOrder(slayer, "stop") --kek
                    p = points[i]
                    eff = AddSpecialEffect("models\\chainlink1", p.x, p.y)
                    BlzSetSpecialEffectYaw( eff, angle )
                    table.insert(effects, eff)
                    i = i + 1
                    if i > sharp then
                        PauseTimer(t)
                        MoveToTheTarget(points, effects, sharp)
                        DestroyTimer(t)
                    end
                end)
                --SetUnitPosition(slayer, x1, y1)
            else
                PlayBrokenChain()
            end
        end
    end
end

globalMarkerDistance = 0
function FindChainTarget()
    if chainMarker == false then
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
            local target = FindClosestUnit(creeps, globalCursorX, globalCursorY)

            local tX, tY = GetUnitPosition(target)

            BlzSetSpecialEffectPosition(targetEffects[3], ux, uy, 320)


            local mx = BlzGetTriggerPlayerMouseX()
            --print(globalCursorX)
            local points = GetPointsOnLine(ux, uy, tX, tY, 60)
            local thetable = {}
            if IsPointInCircle(ux, uy, CenterX, CenterY, Radius) and IsPointInCircle(tX, tY, ux, uy, 870) and IsPointInCircle(tX, tY, globalCursorX, globalCursorY, 150) then
                BlzSetSpecialEffectPosition(targetEffects[2], -6000, -6000, 320)
                BlzSetSpecialEffectPosition(targetEffects[1], tX, tY, 320)

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
                BlzSetSpecialEffectPosition(targetEffects[1], -6000, -6000, 320)
                BlzSetSpecialEffectPosition(targetEffects[2], tX, tY, 320)

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
    end
end