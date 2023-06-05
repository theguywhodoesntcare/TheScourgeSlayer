function StatusList()
    CenterX = 1
    CenterY = 1
    Radius = 1800
    barrier = {} -- таблица эффектов
    -----------
    slayerHP = 180
    slayerHPConst = 180
    Stage = 1 --текущая стадия
    safetyZone = false --герой ввышел из поля битвы
    ------
    bossHP = 300
    bossHPConst = 300
    lowHealh = false
    -----
    creeps = {} --таблица крипов
    maxcreeps = 8


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
    carouselCounter = 0 --считает урон от карусели
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
    sawingDefaultReward = 60
    sawingDelay = 1 --ограничение на юз пилы подряд
    fuelOnMap = false --есть заспавненное топливо
    fuel = {} --таблица заспавненного топлива

    dashing = false --герой в рывке
    dashCharges = 4 --заряды рывка
    dashChargesConst = 4
    dashCooldown = 0 --кулдаун зарядя
    dashCooldownConst = 5.0
    chargesOnMap = false --есть заряды на карте
    dashChargesItems = {} --таблица заспавненных зарядов
    -------
    cdTimer = nil --глобалка для таймера, обновляющего кулдауны
    cooldownUpdating = false --показывает, что работает таймер, обновляющий кулдауны
    ----------


end