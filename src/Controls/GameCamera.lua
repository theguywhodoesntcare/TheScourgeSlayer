function SetGameCamera(preset)
    if preset == 40 then
        ResetToGameCamera( 1 )
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 200, true)
    end
    if preset == 60 then
        local t = {1480, 4800, 16, 310, 62, 1.570796, 20}
        local d = 2
        SetCameraFields(t, d)
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 0, true)
    end
    if preset == 80 then
        local t = {800, 4000, 16, 338.045, 30.0027917027, 1.570796, 20}
        local d = 2
        SetCameraFields(t, d)
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 0, true)
    end
    if preset == 0 then
        local t = {3000, 5400, 16, 304, 90, 1.570796, 20}
        local d = 2
        SetCameraFields(t, d)
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 0, true)
    end
    if preset == 20 then
        local t = {2400, 5400, 16, 304, 80, 1.570796, 20}
        local d = 2
        SetCameraFields(t, d)
        SetCameraTargetControllerNoZForPlayer(Player(0), slayer, 0, 0, true)
    end
end

function SetCameraFields(t, d)
    SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, t[1], d)
    SetCameraField(CAMERA_FIELD_FARZ, t[2], d)
    SetCameraField(CAMERA_FIELD_NEARZ, t[3], d)
    SetCameraField(CAMERA_FIELD_ANGLE_OF_ATTACK, t[4], d)
    SetCameraField(CAMERA_FIELD_FIELD_OF_VIEW, t[5], d)
    SetCameraField(CAMERA_FIELD_ROTATION, t[6])
    SetCameraField(CAMERA_FIELD_ZOFFSET, t[7])
    --------------------
    SetCameraField(CAMERA_FIELD_ROLL, 0.0)
    SetCameraField(CAMERA_FIELD_LOCAL_PITCH, 0)
    SetCameraField(CAMERA_FIELD_LOCAL_YAW, 0)
    SetCameraField(CAMERA_FIELD_LOCAL_ROLL, 0)
end
