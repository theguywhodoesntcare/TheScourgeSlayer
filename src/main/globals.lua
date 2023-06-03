function StatusList()
    Stage = 1 --текущая стадия
    ------
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

    ------
    cooldown = false --кулдаун ракетницы
    rocketCharges = 100 --заряды ракетницы

    Chaining = false --юзает хук
    chaincooldown = false --кулдаун хука
    chainCharges = 1 --заряды хука
    chainChargesConst = 1
    chainCooldown = 0 --кулдаун хука
    chainCooldownConst = 15
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
    dashCharges = 2 --заряды рывка
    dashChargesConst = 2
    dashCooldown = 0 --кулдаун зарядя
    dashCooldownConst = 8.0
    -------
    cdTimer = nil --глобалка для таймера, обновляющего кулдауны
    cooldownUpdating = false --показывает, что работает таймер, обновляющий кулдауны


end