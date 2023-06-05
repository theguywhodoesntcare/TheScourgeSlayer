function Dash()
    if dashCharges > 0 then
        local distance = 400

        local mouseX, mouseY = GetUnitPosition(posdummy)

        local slayerX, slayerY = GetUnitPosition(slayer)

        local x, y = GetPointOnLine(slayerX, slayerY, mouseX, mouseY, distance)

        if Stage == 2 and not IsPointInCircle(x, y, CenterX, CenterY, Radius) then
            x, y = FindIntersection(slayerX, slayerY, x, y)
            x, y = GetPointOnLine(x, y, slayerX, slayerY, 50)
        end

        local points = GetPointsOnLine(slayerX, slayerY, x, y, 40)
        local i = 1
        local sharp = #points
        PlayDashSound()
        dashCharges = dashCharges - 1
        if dashCharges <= 2 then
            if dashCharges <= 0 then
                SetIconEnable(iconsUI[2], false)
            end
            local rand = math.random()
            if rand <= 0.20 and #dashChargesItems < 3 then
                CreateCharge()
            end
        end

        UpdateCharges(2, dashCharges)
        DisplayCooldown(true)
        local t = CreateTimer()
        TimerStart(t, 1/64, true, function()
            if (GetUnitAbilityLevel(slayer, _('BUim')) == 0) then
                local p = points[i]

                if fuelOnMap then
                    local sharpF = #fuel
                    for f = 1, sharpF do
                        local fuelX = fuel[f][1][1]
                        local fuelY = fuel[f][1][2]
                        if IsPointInCircle(p.x, p.y, fuelX, fuelY , 80) then
                            --print(fuelX)
                            PickFuel(fuel[f], f)
                            break
                        end
                    end
                end
                if chargesOnMap then
                    local sharpC = #dashChargesItems
                    for c = 1, sharpC do
                        local chargeX = dashChargesItems[c][1][1]
                        local chargeY = dashChargesItems[c][1][2]
                        if IsPointInCircle(p.x, p.y, chargeX, chargeY , 80) then
                            --print(chargeX)
                            PickCharge(dashChargesItems[c], c)
                            break
                        end
                    end
                end

                if not CageOn then
                    local eff = AddSpecialEffect("models\\riflemanTrack", p.x, p.y)
                    DestroyEffect(eff)
                    SetUnitPosition(slayer, p.x, p.y)
                    SetUnitPosition(posdummy, p.x + (mouseX - slayerX), p.y + (mouseY - slayerY))
                    FixCursor(p.x, p.y)
                    i = i + 1
                    if i > sharp then
                        DestroyTimer(t)
                    end
                elseif SlayerInsideCage then
                    local xx, yy = GetPointOnLine(p.x, p.y, points[sharp].x, points[sharp].y, 20)
                    if not IsPointInHexagon(xx, yy, hexPoints) then
                        IssueImmediateOrder(slayer, "stop")
                        DestroyTimer(t)
                    else
                        local eff = AddSpecialEffect("models\\riflemanTrack", p.x, p.y)
                        DestroyEffect(eff)
                        SetUnitPosition(slayer, p.x, p.y)
                        SetUnitPosition(posdummy, p.x + (mouseX - slayerX), p.y + (mouseY - slayerY))
                        FixCursor(p.x, p.y)
                        i = i + 1
                        if i > sharp then
                            DestroyTimer(t)
                        end
                    end
                else
                    local xx, yy = GetPointOnLine(p.x, p.y, points[sharp].x, points[sharp].y, 20)
                    if IsPointInHexagon(xx, yy, hexPoints) then
                        IssueImmediateOrder(slayer, "stop")
                        DestroyTimer(t)
                    else
                        local eff = AddSpecialEffect("models\\riflemanTrack", p.x, p.y)
                        DestroyEffect(eff)
                        SetUnitPosition(slayer, p.x, p.y)
                        SetUnitPosition(posdummy, p.x + (mouseX - slayerX), p.y + (mouseY - slayerY))
                        FixCursor(p.x, p.y)
                        i = i + 1
                        if i > sharp then
                            DestroyTimer(t)
                        end
                    end
                end
            else
                DestroyTimer(t)
            end
        end)
    else
        PlayError()
    end
end


function CreateCharge()
    local xy = RandomPointInCircle(CenterX, CenterY, Radius-50)
    local eff = AddSpecialEffect("units\\nightelf\\Wisp\\Wisp", xy[1], xy[2])
    BlzSetSpecialEffectColorByPlayer(eff, Player(6))
    table.insert(dashChargesItems, {xy, eff})
    chargesOnMap = true
end



function PickCharge(chargeEff, index)
    --без проверки, просто добавить заряд

    DestroyEffect(chargeEff[2])
    table.remove(dashChargesItems, index)
    dashCharges = dashCharges + 1
    SetIconEnable(iconsUI[2], true)
    UpdateCharges(2, dashCharges)

    if #dashChargesItems == 0 then
        chargesOnMap = false
    end
end
