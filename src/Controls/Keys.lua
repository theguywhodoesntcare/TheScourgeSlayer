function InitControlKeys()

    KeyTrigger = CreateTrigger()

    BlzTriggerRegisterPlayerKeyEvent(KeyTrigger, GetLocalPlayer(), OSKEY_Q, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(KeyTrigger, GetLocalPlayer(), OSKEY_V, 0, true)
    TriggerAddCondition(KeyTrigger, Condition(ControlKeys))

    ------MOVING SYSTEM------
    orders = {Xp = 0; Xm = 0; Yp = 0; Ym = 0} --таблица текущих направлений
    futureOrders = {Xp = 0; Xm = 0; Yp = 0; Ym = 0} --таблица будущих направлений, нужно хранить, чтобы можно было быстро перемещаться в противоположную сторону
    additionalOrders = {Xp = 0; Xm = 0; Yp = 0; Ym = 0} --нужна для хранения направлений, заданных кратковременными нажатиями, и не попавших в основные из-за тика таймера

    Apressed = false
    Wpressed = false
    Spressed = false
    Dpressed = false

    ButtonPressedTrigger = CreateTrigger()
    ButtonReleasedTrigger = CreateTrigger()

    BlzTriggerRegisterPlayerKeyEvent(ButtonPressedTrigger, GetLocalPlayer(), OSKEY_A, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(ButtonReleasedTrigger, GetLocalPlayer(), OSKEY_A, 0, false)

    BlzTriggerRegisterPlayerKeyEvent(ButtonPressedTrigger, GetLocalPlayer(), OSKEY_W, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(ButtonReleasedTrigger, GetLocalPlayer(), OSKEY_W, 0, false)

    BlzTriggerRegisterPlayerKeyEvent(ButtonPressedTrigger, GetLocalPlayer(), OSKEY_S, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(ButtonReleasedTrigger, GetLocalPlayer(), OSKEY_S, 0, false)

    BlzTriggerRegisterPlayerKeyEvent(ButtonPressedTrigger, GetLocalPlayer(), OSKEY_D, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(ButtonReleasedTrigger, GetLocalPlayer(), OSKEY_D, 0, false)

    TriggerAddCondition(ButtonPressedTrigger, Condition(ButtonPressed))
    TriggerAddCondition(ButtonReleasedTrigger, Condition(ButtonReleased))

    local t = CreateTimer()
    TimerStart(t, 1/16, true, function()
        if (Apressed or Wpressed or Dpressed or Spressed) then --and not (Apressed and Dpressed) and not (Wpressed and Spressed))
            --local x = GetUnitX(slayer) + orders.Xm + orders.Xp
            --local y = GetUnitY(slayer) + orders.Ym + orders.Yp
            if orders.Xm == 300 and orders.Xp == 300 then
                if not Apressed then
                    orders.Xm = 0
                end
                if not Dpressed then
                    orders.Xp = 0
                end
            end
            if orders.Ym == 300 and orders.Yp == 300 then
                if not Spressed then
                    orders.Ym = 0
                end
                if not Wpressed then
                    orders.Yp = 0
                end
            end

            local ux, uy = GetUnitPosition(slayer)
            local x = ux - orders.Xm + orders.Xp
            local y = uy - orders.Ym + orders.Yp
            IssuePointOrder(slayer, "move", x, y)
            --print(orders.Xm.." "..orders.Xp.." "..orders.Ym.." "..orders.Yp.." "..x.." "..y.." "..ux.." "..uy)
        elseif --(not Apressed and not Wpressed and not Dpressed and not Spressed) and
            (additionalOrders.Xm ~= 0 or additionalOrders.Xp ~= 0 or additionalOrders.Ym ~= 0 or additionalOrders.Yp ~= 0) then
            print("additional condition")
            for k, v in pairs(additionalOrders) do
                if v ~= 0 then
                    orders[k] = v
                    additionalOrders[k] = 0
                end
            end
            local x = GetUnitX(slayer) + orders.Xm + orders.Xp
            local y = GetUnitY(slayer) + orders.Ym + orders.Yp
            local ux, uy = GetUnitPosition(slayer)
            local x = ux - orders.Xm + orders.Xp
            local y = uy - orders.Ym + orders.Yp
            IssuePointOrder(slayer, "move", x, y)
        else
            orders.Xm = 0
            orders.Yp = 0
            orders.Xp = 0
            orders.Ym = 0
            IssueImmediateOrder(slayer, "stop")
        end
    end)
end

function ButtonPressed()
    if BlzGetTriggerPlayerKey() == OSKEY_A then
        Apressed = true
        if Dpressed == false then
            orders.Xm = 300
            additionalOrders.Xm = 300
        else
            futureOrders.Xm = 300
        end
    end
    if BlzGetTriggerPlayerKey() == OSKEY_W then
        Wpressed = true
        if Spressed == false then
            orders.Yp = 300
            additionalOrders.Yp = 300
        else
            futureOrders.Yp = 300
        end
    end
    if BlzGetTriggerPlayerKey() == OSKEY_S then
        Spressed = true
        if Wpressed == false then
            orders.Ym = 300
            additionalOrders.Ym = 300
        else
            futureOrders.Ym = 300
        end
    end
    if BlzGetTriggerPlayerKey() == OSKEY_D then
        Dpressed = true
        if Apressed == false then
            orders.Xp = 300
            additionalOrders.Xp = 300
        else
            futureOrders.Xp = 300
        end
    end
    --local ux, uy = GetUnitPosition(slayer)
    --local x = ux - orders.Xm + orders.Xp
    --local y = uy - orders.Ym + orders.Yp
    --local angle = CalculateAngle(ux, uy, x, y)
    --BlzSetUnitFacingEx(slayer, angle)
    --IssuePointOrder(slayer, "move", x, y)

end

function ButtonReleased()
    if BlzGetTriggerPlayerKey() == OSKEY_A then
        Apressed = false
        orders.Xm = 0
        if futureOrders.Xp ~= 0 then
            orders.Xp = futureOrders.Xp
            futureOrders.Xp = 0
        end
    end
    if BlzGetTriggerPlayerKey() == OSKEY_W then
        Wpressed = false
        orders.Yp = 0
        if futureOrders.Ym ~= 0 then
            orders.Ym = futureOrders.Ym
            futureOrders.Ym = 0
        end
    end
    if BlzGetTriggerPlayerKey() == OSKEY_S then
        Spressed = false
        orders.Ym = 0
        if futureOrders.Yp ~= 0 then
            orders.Yp = futureOrders.Yp
            futureOrders.Yp = 0
        end
    end
    if BlzGetTriggerPlayerKey() == OSKEY_D then
        Dpressed = false
        orders.Xp = 0
        if futureOrders.Xm ~= 0 then
            orders.Xm = futureOrders.Xm
            futureOrders.Xm = 0
        end
    end
   -- local x = GetUnitX(slayer) + orders.Xm + orders.Xp
   -- local y = GetUnitY(slayer) + orders.Ym + orders.Yp
  --  local ux, uy = GetUnitPosition(slayer)
 --   local x = ux - orders.Xm + orders.Xp
 --   local y = uy - orders.Ym + orders.Yp
 --   IssuePointOrder(slayer, "move", x, y)
end


function ControlKeys()
    if BlzGetTriggerPlayerKey() == OSKEY_Q then
        print("Q")
        --IssuePointOrder(slayer, "move", GetUnitX(slayer), GetUnitY(slayer))
        --TripleImpale(30)
        FireBalls()
    end
    if BlzGetTriggerPlayerKey() == OSKEY_V then

        print("V")

        --print(GetCameraField(CAMERA_FIELD_TARGET_DISTANCE))
        --print(GetCameraField(CAMERA_FIELD_FARZ))
        --print(GetCameraField(CAMERA_FIELD_NEARZ))
        --print(GetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK))
        --print(GetCameraField(CAMERA_FIELD_FIELD_OF_VIEW))
        --print(GetCameraField(CAMERA_FIELD_ROLL))
        --print(GetCameraField(CAMERA_FIELD_ROTATION))
        --print(GetCameraField(CAMERA_FIELD_ZOFFSET))
        --print(GetCameraField(CAMERA_FIELD_LOCAL_PITCH))
        --print(GetCameraField(CAMERA_FIELD_LOCAL_YAW))
        --print(GetCameraField(CAMERA_FIELD_LOCAL_ROLL))
        SetUnitLookAt( slayer, "bone_turret", posdummy, 0, 0, 0 )
    end
end

