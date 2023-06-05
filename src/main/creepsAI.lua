function InitCreepsMovement()
    for i = 1, #creeps do
        local xy = RandomPointInCircle(CenterX, CenterY, Radius)
        IssuePointOrder(creeps[i], "move",xy[1], xy[2])
    end
    local t = CreateTimer()
    TimerStart(t, 10, true, function()
        for i = 1, #creeps do
            local xy = RandomPointInCircle(CenterX, CenterY, Radius)
            IssuePointOrder(creeps[i], "move",xy[1], xy[2])
        end
    end)
end