
local stopsigns = {
    -949234773
}

exports.qtarget:AddTargetModel(stopsigns, {
	options = {
		{
			event = "0pax:stealStopsign",
			icon = "fas fa-sign",
			label = "Steal Stopsign"
		},
	},
	distance = 2
})

RegisterNetEvent('0pax:stealStopsign')
AddEventHandler('0pax:stealStopsign', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    local closestObj = GetClosestObjectOfType(playerCoords, 2.0, `prop_sign_road_01a`, true)

    if DoesEntityExist(closestObj) then
        if(IsPedArmed(playerPed, 1|2|4)) then SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, 1) end

        local dict = "amb@world_human_janitor@male@base"
        LoadAnimDict(dict)
        TaskPlayAnim(playerPed, dict, "base", 5.0, -1, -1, 50, 0, false, false, false)
        RemoveAnimDict(dict)

        stopsign = CreateObject(`prop_sign_road_01a`, playerCoords.x, playerCoords.y, playerCoords.z, true, false, false)
        AttachEntityToEntity(stopsign, playerPed,GetPedBoneIndex(playerPed, 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
        if DoesEntityExist(stopsign) then
            DeleteObject(closestObj)
            SetEntityCoords(closestObj, -100.0, -100.0, -100.0)
        end

        exports['mythic_notify']:SendAlert('inform', 'Drop the stop sign with G')
    end
end)

RegisterCommand('dropStopsign', function(source)
    local playerPed = PlayerPedId()

    if IsEntityAttachedToEntity(stopsign, playerPed) then
        DetachEntity(stopsign, false, false)
        PlaceObjectOnGroundProperly(stopsign)
        ClearPedTasks(playerPed)
    end
end)

RegisterKeyMapping('dropStopsign', 'Drop the stop sign youre holding', 'keyboard', 'g')

function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 