function InitCustomUI()
    HideDefaultUI()
    consoleFrame = BlzGetFrameByName("ConsoleUIBackdrop", 0)

    truewidth = BlzGetLocalClientWidth()/BlzGetLocalClientHeight()*0.6
    offsetWidth = truewidth / 2

    BlzFrameSetVisible(BlzGetFrameByName("UpperButtonBarFrame",0), true)
    BlzFrameSetVisible(BlzGetFrameByName("UpperButtonBarAlliesButton",0), false)
    BlzFrameSetVisible(BlzGetFrameByName("UpperButtonBarChatButton",0), false)
    BlzFrameSetVisible(BlzGetFrameByName("UpperButtonBarQuestsButton",0), false)

    local menu = BlzGetFrameByName("UpperButtonBarFrame",0)
    BlzFrameSetParent(menu, consoleFrame)
    BlzFrameClearAllPoints(menu)

    BlzFrameSetAbsPoint(menu, FRAMEPOINT_TOPLEFT, 0.4 - offsetWidth - 0.12, 0.6)
    BlzFrameSetAbsPoint(menu, FRAMEPOINT_BOTTOMRIGHT, 0.4 - offsetWidth - 0.02, 0.56)
    BlzFrameSetScale(menu, 1.4)

    ClickBlocker = BlzCreateFrameByType("TEXT", "name", BlzGetFrameByName("ConsoleUIBackdrop", 0), "", 0)
        CreateTextFrame(ClickBlocker, -0.1338, 0.6, 0.936020, 0, 0, "", 1)
            BlzFrameSetEnable(ClickBlocker, true)
    HPBar()
    Icons()
    CreateWarnings()
end