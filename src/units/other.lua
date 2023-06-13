

function CreateTestUnit(snd)
    local xy = RandomPointInCircle(CenterX, CenterY, Radius)
    local testUnit = CreateUnit(Player(1), _('uaco'), xy[1], xy[2], bj_UNIT_FACING)
    SetUnitPathing(testUnit, false)
    SetUnitMoveSpeed(testUnit, 75)
    SetUnitInvulnerable(testUnit, true)
    SetUnitColor(testUnit, PLAYER_COLOR_SNOW)
    table.insert(creeps, testUnit)
    table.insert(chainTargets, testUnit)
    if snd then
        PlayAcolyte(xy[1], xy[2])
    end
end

function AddCreep()
    if #creeps < maxcreeps then
        local t = CreateTimer()
        local delay = math.random(5, 15)
        TimerStart(t, delay, false, function()
            CreateTestUnit(true)
        end)
    end
end

function CreateFakeColumn(x, y)
    local testUnit = CreateUnit(Player(1), _('fake'), x, y, bj_UNIT_FACING)
    SetUnitPathing(testUnit, false)
    SetUnitInvulnerable(testUnit, true)
    table.insert(chainTargets, testUnit)
end

function CreateDummy()
    local d = CreateUnit(Player(2), _('Dmmy'), -1500, -1500, bj_UNIT_FACING)
    SetHeroLevel(d, 10, false)
    SelectHeroSkill(d, _('AUim'))
    SetUnitInvulnerable(d, true)
    return d
end