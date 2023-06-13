function Cage(radius, duration)
    local x, y = GetUnitPosition(slayer)
    if IsPointInCircle(x, y, CenterX, CenterY, Radius) then
        local effects = {}
        hexPoints = GetHexagonPoints(x, y, radius, radius/2.5)
        local pointsChain = GetHexagonPoints(x, y, radius, 40)
        --print(#hexPoints)
        local d = 1
        local sharp = #pointsChain
        local chainTimer = CreateTimer()
        PlayCage()
        TimerStart(chainTimer, 1/64, true, function()
            local p1 = pointsChain[d]
            local chain = AddSpecialEffect("models\\chainlink2", p1.x, p1.y )
            if d < #pointsChain then
                local angleChain = CalculateAngle(p1.x, p1.y, pointsChain[d+1].x, pointsChain[d+1].y)
                BlzSetSpecialEffectYaw(chain, angleChain)
                BlzSetSpecialEffectScale(chain, 1.15)
                table.insert(effects, chain)
            else
                local angleChain = CalculateAngle(p1.x, p1.y, pointsChain[1].x, pointsChain[1].y)
                BlzSetSpecialEffectYaw(chain, angleChain)
                BlzSetSpecialEffectScale(chain, 1.1)
                table.insert(effects, chain)
            end
            d = d + 1
            if d > sharp then
                for i = 1, #hexPoints do
                    local p = hexPoints[i]
                    local eff = AddSpecialEffect("models\\skeleton", p.x, p.y)
                    local angle = CalculateAngle(p.x, p.y, x, y)
                    BlzSetSpecialEffectYaw(eff, angle)
                    table.insert(effects, eff)
                end
                CageOn = true
                ------------
                local Mask = BlzCreateFrameByType("BACKDROP", "Mask", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 1)
                BlzFrameSetVisible(Mask, false)
                BlzFrameSetLevel(Mask,4)
                BlzFrameSetAbsPoint(Mask, FRAMEPOINT_CENTER, 0.4 + offsetWidth - 0.1, 0.08) --old x = 0.8
                BlzFrameSetSize(Mask, 0.4, 0.23)
                BlzFrameSetTexture(Mask, "backdrops\\chain1", 0, true)
                BlzFrameSetAlpha(Mask, 255)

                local Mask1 = BlzCreateFrameByType("BACKDROP", "Mask", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 1)
                BlzFrameSetVisible(Mask1, false)
                BlzFrameSetLevel(Mask1,4)
                BlzFrameSetAbsPoint(Mask1, FRAMEPOINT_CENTER, 0.4 - offsetWidth + 0.1, 0.52) --old x = -0.05
                BlzFrameSetSize(Mask1, 0.4, 0.23)
                BlzFrameSetTexture(Mask1, "backdrops\\chain1", 0, true)
                BlzFrameSetAlpha(Mask1, 255)
                ------------

                local spriteframe = CageFrame()
                if IsPointInHexagon(GetUnitX(slayer), GetUnitY(slayer), hexPoints) then
                    BlzFrameSetVisible(spriteframe, true)
                    BlzFrameSetVisible(Mask1, true)
                    BlzFrameSetVisible(Mask, true)
                    SlayerInsideCage = true
                    local frameTimer = CreateTimer()
                    local pos = 0.4 + offsetWidth+0.23 --old posX = 1.1
                    TimerStart(frameTimer, 1/32, true, function()
                        pos = pos - 0.02
                        BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, pos, -0.036)
                        if pos <= 0.4 + offsetWidth - 0.106 then --old = 0.82
                            DestroyTimer(frameTimer)
                        end
                    end)
                end
                local cageTimer = CreateTimer()
                TimerStart(cageTimer, duration, false, function()
                    for e = 1, #effects do
                        DestroyEffect(effects[e])
                    end

                    CageOn = false
                    if SlayerInsideCage then
                        local frameTimer1 = CreateTimer()
                        local pos = 0.4 + offsetWidth - 0.106 --0.82
                        local alpha = 255
                        TimerStart(frameTimer1, 1/32, true, function()
                            pos = pos + 0.02
                            BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, pos, -0.036)

                            alpha = alpha - 17
                            if alpha <= 0 then
                                alpha = 0
                            end
                            BlzFrameSetAlpha(Mask1, alpha)
                            BlzFrameSetAlpha(Mask, alpha)
                            if pos >= 0.4 + offsetWidth + 0.23 then --old = 1.1
                                BlzDestroyFrame(spriteframe)
                                BlzDestroyFrame(Mask)
                                BlzDestroyFrame(Mask1)
                                DestroyTimer(frameTimer1)
                            end
                        end)
                    end
                    SlayerInsideCage = false
                    hexPoints = {}
                    DestroyTimer(cageTimer)
                end)
                DestroyTimer(chainTimer)
            end
        end)
    end
end

function CageFrame()
    local spriteframe = BlzCreateFrameByType("SPRITE", "SpriteName", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
    BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, 1.1, -0.036)
    BlzFrameSetSize(spriteframe, 0.001, 0.001)
    BlzFrameSetScale(spriteframe, 1)
    BlzFrameSetLevel(spriteframe, 3)
    BlzFrameSetModel(spriteframe, "Sprites\\skeletonsprite2", 1)
    BlzFrameSetSpriteAnimate(spriteframe, 2, 2)
    BlzFrameSetVisible(spriteframe, false)

    return spriteframe
end