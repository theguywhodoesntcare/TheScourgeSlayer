RealGetUnitX = GetUnitX
RealGetUnitY = GetUnitY


function GetUnitRealX(unit)
    local collision = math.floor(BlzGetUnitCollisionSize(unit) + 0.5)

    if not IsUnitType(unit, UNIT_TYPE_STRUCTURE) then
        if (collision < 32 and collision > 15) or collision > 47 then return RealGetUnitX(unit) - 16. end
    end

    return RealGetUnitX(unit)
end

function GetUnitRealY(unit)
    local collision = math.floor(BlzGetUnitCollisionSize(unit) + 0.5)

    if not IsUnitType(unit, UNIT_TYPE_STRUCTURE) then
        if (collision < 32 and collision > 15) or collision > 47 then return RealGetUnitY(unit) - 16. end
    end

    return RealGetUnitY(unit)
end