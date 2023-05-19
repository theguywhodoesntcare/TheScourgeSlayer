function InitCameraScrollBar()
    -- create a vertical slider by inheriting from a Scrollbar. It will use esc menu textures
    local sliderFrame = BlzCreateFrameByType( "SLIDER", "TestSlider", BlzGetFrameByName("ConsoleUIBackdrop", 0), "QuestMainListScrollBar", 0 )
    -- clear the inherited attachment
    BlzFrameClearAllPoints(sliderFrame)
    -- set pos and size
    BlzFrameSetLevel(sliderFrame, 3)
    BlzFrameSetAbsPoint(sliderFrame, FRAMEPOINT_CENTER, 0.92, 0.30 )
    BlzFrameSetSize(sliderFrame, 0.014, 0.1 )
    -- define the area the user can choose from
    BlzFrameSetMinMaxValue(sliderFrame, 0, 80)
    -- how accurate the user can choose value
    BlzFrameSetStepSize(sliderFrame, 20)
    BlzFrameSetValue(sliderFrame, 40)

    local trigger = CreateTrigger()

    -- register the Slider Event
    BlzTriggerRegisterFrameEvent(trigger, sliderFrame, FRAMEEVENT_SLIDER_VALUE_CHANGED)

    -- this happens when the Slider is pushed
    TriggerAddAction(trigger, function()
        local frame = BlzGetTriggerFrame()
        --print(BlzFrameGetName(frame), "new Value", BlzGetTriggerFrameValue())
        SetGameCamera(BlzGetTriggerFrameValue())

    end)

    -- scorllable with mousewheel
    local triggerWheel = CreateTrigger()
    -- register the Mouse Wheel Event for the Slider
    BlzTriggerRegisterFrameEvent(triggerWheel, sliderFrame, FRAMEEVENT_MOUSE_WHEEL)
    -- this happens when the Mouse wheel is rolled while it points at the slider
    TriggerAddAction(triggerWheel, function()

        -- BlzGetTriggerFrameValue() tells us in which direction the wheel was rolled
        local add
        if BlzGetTriggerFrameValue() > 0 then
            add = 20
        else
            add = -20
        end

        -- the scrolling should only affect the triggering Player
        if GetLocalPlayer() == GetTriggerPlayer() then
            BlzFrameSetValue(sliderFrame, BlzFrameGetValue(sliderFrame) + add)
        end
    end)
end