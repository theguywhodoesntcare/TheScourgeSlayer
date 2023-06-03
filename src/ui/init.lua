function InitCustomUI()
    HideDefaultUI()
    ClickBlocker = BlzCreateFrameByType("TEXT", "name", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
        CreateTextFrame(ClickBlocker, -0.1338, 0.6, 0.936020, 0, 0, "", 1)
            BlzFrameSetEnable(ClickBlocker, true)
    HPBar()
    Icons()
    CreateWarnings()
end