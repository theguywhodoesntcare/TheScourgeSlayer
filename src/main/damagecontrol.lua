function GotDamage(type)
    if not BlzIsUnitInvulnerable(slayer) then
        print("got damage")
        PlayPainSoundMain()

        if type == "mechanical" then
            CrackedGlassEffect()
        end

        if type == "impale" then
            CrackedGlassEffect()
        end

        if type == "fire" then
            MaskEffect("backdrops\\VignetteFire.dds")
        end

        if type == "acid" then
            MaskEffect("backdrops\\VignettePoison.dds")
        end
    end
end

function MaskEffect(path)
    DisplayCineFilter(false)
    CinematicFilterGenericBJ( 5.00, BLEND_MODE_BLEND, path, 100, 100, 100, 0.00, 0, 0, 0, 100.00 )
end

function CrackedGlassEffect()
    CameraSetEQNoiseForPlayer( Player(0), 30.00 )
    local t = CreateTimer()
    TimerStart(t, 0.2, false, function()
        CameraClearNoiseForPlayer( Player(0) )
        DestroyTimer(t)
    end)

    local randx = math.random() * 0.9
    local randy = math.random() * 0.5
    local randAnim = math.random(0, 4)
    local randScale = math.random() * 1.25 + 0.75

    ----------
    local crack = BlzCreateFrameByType("SPRITE", "SpriteName", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    --
    BlzFrameSetAbsPoint(crack, FRAMEPOINT_CENTER, randx, randy)
    BlzFrameSetLevel(crack, 4)
    BlzFrameSetSize(crack, 0.01, 0.01)
    BlzFrameSetModel(crack, "sprites\\brokenglass", 1)
    BlzFrameSetScale(crack, randScale)
    BlzFrameSetSpriteAnimate(crack, randAnim, 2)
    BlzFrameSetAlpha(crack, 255)
    PlayHit()

    local t2 = CreateTimer()
    local alpha = 255
    TimerStart(t2, 1/16, true, function()
        alpha = alpha - 1
        if alpha <= 0 then
            BlzFrameSetAlpha(crack, 0)
            BlzDestroyFrame(crack)
            DestroyTimer(t)
        else
            BlzFrameSetAlpha(crack, alpha)
        end
    end)
end


function ControlDmg(unit)
    SetUnitState(unit, UNIT_STATE_LIFE, GetUnitState(unit, UNIT_STATE_LIFE) - 25)
end

function CheckFireballDamage(x, y)
    if IsCirclesIntersect(GetUnitX(slayer), GetUnitY(slayer), 40, x, y, 50) and not BlzIsUnitInvulnerable(slayer) then
        GotDamage("fire")
    end
    return
end


function CheckStoneDamage(x, y)
    if IsCirclesIntersect(GetUnitX(slayer), GetUnitY(slayer), 32, x, y, 60) and not BlzIsUnitInvulnerable(slayer) then
        GotDamage("mechanical")
        return true
    else
        return false
    end
end

function InitDamageTrigger()
    local DamageTrigger = CreateTrigger()
    --TriggerRegisterUnitEvent(DamageTrigger, impaleCasters[1], EVENT_PLAYER_UNIT_SPELL_ENDCAST)
    TriggerRegisterPlayerUnitEvent(DamageTrigger, Player(2), EVENT_PLAYER_UNIT_SPELL_ENDCAST, null)
    TriggerAddCondition(DamageTrigger, Condition(ResetAfterDamage))

end

function ResetAfterDamage()
    SetUnitLookAt( slayer, "bone_turret", posdummy, 0, 0, 0 )
    SetUnitState(slayer, UNIT_STATE_LIFE, GetUnitState(slayer, UNIT_STATE_MAX_LIFE))
    --GotDamage()
    if GetTriggerUnit() == impaleCasters[1] and (GetUnitAbilityLevel(slayer, _('BUim')) > 0) then
        GotDamage("impale")
    end
end



