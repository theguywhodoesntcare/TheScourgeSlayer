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