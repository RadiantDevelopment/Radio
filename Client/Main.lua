local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

PlayerJob = {}

AddEventHandler('onResourceStart', function()
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    print('Radio disabled')
end)

Radio = {
    notifyPlayer = QBCore.Functions.Notify,

    sendReactMessage = function(action, data)
        SendNUIMessage({
            action = action,
            data = data,
        })
    end,

    setFrequency = function(frequency)
        local player = PlayerData
        PlayerJob = player.job
        
        if frequency <= 20 then
            if PlayerJob ~= 'police' then
                return Radio.notifyPlayer('Unable to connect to Government frequencies.', 'error')
            end
        end

        TriggerEvent('InteractSound_SV:PlayWithinDistance', 'radioclick', 0.6)
  
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
        exports["pma-voice"]:setRadioChannel(frequency)

        Radio.notifyPlayer('Connected to radio frequency ' ..frequency, 'success')
    end,

    open = function()
        Radio.sendReactMessage('Radio:Open');
        SetNuiFocus(true, true);
        print(PlayerJob);
    end,

    close = function()
        ClearPedTasks(PlayerPedId())
        SetNuiFocus(false, false)
    end
}

RegisterCommand('+openRadio', function()
    Radio.open()
    print('Radio opened')
end)

RegisterKeyMapping("+openRadio", "Open Radio", "keyboard", "o")