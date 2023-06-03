

function CreateTestUnit()
    local xy = RandomPointInCircle(CenterX, CenterY, Radius)
    local testUnit = CreateUnit(Player(1), _('uaco'), xy[1], xy[2], bj_UNIT_FACING)
    SetUnitPathing(testUnit, false)
    table.insert(creeps, testUnit)
    table.insert(chainTargets, testUnit)
end

function CreateFakeColumn(x, y)
    local testUnit = CreateUnit(Player(1), _('fake'), x, y, bj_UNIT_FACING)
    SetUnitPathing(testUnit, false)
    table.insert(chainTargets, testUnit)
end

function CreateDummy()
    local d = CreateUnit(Player(2), _('Dmmy'), -1500, -1500, bj_UNIT_FACING)
    SetHeroLevel(d, 10, false)
    SelectHeroSkill(d, _('AUim'))
    SetUnitInvulnerable(d, true)
    return d
end