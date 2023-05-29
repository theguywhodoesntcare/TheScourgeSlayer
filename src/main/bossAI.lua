function AttackTimer()
    --эти атаки не могут быть одновременно друг с другом: {глыбы, файрболлы, крест жуков}, {крест жуков, импейл}
    --
    math.randomseed(os.time())
    globalAttackTimer = CreateTimer()
    TimerStart(globalAttackTimer, 10, true, function()
        local rand = math.random()
        if rand < 0.2 then
            Bugs()
        elseif rand < 0.5 then
            TripleImpale(math.random(30, 35))
        else
            ThrowStones(5)
        end
    end)
end