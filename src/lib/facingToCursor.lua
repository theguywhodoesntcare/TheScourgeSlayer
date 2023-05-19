function SetUnitFaceToCursor()
    local x = BlzGetTriggerPlayerMouseX()
    local y = BlzGetTriggerPlayerMouseY()

    local ux, uy = GetUnitPosition(slayer)
    --local angle = CalculateAngle(ux, uy, x, y)
    --SetUnitFacing(slayer, angle*180/math.pi)
    --SetUnitPositionWithFacing(slayer, ux, uy, angle)
    local posx, posy = FindCenterRayIntersection(ux, uy, x, y, 256)
    SetUnitPosition(posdummy, posx, posy)
end