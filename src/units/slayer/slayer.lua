function CreateSlayer()
    slayer = CreateUnit(Player(1), _('hrif'), 0, -500, bj_UNIT_FACING)
    SetUnitPathing(slayer, true)
    --SelectHeroSkill(boss, _('AUim'))
    SetUnitMoveSpeed(slayer, 522)



end





