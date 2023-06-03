function AttackTimer()
    --эти атаки не могут быть одновременно друг с другом: {глыбы, файрболлы, крест жуков}, {крест жуков, импейл}
    --
    math.randomseed(os.time())
    globalAttackTimer = CreateTimer()
    TimerStart(globalAttackTimer, 4, true, function()
        if Stage == 1 then
            if not castFireballs and not castBeetles and not castCorpse and not castRocks then
                local rand = math.random()
                if rand <= 0.25 then
                    local fireTimer = CreateTimer()
                    local fireCounter = 0
                    castFireballs = true
                    TimerStart(fireTimer, 1, true, function()
                        FireBalls(0.1, 15, 20)
                        fireCounter = fireCounter + 1
                        if fireCounter > 5 then
                            castFireballs = false
                            DestroyTimer(fireTimer)
                        end
                    end)
                elseif rand <= 0.5 then
                    castRocks = true
                    ThrowStones(10)
                elseif rand <= 0.75 then
                    local beetleTimer = CreateTimer()
                    local beetleCounter = 0
                    castBeetles = true
                    TimerStart(beetleTimer, 1, true, function()
                        BeetleLaunch()
                        beetleCounter = beetleCounter + 1
                        if beetleCounter > 10 then
                            castBeetles = false
                            DestroyTimer(beetleTimer)
                        end
                    end)
                else
                    castCorpse = true
                    CorpseBombs(10, 1.25)
                end
            end
            local rand2 = math.random()
            if rand2 <= 0.2 then
                TripleImpale(math.random(30, 35))
            elseif rand2 <= 0.35 and not CageOn and not Sawing then
                Cage(500, 15)
            elseif rand2 <= 0.50 and not acidGlobal then
                Acid(10, 30)
            end
        end
    end)
end