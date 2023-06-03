function Sawing()
    local targets = {}
    local x, y = GetUnitPosition(slayer)

    local target = FindClosestUnit(creeps, x, y)
    local tX, tY = GetUnitPosition(target)
    if sawingCharges > 0 then
        if IsPointInCircle(tX, tY, x, y, 350) and not Chaining and not dashing and not sawing then
            sawing = true
            sawingCharges = sawingCharges - 1
            UpdateCharges(3, sawingCharges)
            SetUnitPosition(slayer, tX, tY)
            SetUnitInvulnerable(slayer, true)
            CameraSetFocalDistance(50)
            local spriteframe = BlzCreateFrameByType("SPRITE", "SpriteName", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)

            PlaySawFleshSound()
            PlayScream()
            BlzFrameSetAbsPoint(spriteframe, FRAMEPOINT_CENTER, 0.4, 0.3)
            BlzFrameSetLevel(spriteframe, 3)
            BlzFrameSetModel(spriteframe, "acowtf4", 0)
            BlzFrameSetSpriteAnimate(spriteframe, 0, 0)
            -- birth = 0
            -- death = 1
            -- stand = 2
            -- morph = 3
            -- alternate = 4
            CinematicFilterGenericBJ( 0.00, BLEND_MODE_BLEND, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100, 100, 100, 25.00, 100.00, 100.00, 100.00, 25.00 )
            BlzFrameSetVisible(spriteframe, true)
            local Mask = BlzCreateFrameByType("BACKDROP", "Mask", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 1)
            BlzFrameSetLevel(Mask,4)
            BlzFrameSetAbsPoint(Mask, FRAMEPOINT_TOPLEFT, -0.14, 0.6)
            BlzFrameSetAbsPoint(Mask, FRAMEPOINT_BOTTOMRIGHT, 0.95, 0.0)
            BlzFrameSetTexture(Mask, "backdrops\\blood2", 0, true)
            BlzFrameSetAlpha(Mask, 0)
            local alpha = 0
            SawingReward()
            TimerStart(CreateTimer(), 1/32, true, function()
                alpha = alpha + 4
                if alpha >=255 then
                    BlzFrameSetAlpha(Mask, 255)
                    DestroyTimer(GetExpiredTimer())
                else
                    BlzFrameSetAlpha(Mask, alpha)
                end
            end)

            local focal = 50

            TimerStart(CreateTimer(), 3, false, function()
                BlzDestroyFrame(spriteframe)
                DisplayCineFilterBJ( false )
                TimerStart(CreateTimer(), 1/32, true, function()
                    focal = focal + 10
                    if focal >=500 then
                        CameraSetFocalDistance(0)
                        DestroyTimer(GetExpiredTimer())
                    else
                        CameraSetFocalDistance(focal)
                    end
                end)
                TimerStart(CreateTimer(), 1/32, true, function()
                    alpha = alpha - 4
                    if alpha <=0 then
                        BlzFrameSetAlpha(Mask, 0)
                        BlzDestroyFrame(Mask)
                        DestroyTimer(GetExpiredTimer())
                    else
                        BlzFrameSetAlpha(Mask, alpha)
                    end
                end)
                SetUnitInvulnerable(slayer, false)
                sawing = false
                DestroyTimer(GetExpiredTimer())
            end)
        end
    end
end

function SpawnFuel()
    local xy = RandomPointInCircle(CenterX, CenterY, Radius)
    local eff = AddSpecialEffect("models\\fuel", xy[1], xy[2])
    fuelOnMap = true
    table.insert(fuel, {xy, eff})
end

function PickFuel(fuelEff, index)
    if sawingCharges < sawingChargesConst then
        DestroyEffect(fuelEff[2])
        table.remove(fuel, index)
        sawingCharges = sawingCharges + 1
    end
    if #fuel == 0 then
        fuelOnMap = false
    end
end

function SawingReward()
    local t = CreateTimer()
    local i = 0
    TimerStart(t, 1/16, true, function()
        rocketCharges = rocketCharges + 1
        if rocketCharges > 100 then
            rocketCharges = 100
        end
        UpdateCharges(1, rocketCharges)
        i = i + 1
        if i > sawingDefaultReward then
            DestroyTimer(t)
        end
    end)

end