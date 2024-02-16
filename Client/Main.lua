local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

PlayerJob = {}

AddEventHandler('onResourceStart', function()
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    print('Players dsisconnected from radio.')
end)


-- Loads the requested animation
local function LoadAnimDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end


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
        LoadAnimDic("cellphone@")
        TriggerEvent("attachItemRadio","radio01")
		TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)

		radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)

        Radio.sendReactMessage('Radio:Open');
        SetNuiFocus(true, true);
        print(PlayerJob);
    end,

    close = function()
        StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
		ClearPedTasks(PlayerPedId())

		if radioProp ~= 0 then
			DeleteObject(radioProp)
			radioProp = 0
		end
        
        SetNuiFocus(false, false)
    end
}

RegisterCommand('+openRadio', function()
    Radio.open()
    print('Radio opened')
end)

RegisterKeyMapping("+openRadio", "Open Radio", "keyboard", "o")