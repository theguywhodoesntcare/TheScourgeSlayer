function _(code)
    return FourCC(code)
end

function GetUnitPosition(u)
    local x = GetUnitX(u)
    local y = GetUnitY(u)
    return x, y
end

function SetUnitPositionWithFacing(u, x, y, angle)
    SetUnitX(u, x)
    SetUnitY(u, y)
    SetUnitFacing(u, angle*180/math.pi)
end


function CreateTextFrame(frame, topleftX, topleftY, botrightX, botrightY, level, text, scale)
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_TOPLEFT, topleftX, topleftY)
    BlzFrameSetAbsPoint(frame, FRAMEPOINT_BOTTOMRIGHT, botrightX, botrightY)
    BlzFrameSetLevel(frame, level)
    BlzFrameSetText(frame, text)
    BlzFrameSetEnable(frame, false)
    BlzFrameSetScale(frame, scale)
    BlzFrameSetTextAlignment(frame, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)
end