creeps = {}

function CreateTestUnit()
    testUnit = CreateUnit(Player(1), _('hpea'), 600, 600, bj_UNIT_FACING)
    table.insert(creeps, testUnit)
end

function CreateDummy()
    local d = CreateUnit(Player(2), _('Dmmy'), -1500, -1500, bj_UNIT_FACING)
    SetHeroLevel(d, 10, false)
    SelectHeroSkill(d, _('AUim'))
    return d
end