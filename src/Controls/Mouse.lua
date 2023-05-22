function InitControlMouse()
    MouseTrigger = CreateTrigger()
    TriggerRegisterPlayerEvent(MouseTrigger, Player(0), EVENT_PLAYER_MOUSE_MOVE)

    TriggerAddCondition(MouseTrigger, Condition(ControlMouse))

  ClickTrigger = CreateTrigger()
    TriggerRegisterPlayerEvent(ClickTrigger, Player(0), EVENT_PLAYER_MOUSE_DOWN)
    TriggerAddCondition(ClickTrigger, Condition(Clicker))


WheelTrigger = CreateTrigger()
    BlzTriggerRegisterFrameEvent(WheelTrigger, InfoBackground, FRAMEEVENT_MOUSE_WHEEL)
    TriggerAddAction(trigger, function()
        print("wheel")
    end)
  ClickReleaseTrigger = CreateTrigger()
   TriggerRegisterPlayerEvent(ClickReleaseTrigger, Player(0), EVENT_PLAYER_MOUSE_UP)
   TriggerAddCondition(ClickReleaseTrigger, Condition(Releaser))

    chainMarker = false
    rmbpressed = false

end

function ControlMouse()
    SetUnitFaceToCursor()
end

function CancelClick()
    print("world click")
    ForceUICancelBJ(Player(0))
end

function Wheel()
    print("Wheel")
end

function Clicker()
    if (GetUnitAbilityLevel(slayer, _('BUim')) == 0) then
        if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_LEFT then
            MakeShot(BlzGetTriggerPlayerMouseX(), BlzGetTriggerPlayerMouseY())
        end
        if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
            --local eff = AddSpecialEffect("models\\greencircle", BlzGetTriggerPlayerMouseX(), BlzGetTriggerPlayerMouseY())
            --table.insert(slayerEffects, eff)
            rmbpressed = true
            FindChainTarget()
        end
    end
end

function Releaser()
    if (GetUnitAbilityLevel(slayer, _('BUim')) == 0) then
        if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
            rmbpressed = false
            ChainHook()
        end
    end
end

