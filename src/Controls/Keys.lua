function InitControlKeys()

    KeyTrigger = CreateTrigger()

    BlzTriggerRegisterPlayerKeyEvent(KeyTrigger, GetLocalPlayer(), OSKEY_Q, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(KeyTrigger, GetLocalPlayer(), OSKEY_V, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(KeyTrigger, GetLocalPlayer(), OSKEY_E, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(KeyTrigger, GetLocalPlayer(), OSKEY_SPACE, 0, true)
    BlzTriggerRegisterPlayerKeyEvent(KeyTrigger, GetLocalPlayer(), OSKEY_O, 0, true)
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
    InitWalkTimer()
end
function InitWalkTimer()
    local acidCounter = 0
    walkTimer = CreateTimer()
    TimerStart(walkTimer, 1/16, true, function()
        local ux, uy = GetUnitPosition(slayer)
        if (Apressed or Wpressed or Dpressed or Spressed) and not Chaining then --and not (Apressed and Dpressed) and not (Wpressed and Spressed))
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

            --local ux, uy = GetUnitPosition(slayer)
            local x = ux - orders.Xm + orders.Xp
            local y = uy - orders.Ym + orders.Yp
            if not sawing then
                if not CageOn then
                    IssuePointOrder(slayer, "move", x, y)
                    FixCursor(ux, uy)
                elseif SlayerInsideCage then
                    local xx, yy = GetPointOnLine(ux, uy, x, y, 80)
                    if not IsPointInHexagon(xx, yy, hexPoints) then
                        IssueImmediateOrder(slayer, "stop")
                    else
                        IssuePointOrder(slayer, "move", x, y)
                        FixCursor(ux, uy)
                    end
                else
                    local xx, yy = GetPointOnLine(ux, uy, x, y, 80)
                    if IsPointInHexagon(xx, yy, hexPoints) then
                        IssueImmediateOrder(slayer, "stop")
                    else
                        IssuePointOrder(slayer, "move", x, y)
                        FixCursor(ux, uy)
                    end
                end
            end
            --print(orders.Xm.." "..orders.Xp.." "..orders.Ym.." "..orders.Yp.." "..x.." "..y.." "..ux.." "..uy)
        elseif --(not Apressed and not Wpressed and not Dpressed and not Spressed) and
        (additionalOrders.Xm ~= 0 or additionalOrders.Xp ~= 0 or additionalOrders.Ym ~= 0 or additionalOrders.Yp ~= 0) and not Chaining then
            --print("additional condition")
            for k, v in pairs(additionalOrders) do
                if v ~= 0 then
                    orders[k] = v
                    additionalOrders[k] = 0
                end
            end
            local x = GetUnitX(slayer) + orders.Xm + orders.Xp
            local y = GetUnitY(slayer) + orders.Ym + orders.Yp
            --local ux, uy = GetUnitPosition(slayer)
            local x = ux - orders.Xm + orders.Xp
            local y = uy - orders.Ym + orders.Yp
            if not sawing then
                if not CageOn then
                    IssuePointOrder(slayer, "move", x, y)
                    FixCursor(ux, uy)
                elseif SlayerInsideCage then
                    local xx, yy = GetPointOnLine(ux, uy, x, y, 80)
                    if not IsPointInHexagon(xx, yy, hexPoints) then
                        IssueImmediateOrder(slayer, "stop")
                    else
                        IssuePointOrder(slayer, "move", x, y)
                        FixCursor(ux, uy)
                    end
                else
                    local xx, yy = GetPointOnLine(ux, uy, x, y, 80)
                    if IsPointInHexagon(xx, yy, hexPoints) then
                        IssueImmediateOrder(slayer, "stop")
                    else
                        IssuePointOrder(slayer, "move", x, y)
                        FixCursor(ux, uy)
                    end
                end
            end
        else
            orders.Xm = 0
            orders.Yp = 0
            orders.Xp = 0
            orders.Ym = 0
            IssueImmediateOrder(slayer, "stop")
        end
        if acidGlobal then
            local sharp = #puddles
            for p = 1, sharp do
                if IsPointInCircle(ux, uy, puddles[p].x, puddles[p].y, 90) then
                    acidCounter = acidCounter + 1
                    if acidCounter >= 2 then
                        GotDamage("acid")
                        acidCounter = 0
                    end
                    break
                end
            end
        end
        if fuelOnMap then
            local sharpF = #fuel
            for f = 1, sharpF do
                local fuelX = fuel[f][1][1]
                local fuelY = fuel[f][1][2]
                if IsPointInCircle(ux, uy, fuelX, fuelY , 60) then
                    print(fuelX)
                        PickFuel(fuel[f], f)
                    break
                end
            end
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
end


function ControlKeys()
    if BlzGetTriggerPlayerKey() == OSKEY_Q then
        print("Q")
        --IssuePointOrder(slayer, "move", GetUnitX(slayer), GetUnitY(slayer))
        --TripleImpale(30)
        TimerStart(CreateTimer(), 2, true, function()
            FireBalls()
        end)
    end
    if BlzGetTriggerPlayerKey() == OSKEY_E then
        --print("E")
        --IssuePointOrder(slayer, "move", GetUnitX(slayer), GetUnitY(slayer))
        --TripleImpale(30)
        Sawing()
    end
    if BlzGetTriggerPlayerKey() == OSKEY_V then
        CameraSetFocalDistance(0)
        print("V")

        SetUnitLookAt( slayer, "bone_turret", posdummy, 0, 0, 0 )
        --ThrowStones(15)
        --TripleImpale(35)
        --CreateTestUnit()
        --Laser()
        --Acid(30)
        --Cage(500, 5)
        CorpseBombs(10, 1)
        --BeetleLaunch()
    end

    if BlzGetTriggerPlayerKey() == OSKEY_SPACE then
        print("SPACE")
        Dash()
    end
end

function TurnKeyTriggers(off)
    if off then
        DisableTrigger(KeyTrigger)
        DisableTrigger(ButtonPressedTrigger)
        DisableTrigger(ButtonReleasedTrigger)
    else
        EnableTrigger(KeyTrigger)
        EnableTrigger(ButtonPressedTrigger)
        EnableTrigger(ButtonReleasedTrigger)
    end
end