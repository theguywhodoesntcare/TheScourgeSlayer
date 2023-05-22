function PlayDashSound()
    PlaySound("Abilities/Spells/NightElf/Blink/BlinkBirth1.flac")
end

function PlayImpaleSound()
    PlaySound("Abilities/Spells/Undead/Impale/ImpaleHit.flac")
end

function PlayBrokenChain()
    PlaySound("Units/Human/SteamTank/SteamTankAttack1")
end

function PlayChain()
    PlaySound("sounds\\chain.flac")
end

function PlayStoneSound1(x, y)
    local snd = CreateSound("doodads\\terrain\\rockchunks\\rockchunksdeath1.flac",false, true, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 0)
    SetSoundDistances( snd, 600.00, 3200 )
    --SetSoundDistanceCutoff( snd, 3000.00)
    SetSoundDuration( snd, GetSoundFileDuration("doodads\\terrain\\rockchunks\\rockchunksdeath1.flac") )
    SetSoundVolume( snd, 60)
    --SetSoundConeAngles( snd, 0.0, 0.0, 127 )
    --SetSoundConeOrientation( snd, 0.0, 0.0, 0.0 )
    --SetSoundPitch( snd, 1.0 )
    SetSoundPosition(snd, x, y,100)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayStoneSound2(x, y)
    local snd = CreateSound("doodads\\terrain\\rockchunks\\rockchunksdeath2.flac",false, true, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 0)
    SetSoundDistances( snd, 600.00, 3200 )
    --SetSoundDistanceCutoff( snd, 3000.00)
    SetSoundDuration( snd, GetSoundFileDuration("doodads\\terrain\\rockchunks\\rockchunksdeath1.flac") )
    SetSoundVolume( snd, 60)
    --SetSoundConeAngles( snd, 0.0, 0.0, 127 )
    --SetSoundConeOrientation( snd, 0.0, 0.0, 0.0 )
    --SetSoundPitch( snd, 1.0 )
    SetSoundPosition(snd, x, y,100)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayStoneSound3(x, y)
    local snd = CreateSound("doodads\\terrain\\rockchunks\\rockchunksdeath3.flac",false, true, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 0)
    SetSoundDistances( snd, 600.00, 3200 )
    --SetSoundDistanceCutoff( snd, 3000.00)
    SetSoundDuration( snd, GetSoundFileDuration("doodads\\terrain\\rockchunks\\rockchunksdeath1.flac") )
    SetSoundVolume( snd, 60)
    --SetSoundConeAngles( snd, 0.0, 0.0, 127 )
    --SetSoundConeOrientation( snd, 0.0, 0.0, 0.0 )
    --SetSoundPitch( snd, 1.0 )
    SetSoundPosition(snd, x, y,100)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayStoneSoundMain(x, y)
    local t = {PlayStoneSound1, PlayStoneSound2, PlayStoneSound3}
    local n = math.random(#t)
    t[n](x, y)
end

function PlayPainSound1()
    local snd = CreateSound("sound\\dialogue\\undeadexpcamp\\undead04x\\L04Arthas36.flac",false, false, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 19)
    SetSoundDuration( snd, GetSoundFileDuration("sound\\dialogue\\undeadexpcamp\\undead04x\\L04Arthas36.flac") )
    SetSoundVolume( snd, 70)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayPainSound2()
    local snd = CreateSound("sound\\dialogue\\undeadexpcamp\\undead07cxInterlude\\L07CArthas43.flac",false, false, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 19)
    SetSoundDuration( snd, GetSoundFileDuration("sound\\dialogue\\undeadexpcamp\\undead07cxInterlude\\L07CArthas43.flac") )
    SetSoundVolume( snd, 70)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayPainSound3()
    local snd = CreateSound("sounds\\Pain3",false, false, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 19)
    SetSoundDuration( snd, GetSoundFileDuration("sounds\\Pain3") )
    SetSoundVolume( snd, 70)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayPainSound4()
    local snd = CreateSound("sounds\\Pain4",false, false, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 19)
    SetSoundDuration( snd, GetSoundFileDuration("sounds\\Pain3") )
    SetSoundVolume( snd, 70)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayPainSound5()
    local snd = CreateSound("sounds\\Pain5",false, false, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 19)
    SetSoundDuration( snd, GetSoundFileDuration("sounds\\Pain3") )
    SetSoundVolume( snd, 70)
    StartSound(snd)
    KillSoundWhenDone(snd)
end

function PlayPainSoundMain()
    local foos = {PlayPainSound1, PlayPainSound2, PlayPainSound3, PlayPainSound4, PlayPainSound5}
    local n = math.random(#foos)
    foos[n]()
end

function PlayImpaleMarkerSound(x, y)
    local snd = CreateSound("Abilities\\weapons\\AvengerMissile\\DestroyerMissile.flac",false, true, false, 10, 10, "DefaultEAXON")
    SetSoundChannel( snd, 10)
    SetSoundDistances( snd, 600.00, 3200 )
    --SetSoundDistanceCutoff( snd, 3000.00)
    SetSoundDuration( snd, GetSoundFileDuration("Abilities\\weapons\\AvengerMissile\\DestroyerMissile.flac") )
    SetSoundVolume( snd, 60)
    --SetSoundConeAngles( snd, 0.0, 0.0, 127 )
    --SetSoundConeOrientation( snd, 0.0, 0.0, 0.0 )
    --SetSoundPitch( snd, 1.0 )
    SetSoundPosition(snd, x, y,100)
    StartSound(snd)
    KillSoundWhenDone(snd)
end