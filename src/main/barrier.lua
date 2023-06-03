barrier = {}

function CreateBarrier()
    local points = GetPointsOnCircle(CenterX, CenterY, Radius, 2 * math.pi / 180)

    for i = 1, #points do
        local angle = CalculateAngle(points[i].x, points[i].y, CenterX, CenterY) + math.pi / 2
        local eff = AddSpecialEffect("models\\barrier", points[i].x, points[i].y)
        BlzSetSpecialEffectScale(eff, 2)
        --BlzSetSpecialEffectZ(eff, 300)
        BlzSetSpecialEffectYaw(eff, angle)
        --BlzSetSpecialEffectScale(eff, 2)
        --BlzSetSpecialEffectZ(eff, 400)
        table.insert(barrier, eff)
    end
    CreateStatues()
end

