function CreateSlayer()
    slayer = CreateUnit(Player(1), _('hrif'), 600, 200, bj_UNIT_FACING)
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