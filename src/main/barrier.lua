

function CreateBarrier()
    local points = GetPointsOnCircle(CenterX, CenterY, Radius, 2 * math.pi / 180)

    for i = 1, #points do
        local angle = CalculateAngle(points[i].x, points[i].y, CenterX, CenterY) + math.pi / 2
        local eff = AddSpecialEffect("models\\barrier", points[i].x, points[i].y)
        BlzSetSpecialEffectScale(eff, 2)
        BlzSetSpecialEffectYaw(eff, angle)
        BlzSetSpecialEffectColorByPlayer(eff, Player(6))
        table.insert(barrier, eff)
    end
    CreateStatues()
end

function LockBarrier()
    local points = GetPointsOnCircle(CenterX, CenterY, Radius, 2 * math.pi / 180)
    local points = GetPointsOnCircle(CenterX, CenterY, Radius, 1 * math.pi / 180)
    for i = 1, #barrier do
        BlzSetSpecialEffectColorByPlayer(barrier[i], Player(0))
    end

    for p = 1, #points do
        CreateDestructable(_('YTfb'), points[p].x, points[p].y, GetRandomDirectionDeg(), 1, 0 )
    end
end

