function CalculateAngleAndDistance(x1, y1, x2, y2)
    --возвращает угол в радианах и расстояние между двумя точками
    local deltaX = x2 - x1
    local deltaY = y2 - y1

    local angle
    if deltaX == 0 then
        if deltaY > 0 then
            angle = math.pi / 2
        else
            angle = -math.pi / 2
        end
    else
        angle = math.atan(deltaY / deltaX)
        if deltaX < 0 then
            angle = angle + math.pi
        end
    end

    local distance = math.sqrt(deltaX^2 + deltaY^2)
    return angle, distance
end

function CalculateAngle(x1, y1, x2, y2)
    --возвращает угол в радианах между двумя точками
    local deltaX = x2 - x1
    local deltaY = y2 - y1

    local angle
    if deltaX == 0 then
        if deltaY > 0 then
            angle = math.pi / 2
        else
            angle = -math.pi / 2
        end
    else
        angle = math.atan(deltaY / deltaX)
        if deltaX < 0 then
            angle = angle + math.pi
        end
    end

    return angle
end

function CalculateDistance(x1, y1, x2, y2)
    --возвращает расстояние между двумя точками
    local deltaX = x2 - x1
    local deltaY = y2 - y1

    local distance = math.sqrt(deltaX^2 + deltaY^2)
    return distance
end

function FindIntersection(x1, y1, x2, y2)
    --возвращает точку пересечения луча, проходящего через две произвольных точки внутри окружности, с этой окружностью
    local dx = x2 - x1
    local dy = y2 - y1
    local a = dx^2 + dy^2
    local b = 2 * (dx * (x1 - CenterX) + dy * (y1 - CenterY))
    local c = CenterX^2 + CenterY^2 + x1^2 + y1^2 - 2 * (CenterX * x1 + CenterY * y1) - Radius^2
    local bb4ac = b^2 - 4 * a * c
    if bb4ac < 0 then
        return nil
    end
    local mu = (-b + math.sqrt(bb4ac)) / (2 * a)
    local ix1 = x1 + mu * dx
    local iy1 = y1 + mu * dy
    mu = (-b - math.sqrt(bb4ac)) / (2 * a)
    local ix2 = x1 + mu*dx
    local iy2 = y1 + mu*dy

    if (ix1-x1)*(ix2-x1) > 0 or (iy1-y1)*(iy2-y1) > 0 then
        return nil
    end

    return ix1, iy1
end

function FindCenterRayIntersection(x1, y1, x2, y2, radius)
    --возвращает точку пересечения луча, проходящего через центр окружности и произвольную точку, с этой окружностью
    local angle = CalculateAngle(x1, y1, x2, y2)
    local x3 = x1 + radius * math.cos(angle)
    local y3 = y1 + radius * math.sin(angle)
    return x3, y3
end

--function GetPointsOnLine(x1, y1, x2, y2, d)
  --  local points = {}
   -- local k = (y2 - y1) / (x2 - x1)
  --  local b = y1 - k * x1
  --  local dx = d / math.sqrt(1 + k * k)
  --  local x = x1 + dx
   -- local y = k * x + b
  --  while (x2 > x1 and x < x2) or (x2 < x1 and x > x2) do
   --     table.insert(points, {x = x, y = y})
  --      x = x + dx
   --     y = k * x + b
  --  end
  --  return points
--end

function GetPointsOnLine(x1, y1, x2, y2, d)
    --возвращает массив точек, делящих луч на отрезки
    local points = {}
    local dx = x2 - x1
    local dy = y2 - y1
    local dist = math.sqrt(dx * dx + dy * dy)
    local steps = math.floor(dist / d)
    for i = 1, steps+1 do
        local t = i / steps
        local x = x1 + dx * t
        local y = y1 + dy * t
        table.insert(points, {x = x, y = y})
    end
    table.insert(points, {x = x2, y = y2})
    return points
end

function GetPointsOnLineWithRotation(x1, y1, x2, y2, d)
    --возвращает массив точек, делящих луч на отрезки, а также рандомные значения вращения
    --с pitch возникает какой-то баг, если задавать через SetPitch
    local points = {}
    local dx = x2 - x1
    local dy = y2 - y1
    local dist = math.sqrt(dx * dx + dy * dy)
    local steps = math.floor(dist / d)

    local startYaw = math.random(-math.pi, math.pi)
    local endYaw = math.random(-math.pi, math.pi)
    local startPitch = math.random(-math.pi, math.pi)
    local endPitch = math.random(-math.pi, math.pi)
    local startRoll = math.random(-math.pi, math.pi)
    local endRoll = math.random(-math.pi, math.pi)

    for i = 1, steps+1 do
        local t = i / steps
        local x = x1 + dx * t
        local y = y1 + dy * t
        local yaw = startYaw + (endYaw - startYaw) * t
        local pitch = startPitch + (endPitch - startPitch) * t
        local roll = startRoll + (endRoll - startRoll) * t
        table.insert(points, {x = x, y = y, yaw = yaw, pitch = pitch, roll = roll})
    end

    table.insert(points, {x = x2, y = y2, yaw = endYaw, pitch = endPitch, roll = endRoll})
    return points
end

function GetPointOnLine(x1, y1, x2, y2, d)
    --возвращает точку на луче, удалённую от начальной точки на расстояние d
    local dx = x2 - x1
    local dy = y2 - y1
    local dist = math.sqrt(dx * dx + dy * dy)
    --local dist = CalculateDistance(x1, y1, x2, y2)
    local t = d / dist
    local x = x1 + dx * t
    local y = y1 + dy * t
    return x, y
end


function RayCircleIntersection(x1, y1, x2, y2, x3, y3, r)
    --возвращает первую точку пересечения луча с окружностью. Иначе возвращает nil
    local dx = x2 - x1
    local dy = y2 - y1
    local a = dx * dx + dy * dy
    local b = 2 * (dx * (x1 - x3) + dy * (y1 - y3))
    local c = (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3) - r * r
    local disc = b * b - 4 * a * c
    if disc < 0 then
        return nil
    else
        local t1 = (-b + math.sqrt(disc)) / (2 * a)
        local t2 = (-b - math.sqrt(disc)) / (2 * a)
        if t1 >= 0 and (t2 < 0 or t1 < t2) then
            return x1 + t1 * dx, y1 + t1 * dy
        elseif t2 >= 0 then
            return x1 + t2 * dx, y1 + t2 * dy
        else
            return nil
        end
    end
end

function IsPointInCircle(x1, y1, x2, y2, r)
    --возвращает true, если точка находится в окружности с центром (x2, y2) и радиусом r
    local distance = CalculateDistance(x1, y1, x2, y2, r)
    return distance < r
end

function QuadraticBezier(z1, z2, z3, t)
    --возвращает значение координаты на кривой безье
    local u = 1 - t
    local tt = t * t
    local uu = u * u
    local z = uu * z1 + 2 * u * t * z2 + tt * z3
    return z
end

function ComputePath(x1, y1, z1, x3, y3, z3, z2, d)
    --возвращает таблицу значений координат полёта снаряда
    local dx = x3 - x1
    local dy = y3 - y1
    local distance = math.sqrt(dx * dx + dy * dy)

    local n = math.ceil(distance / d)

    local path = {}

    for i = 0, n do
        local t = i / n

        local x = x1 + t * (x3 - x1)
        local y = y1 + t * (y3 - y1)
        local z = QuadraticBezier(z1,z2,z3,t)

        table.insert(path, {x = x, y = y, z = z})
    end

    return path
end

function RandomPointInCircle(xCenter, yCenter, radius)
    --возвращает случайную точку в пределах окружности
    local theta = math.random() * 2 * math.pi
    local r = math.sqrt(math.random()) * radius
    local x = xCenter + r * math.cos(theta)
    local y = yCenter + r * math.sin(theta)
    return {x, y}
end

function RandomPointInCircleXY(xCenter, yCenter, radius)
    --возвращает случайную точку в пределах окружности
    local theta = math.random() * 2 * math.pi
    local r = math.sqrt(math.random()) * radius
    local x = xCenter + r * math.cos(theta)
    local y = yCenter + r * math.sin(theta)
    return x, y
end

function IsCirclesIntersect(x1, y1, r1, x2, y2, r2)
    --возвращает true если две окржуности пересекаются
    local dx = x2 - x1
    local dy = y2 - y1
    local distance = math.sqrt(dx * dx + dy * dy)
    return distance < r1 + r2
end

function RotatePoints(centerX, centerY, radius, step)
    --возвращает таблицу значений x,y для вращения четырёх точек по окружности
    local points = {{},{},{},{}}
    for angle = 0, 360, step do
        local radians = math.rad(angle)
        for i = 1, 4 do
            local x = centerX + radius * math.cos(radians + math.pi/2 * (i-1))
            local y = centerY + radius * math.sin(radians + math.pi/2 * (i-1))
            table.insert(points[i], {x, y})
        end
    end
    return points
end

function MovePoint(x1, y1, x2, y2, x3, y3)
    local angle = CalculateAngleAndDistance(x1, y1, x2, y2)
    local dist = CalculateDistance(x1, y1, x3, y3)
    local newX3 = x1 + dist * math.cos(angle)
    local newY3 = y1 + dist * math.sin(angle)
    return newX3, newY3
end


function GetPointsOnCircle(centerX, centerY, radius, interval)

    --возвращает таблицу точек на окружности
    local points = {}
    local numPoints = math.floor(2 * math.pi / interval)
    print(numPoints)
    for i = 1, numPoints do
        local angle = interval * (i - 1)
        local x = centerX + radius * math.cos(angle)
        local y = centerY + radius * math.sin(angle)
        table.insert(points, {x = x, y = y})
    end
    return points
end