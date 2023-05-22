function _(code)
    return FourCC(code)
end

function HideDefaultUI()
    print("Hide")
    TimerStart(CreateTimer(), 1, false, function()
        --local info_bar = BlzFrameGetChild(ORIGIN_FRAME_GAME_UI, 1)
        local gameui = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
        BlzFrameSetVisible(BlzFrameGetChild(gameui, 1), false)
        BlzFrameSetAbsPoint(BlzGetFrameByName("ConsoleUIBackdrop", 0), FRAMEPOINT_TOPRIGHT, 0, 0)
        for i = 0, 11 do
            BlzFrameSetVisible(BlzGetFrameByName("CommandButton_" .. i, 0), false)
        end
        BlzHideOriginFrames(true)
        BlzFrameSetScale(BlzFrameGetChild(BlzGetFrameByName("ConsoleUI", 0), 5), 0.001)

    end)
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

function FindClosestUnit(units, x, y)
    local closestUnit = nil
    local closestDistance = math.huge
    for i, unit in ipairs(units) do
        local unitX, unitY = GetUnitPosition(unit)
        local distance = CalculateDistance(unitX, unitY, x, y)
        if distance < closestDistance then
            closestUnit = unit
            closestDistance = distance
        end
    end
    return closestUnit
end

function Shuffle (arr)
    for i = 1, #arr - 1 do
        local j = math.random (i, #arr)
        arr [i], arr [j] = arr [j], arr [i]
    end
end