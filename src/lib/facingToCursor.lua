globalCursorX = 0
globalCursorY = 0

function SetUnitFaceToCursor()
    globalCursorX = BlzGetTriggerPlayerMouseX()
    globalCursorY = BlzGetTriggerPlayerMouseY()

    local ux, uy = GetUnitPosition(slayer)
    --local angle = CalculateAngle(ux, uy, x, y)
    --SetUnitFacing(slayer, angle*180/math.pi)
    --SetUnitPositionWithFacing(slayer, ux, uy, angle)
    local posx, posy = FindCenterRayIntersection(ux, uy, globalCursorX, globalCursorY, 256)
    SetUnitPosition(posdummy, posx, posy)
end

function FixPosition()

    --нужно сдвигать даммика на случай если курсор не двигается
    --костыль, и работает не очень хорошо
    --можно попробовать сдлать отдельный таймер с маленьким периодом, 1/64 или меньше
    local slayerX, slayerY = GetUnitPosition(slayer)
    local distance = CalculateDistance(slayerX, slayerY, globalX, globalY)
    globalX = slayerX
    globalY = slayerY

    if distance > 0 then
        local dummyX, dummyY = GetUnitPosition(posdummy)
        local x, y = GetPointOnLine(slayerX, slayerY, dummyX, dummyY, CalculateDistance(slayerX, slayerY, dummyX, dummyY)+125)
        local x2, y2 = MovePoint(slayerX, slayerY, dummyX, dummyY, x, y)
        SetUnitPosition(posdummy, x2, y2)
    end
end
