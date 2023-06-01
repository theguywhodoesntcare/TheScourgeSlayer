creeps = {}

function CreateTestUnit()
    local testUnit = CreateUnit(Player(1), _('uaco'), math.random(0, 800), math.random(0, 800), bj_UNIT_FACING)
    SetUnitPathing(testUnit, false)
    table.insert(creeps, testUnit)
end

function CreateDummy()
    local d = CreateUnit(Player(2), _('Dmmy'), -1500, -1500, bj_UNIT_FACING)
    SetHeroLevel(d, 10, false)
    SelectHeroSkill(d, _('AUim'))
    SetUnitInvulnerable(d, true)
    return d
end