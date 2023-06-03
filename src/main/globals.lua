function StatusList()
    CenterX = 1
    CenterY = 1
    Radius = 1800
    -----------
    slayerHP = 150
    slayerHPConst = 150
    Stage = 1 --текущая стадия
    ------
    creeps = {} --таблица крипов


    iconsUI = {} --иконки
    chargesUI = {} --заряды
    cooldownUI = {} --кулдауны
    ------
    CageOn = false --существует ли клетка на карте
    SlayerInsideCage = false --герой в клетке
    hexPoints = {} --координаты клетки

    castFireballs = false --кастует файрболлы
    castRocks = false --кастует глыбы
    castCarousel = false --кастует карусель жуков
    castCorpse = false --кастует трупы
    castBeetles = false --бросает жуков

    ------
    cooldown = false --кулдаун ракетницы
    rocketCharges = 125 --заряды ракетницы
    rocketChargesConst = 125
    lowAmmo = false --индикатор малого количества заряда ракетницы

    Chaining = false --юзает хук
    chaincooldown = false --кулдаун хука
    chainCharges = 3 --заряды хука
    chainChargesConst = 3
    chainCooldown = 0 --кулдаун хука
    chainCooldownConst = 10
    chainTargets = {} --возможные таргеты для хука
    slayerEffects = {} --таблица с эффектами для поиска цели хука
    slayerEffectsRed = {}
    targetEffects = {}

    acidGlobal = false --кислота на карте
    puddles = {} --координаты луж кислоты
    puddlesEffects = {} --таблица эффектов с кислотой

    beetleAtached = false --жук прицепился к герою
    beetleAttach = nil --глоаблка для хранения эффекта жука
    beetleHP = 3 --хп прицепившегося жука
    beetleFrame = nil --глобалка для фрейма с жуком

    sawing = false --герой пилит
    sawingCharges = 3 --заряды пилы
    sawingChargesConst = 3
    sawingDefaultReward = 40
    sawingDelay = 1 --ограничение на юз пилы подряд
    fuelOnMap = false --есть заспавненное топливо
    fuel = {} --таблица заспавненного топлива

    dashing = false --герой в рывке
    dashCharges = 4 --заряды рывка
    dashChargesConst = 4
    dashCooldown = 0 --кулдаун зарядя
    dashCooldownConst = 5.0
    -------
    cdTimer = nil --глобалка для таймера, обновляющего кулдауны
    cooldownUpdating = false --показывает, что работает таймер, обновляющий кулдауны
    ----------


end