function StatusList()
    Stage = 1 --текущая стадия
    ------
    CageOn = false --существует ли клетка на карте
    SlayerInsideCage = false --герой в клетке
    hexPoints = {} --координаты клетки
    ------
    cooldown = false --кулдаун ракетницы

    Chaining = false --юзает хук
    chaincooldown = false --кулдаун хука
    slayerEffects = {} --таблица с эффектами для поиска цели хука
    slayerEffectsRed = {}
    targetEffects = {}

    acidGlobal = false --кислота на карте
    puddles = {} --координаты луж кислоты
    puddlesEffects = {} --таблица эффектов с кислотой



end