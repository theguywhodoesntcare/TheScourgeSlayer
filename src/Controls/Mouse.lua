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
  -- ClickReleaseTrigger = CreateTrigger()
 --  TriggerRegisterPlayerEvent(ClickReleaseTrigger, Player(0), EVENT_PLAYER_MOUSE_UP)
   -- TriggerAddCondition(ClickReleaseTrigger, Condition(Releaser))


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
--print(BlzGetTriggerPlayerMouseX().." "..BlzGetTriggerPlayerMouseY())
    if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_LEFT then
        --print("LMB: "..BlzGetTriggerPlayerMouseX().." "..BlzGetTriggerPlayerMouseY())
        MakeShot(BlzGetTriggerPlayerMouseX(), BlzGetTriggerPlayerMouseY())
    end
    if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
        print("RMB: "..BlzGetTriggerPlayerMouseX().." "..BlzGetTriggerPlayerMouseY())
    end
end

function Releaser()
    if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_LEFT then
        print("leftmb off")
        --TimerStart(CreateTimer(), 0.05, false, function()
            BlzFrameSetEnable(ClickBlocker, false)
            --DestroyTimer(GetExpiredTimer())
        --end)
        ForceUICancelBJ(Player(0))
    end
end

