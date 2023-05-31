globalCursorX = 0
globalCursorY = 0

globalCursorXInit = 0
globalCursorYInit = 0


function SetUnitFaceToCursor()
    globalCursorX = BlzGetTriggerPlayerMouseX()
    globalCursorY = BlzGetTriggerPlayerMouseY()

    globalCursorXInit, globalCursorYInit = globalCursorX, globalCursorY

    local ux, uy = GetUnitPosition(slayer)
    globalX, globalY = ux, uy
    --local angle = CalculateAngle(ux, uy, x, y)
    --SetUnitFacing(slayer, angle*180/math.pi)
    --SetUnitPositionWithFacing(slayer, ux, uy, angle)
    local posx, posy = FindCenterRayIntersection(ux, uy, globalCursorX, globalCursorY, 256)
    SetUnitPosition(posdummy, posx, posy)
end


function FixCursor(localX, localY)
    local deltaX = localX - globalX
    local deltaY = localY - globalY

    if deltaX ~= 0 or deltaY ~= 0 then
        globalCursorX = globalCursorXInit + deltaX
        globalCursorY = globalCursorYInit + deltaY
    end

    local posx, posy = FindCenterRayIntersection(localX, localY, globalCursorX, globalCursorY, 256)
    SetUnitPosition(posdummy, posx, posy)
end