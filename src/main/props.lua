function CreateBlood()
    for i = 1, math.random(4, 8) do
        local xy = RandomPointInCircle(CenterX, CenterY, Radius)
        local eff = AddSpecialEffect("blood", xy[1], xy[2])
        local angle = math.random() * 2 * math.pi
        BlzSetSpecialEffectYaw(eff, angle)
    end
end


function CreateStatues()
    local points = GetPointsOnCircle(CenterX, CenterY, Radius-140, 36 * math.pi / 180)

    for i = 1, #points do
        local angle = CalculateAngle(points[i].x, points[i].y, CenterX, CenterY) + math.pi / 4
        local eff = AddSpecialEffect("models\\SpiderStatue", points[i].x, points[i].y)
        BlzSetSpecialEffectYaw(eff, angle)
        CreateFakeColumn(points[i].x, points[i].y)
    end
end

function CreateBones()
    for i = 1, math.random(6, 10) do
        local xy = RandomPointInCircle(CenterX, CenterY, Radius)
        local n = math.random(0, 4)
        local angle = math.random() * 2 * math.pi
        local eff = AddSpecialEffect("environment\\foliage\\blight\\bones\\foliage_blight_bone_0"..n, xy[1], xy[2])
        BlzSetSpecialEffectYaw(eff, angle)
    end
end