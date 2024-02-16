RegisterNUICallback('Radio:Close', function()
    Radio.close();
end)

RegisterNUICallback('Radio:setPower', function(data)
    if Radio.radioPower then
        print('Radio off')
        exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    else
        print('Radio on')
    end

    Radio.radioPower = not Radio.radioPower
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)

RegisterNUICallback('Radio:setFrequency', function(frequency, cb)
    Radio.setFrequency(frequency)
end)