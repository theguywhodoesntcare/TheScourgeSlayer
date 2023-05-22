function CreateSlayer()
    slayer = CreateUnit(Player(1), _('hrif'), 600, 200, bj_UNIT_FACING)
    SetUnitPathing(slayer, false)
    --SelectHeroSkill(boss, _('AUim'))
    SetUnitMoveSpeed(slayer, 522)
end

cooldown = false

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

    local t = CreateTimer()
    TimerStart(t, 1/64, true, function()
        local p = points[i]
        SetUnitPosition(slayer, p.x, p.y)
        SetUnitPosition(posdummy, p.x + (mouseX - slayerX), p.y + (mouseY - slayerY))
        i = i + 1
        if i > sharp then
            DestroyTimer(t)
        end
    end)
end

Chaining = false
function ChainHook()
    if not Chaining then
        local function MoveToTheTarget(points, effects, sharp)
            local i = 1
            local t2 = CreateTimer()
            TimerStart( t2, 1/64, true, function()
                p = points[i]
                DestroyEffect(effects[i])
                print(p.x.." "..p.y)
                if IsPointInCircle(p.x, p.y, CenterX, CenterY, Radius) then
                    SetUnitPosition(slayer, p.x, p.y)
                end
                i = i + 1
                if i > sharp - 8 then
                    Chaining = false
                end
                if i > sharp then
                    PauseTimer(t2)
                    EnableTrigger(ClickTrigger)
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
        local x, y = GetUnitPosition(slayer)


        local target = FindClosestUnit(creeps, cursorX, cursorY)
        local tX, tY = GetUnitPosition(target)


        if IsPointInCircle(tX, tY, x, y, 1000) and IsPointInCircle(tX, tY, cursorX, cursorY, 150) then
            Chaining = true
            print("chaining")
            DisableTrigger(ClickTrigger)
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
                eff = AddSpecialEffect("models\\chainlink", p.x, p.y)
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