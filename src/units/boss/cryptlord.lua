function CreateBoss()
    boss = CreateUnit(Player(1), _('Uanb'), 0, 0, bj_UNIT_FACING)
    SetHeroLevel(boss, 10, false)
    --SelectHeroSkill(boss, _('AUim'))
    SetUnitInvulnerable(boss, true)
    print("works")
    Invulnerable()
end





function Invulnerable()
    SetUnitColor(boss, PLAYER_COLOR_RED)
end





