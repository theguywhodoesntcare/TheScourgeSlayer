function Icons()
    local textures = {
        "backdrops\\rocketIcon",
        "backdrops\\dashIcon",
        "backdrops\\sawIcon",
        "backdrops\\chainIcon"
    }
    local x = -0.095
    local y = 0.5

    local offsety = 0.1
    local size = 0.08

    local size2 = 0.05
    local size3 = 0.065

    consoleFrame = BlzGetFrameByName("ConsoleUIBackdrop", 0)
    for i = 1, 4 do
        local yy = y - offsety * (i-1)
        local charges = CreateBackdrop(consoleFrame, x+0.035, yy-0.035, size2, "backdrops\\octFrame1", 6)
        local icon = CreateBackdrop(charges, x, yy, size, textures[i], 6)
        table.insert(iconsUI, icon)
        --table.insert(iconsUI, icon)
        if i % 2 == 0 then
            local cooldownFrame = CreateBackdrop(charges, x+0.035+0.0325, yy-0.003, size3, "backdrops\\octFrame1", 6)
            local cooldownText = CreateText(cooldownFrame, x+0.035+0.032, yy-0.0027, size3, 0, 6)
            table.insert(cooldownUI, cooldownText)
        end
        local chargesText = CreateText(charges, x+0.0345, yy-0.034, size2, "100", 6)
        table.insert(chargesUI, chargesText)

        BlzFrameSetText(chargesUI[1], rocketCharges)
        BlzFrameSetText(chargesUI[2], dashCharges)
        BlzFrameSetText(chargesUI[3], sawingCharges)
        BlzFrameSetText(chargesUI[4], chainCharges)
    end
end

function UpdateCharges(type, value)
    BlzFrameSetText(chargesUI[type], value)
end

function DisplayCooldown(start)
    if dashCooldown == 0 and dashCharges < dashChargesConst then
        dashCooldown = dashCooldownConst
    end
    if chainCooldown == 0 and chainCharges < chainChargesConst then
        chainCooldown =  chainCooldownConst
    end
    print(cooldownUpdating)
    if start and not cooldownUpdating then
        cdTimer = CreateTimer()
        cooldownUpdating = true
        TimerStart(cdTimer, 0.01, true, function()
            if dashCooldown > 0 and dashCooldown <= dashCooldownConst and dashCharges < dashChargesConst then
                dashCooldown = dashCooldown - 0.01
                BlzFrameSetText(cooldownUI[1], string.format("%.2f", dashCooldown))
            elseif dashCooldown <= 0 then
                BlzFrameSetText(cooldownUI[1], 0)
                if dashCharges < dashChargesConst then
                    dashCharges = dashCharges + 1
                    SetIconEnable(iconsUI[2], true)
                    UpdateCharges(2, dashCharges)
                    if dashCharges == dashChargesConst then
                        dashCooldown = 0
                        if chainCooldown == 0 then
                            cooldownUpdating = false
                            DestroyTimer(cdTimer)
                        end
                    else
                        dashCooldown = dashCooldownConst
                    end
                end
            end

            if chainCooldown > 0 and chainCooldown <= chainCooldownConst and chainCharges < chainChargesConst then
                chainCooldown = chainCooldown - 0.01
                BlzFrameSetText(cooldownUI[2], string.format("%.2f", chainCooldown))
            elseif chainCooldown <= 0 then
                BlzFrameSetText(cooldownUI[2], 0)
                if chainCharges < chainChargesConst then
                    chainCharges = chainCharges + 1
                    SetIconEnable(iconsUI[4], true)
                    UpdateCharges(4, chainCharges)
                    if chainCharges == chainChargesConst then
                        chainCooldown = 0
                        if dashCooldown == 0 then
                            cooldownUpdating = false
                            DestroyTimer(cdTimer)
                        end
                    else
                        chainCooldown = chainCooldownConst
                    end
                end
            end
        end)
    end
end

function SetIconEnable(frame, flag)
    if flag then
        BlzFrameSetAlpha(frame, 255)
    else
        BlzFrameSetAlpha(frame, 128)
    end
end

