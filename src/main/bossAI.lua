function AttackTimer()
    math.randomseed(os.time())
    globalAttackTimer = CreateTimer()
    TimerStart(globalAttackTimer, 6, true, function()
        if Stage == 1 then
            InvulnerableBlock(0.75)
            if not castFireballs and not castBeetles and not castCorpse and not castRocks then
                local rand = math.random()
                if rand <= 0.25 then
                    local fireTimer = CreateTimer()
                    local fireCounter = 0
                    castFireballs = true
                    TimerStart(fireTimer, 1.25, true, function()
                        FireBalls(0.1, 15, 20)
                        fireCounter = fireCounter + 1
                        if fireCounter > 6 then
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
                    TimerStart(beetleTimer, 1.2, true, function()
                        BeetleLaunch()
                        beetleCounter = beetleCounter + 1
                        if beetleCounter > 10 then
                            castBeetles = false
                            DestroyTimer(beetleTimer)
                        end
                    end)
                else
                    castCorpse = true
                    CorpseBombs(10, 1.5)
                end
            end
            local rand2 = math.random()
            if rand2 <= 0.2 then
                TripleImpale(math.random(30, 35))
            elseif rand2 <= 0.35 and not CageOn and not sawing then
                Cage(500, 15)
                local cageTimer = CreateTimer()
                TimerStart(cageTimer, 5, false, function()
                    if SlayerInsideCage then
                        FireBalls(0.25, 1, 30)
                    end
                    DestroyTimer(cageTimer)
                end)
            elseif rand2 <= 0.55 and not acidGlobal then
                Acid(12, 30)
            end
        end

        if Stage == 2 then
            InvulnerableBlock(0.70)
            if not castFireballs and not castBeetles and not castCorpse and not castRocks then
                local rand = math.random()
                if rand <= 0.25 then
                    local fireTimer = CreateTimer()
                    local fireCounter = 0
                    castFireballs = true
                    TimerStart(fireTimer, 1.1, true, function()
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
                    TimerStart(beetleTimer, 1.1, true, function()
                        BeetleLaunch()
                        beetleCounter = beetleCounter + 1
                        if beetleCounter > 10 then
                            castBeetles = false
                            DestroyTimer(beetleTimer)
                        end
                    end)
                else
                    castCorpse = true
                    CorpseBombs(11, 1.25)
                end
            end
            local rand2 = math.random()
            if rand2 <= 0.25 then
                TripleImpale(math.random(30, 35))
            elseif rand2 <= 0.4 and not CageOn and not sawing and not castCarousel then
                Cage(500, 15)
                local cageTimer = CreateTimer()
                TimerStart(cageTimer, 5, false, function()
                    if SlayerInsideCage then
                        FireBalls(0.25, 1, 30)
                    end
                    DestroyTimer(cageTimer)
                end)
            elseif rand2 <= 0.6 and not acidGlobal then
                Acid(18, 30)
            elseif rand2 <= 0.65 and not castCarousel and not SlayerInsideCage then
                Bugs()
            end
        end
    end)
end


function InvulnerableBlock(chance)
    local rand = math.random()
    if rand <= chance then
        Invulnerable(false)
        local t = CreateTimer()
        local dur = math.random(2, 5)
        TimerStart(t, dur, false, function()
            Invulnerable(true)
            DestroyTimer(t)
        end)
    end
end