function BeetleLaunch()
    local maxZ = 820
    local startZ = 400
    local endZ = 330
    local x, y = GetUnitPosition(slayer)
    local startX, startY = GetUnitPosition(boss)
    local eff = AddSpecialEffect("Units\\Undead\\ScarabLvl3\\ScarabLvl3", startX, startY)
    BlzPlaySpecialEffect(eff, ANIM_TYPE_WALK)
    BlzSetSpecialEffectScale(eff, 1.5)
    local angle = CalculateAngle(startX, startY, x, y)
    BlzSetSpecialEffectYaw(eff, angle)
    local points = ComputePath(startX, startY, startZ, x, y, endZ, maxZ, 30)

    local i = 1
    local sharp = #points
    local t = CreateTimer()

    TimerStart(t, 1/32, true, function()
        p = points[i]
        BlzSetSpecialEffectPosition(eff, p.x, p.y, p.z)
        local xx, yy = GetUnitPosition(slayer)
        local angle = CalculateAngle(p.x, p.y, xx, yy)
        BlzSetSpecialEffectYaw(eff, angle)
        i = i + 1
        if i > sharp then
            PauseTimer(t)
            BeetleCharge(eff, p.x, p.y, p.z)
            DestroyTimer(t)
        end
    end)
end

function BeetleCharge(beetle, x, y, z)
    local ux, uy = GetUnitPosition(slayer)
    local endX, endY = FindIntersection(x, y, ux, uy)
    local points = GetPointsOnLine(x, y, endX, endY, 15)

    local markers = GetPointsOnLine(x, y, endX, endY, 120)
    local mrkrs = {}

    local angle = CalculateAngle(x, y, endX, endY)

    BlzSetSpecialEffectYaw(beetle, angle)

    for n = 1, #markers do
        local marker = AddSpecialEffect("models\\redtriangle3", markers[n].x, markers[n].y)
        BlzSetSpecialEffectYaw( marker, angle )
        table.insert(mrkrs, marker)
    end

    local i = 1
    local sharp = #points
    local counter = 1
    local index = 1
    local t = CreateTimer()
    TimerStart(t, 1/64, true, function()
        local p = points[i]
        BlzSetSpecialEffectPosition(beetle, p.x, p.y, z)
        if CheckBeetleDamage(p.x, p.y) then
            if not beetleAtached then
                BlzSetSpecialEffectPosition(beetle, 6000, 6000, 0)
                beetleAtached = true
                DestroyEffect(beetle)
                beetleAttach = AddSpecialEffectTarget("models\\beetle150", slayer, "chest")
                BeetlePeriodic()

                local frameTimer = CreateTimer()
                BlzDestroyFrame(beetleFrame)
                beetleFrame = BeetleFrame()
                local pos = 1.1
                BlzFrameSetVisible(beetleFrame, true)
                TimerStart(frameTimer, 1/32, true, function()
                    pos = pos - 0.02
                    BlzFrameSetAbsPoint(beetleFrame, FRAMEPOINT_CENTER, pos, 0.03)
                    if pos <= 0.87 then
                        DestroyTimer(frameTimer)
                    end
                end)

                for k = 1, #mrkrs do
                    DestroyEffect(mrkrs[k])
                end
                DestroyTimer(t)
            else
                for k = 1, #mrkrs do
                    DestroyEffect(mrkrs[k])
                end
                DestroyEffect(beetle)
                DestroyTimer(t)
            end
        end
        counter = counter + 1
        if math.fmod(counter, 8) == 0 then
            DestroyEffect(mrkrs[index])
            index = index + 1
        end
        i = i + 1
        if i > sharp then
            DestroyEffect(beetle)
            for k = 1, #mrkrs do
                DestroyEffect(mrkrs[k])
            end
            DestroyTimer(t)
        end


    end)
end

function BeetleFrame()
    local spriteframe = BlzCreateFrameByType("SPRITE", "SpriteName", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
    BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, 1.1, 0.03)
    BlzFrameSetSize(spriteframe, 0.001, 0.001)
    BlzFrameSetScale(spriteframe, 1)
    BlzFrameSetLevel(spriteframe, 3)
    BlzFrameSetModel(spriteframe, "sprites\\beetleSprite2", 1)
    BlzFrameSetSpriteAnimate(spriteframe, 2, 2)
    BlzFrameSetVisible(spriteframe, false)

    return spriteframe
end

function DestroyBeetleFrame()
    local frameTimer = CreateTimer()
    local pos = 0.87
    BlzFrameSetVisible(beetleFrame, true)
    TimerStart(frameTimer, 1/32, true, function()
        pos = pos + 0.02
        BlzFrameSetAbsPoint(beetleFrame, FRAMEPOINT_CENTER, pos, 0.03)
        if pos >= 1.1 then
            BlzDestroyFrame(beetleFrame)
            beetleFrame = nil
            DestroyTimer(frameTimer)
        end
    end)
    print("beetlframedestroy")
end


