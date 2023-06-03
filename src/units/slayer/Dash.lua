function Dash()
    if dashCharges > 0 then
        local distance = 400

        local mouseX, mouseY = GetUnitPosition(posdummy)

        local slayerX, slayerY = GetUnitPosition(slayer)

        local x, y = GetPointOnLine(slayerX, slayerY, mouseX, mouseY, distance)

        local points = GetPointsOnLine(slayerX, slayerY, x, y, 40)
        local i = 1
        local sharp = #points
        PlayDashSound()
        dashCharges = dashCharges - 1
        UpdateCharges(2, dashCharges)
        DisplayCooldown(true)
        local t = CreateTimer()
        TimerStart(t, 1/64, true, function()
            if (GetUnitAbilityLevel(slayer, _('BUim')) == 0) then
                local p = points[i]
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
    end
end
