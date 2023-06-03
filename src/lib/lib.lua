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


function CreateTextFrame(frame, topleftX, topleftY, botrightX, botrightY, level, text, scale) --old
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

function CreateBackdrop(parent, centerX, centerY, size, texture, lvl)
    local fr = BlzCreateFrameByType("BACKDROP", "", parent, "", 1)
    BlzFrameSetLevel(fr, lvl)
    BlzFrameSetAbsPoint(fr, FRAMEPOINT_CENTER, centerX, centerY)
    BlzFrameSetSize(fr, size, size)
    BlzFrameSetTexture(fr, texture, 0, true)
    return fr
end

function CreateBackdropTwoPoints(parent, topleftX, topleftY, botrightX, botrightY, texture, lvl)
    local fr = BlzCreateFrameByType("BACKDROP", "", parent, "", 1)
    BlzFrameSetLevel(fr, lvl)
    BlzFrameSetAbsPoint(fr, FRAMEPOINT_TOPLEFT, topleftX, topleftY)
    BlzFrameSetAbsPoint(fr, FRAMEPOINT_BOTTOMRIGHT, botrightX, botrightY)
    BlzFrameSetTexture(fr, texture, 0, true)
    return fr
end

function CreateText(parent, centerX, centerY, size, text, lvl)
    local fr = BlzCreateFrameByType("TEXT", "", parent, "", 0)
    BlzFrameSetLevel(fr, lvl)
    BlzFrameSetAbsPoint(fr, FRAMEPOINT_CENTER, centerX, centerY)
    BlzFrameSetSize(fr, size, size)
    BlzFrameSetText(fr, text)
    BlzFrameSetEnable(fr, false)
    BlzFrameSetScale(fr, 1)
    BlzFrameSetTextAlignment(fr, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)
    return fr
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end