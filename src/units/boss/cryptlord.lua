function CreateBoss()
    boss = CreateUnit(Player(1), _('Uanb'), 0, 0, bj_UNIT_FACING)
    SetHeroLevel(boss, 10, false)
    --SelectHeroSkill(boss, _('AUim'))
    SetUnitInvulnerable(boss, true)
    --print("works")
    Invulnerable(true)
end





function Invulnerable(flag)
    if flag then
        SetUnitColor(boss, PLAYER_COLOR_RED)
        BlzFrameSetModel(bar, "sprites\\testbar.mdx", 0)
        SetUnitInvulnerable(boss, true)
        local sX, sY = GetUnitPosition(slayer)
        local x, y = GetUnitPosition(boss)
        local angle = CalculateAngle(x, y, sX, sY)
        --SetUnitFacing(boss, angle*180 / math.pi)
        SetUnitAnimation(boss, "stand")
        BlzFrameSetVisible(invul, true)
    else
        SetUnitColor(boss, PLAYER_COLOR_GREEN)
        BlzFrameSetModel(bar, "sprites\\testbar1.mdx", 0)
        SetUnitInvulnerable(boss, false)
        local sX, sY = GetUnitPosition(slayer)
        local x, y = GetUnitPosition(boss)
        local angle = CalculateAngle(x, y, sX, sY)
        --SetUnitFacing(boss, angle *180 / math.pi)
        SetUnitAnimation(boss, "stand")
        BlzFrameSetVisible(invul, false)
    end
end





