
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
    closestObj = GetClosestObjectOfType(playerCoords, 2.0, `prop_sign_road_01a`, true)
    if DoesEntityExist(closestObj) then
        loadAnimDict("amb@world_human_janitor@male@base")
        TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@base", "base", 5.0, -1, -1, 50, 0, false, false, false)
        stopsign = CreateObject(`prop_sign_road_01a`, playerCoords.x, playerCoords.y, playerCoords.z, true, false, false)
        AttachEntityToEntity(stopsign, PlayerPedId(),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
        exports['mythic_notify']:SendAlert('inform', 'Drop the stop sign with G')
    end
    if DoesEntityExist(stopsign) then
        DeleteObject(stopsign)
        DeleteEntity(stopsign)
        DeleteObject(closestObj)
        SetEntityCoords(closestObj, -100.0, -100.0, -100.0)
        loadAnimDict("amb@world_human_janitor@male@base")
        TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@base", "base", 5.0, -1, -1, 50, 0, false, false, false)
        stopsign = CreateObject(`prop_sign_road_01a`, playerCoords.x, playerCoords.y, playerCoords.z, true, false, false)
        AttachEntityToEntity(stopsign, PlayerPedId(),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
    end
end)

RegisterCommand('dropStopsign', function(source)
    if IsEntityAttachedToEntity(stopsign, PlayerPedId()) then
        DetachEntity(stopsign, false, false)
        PlaceObjectOnGroundProperly(stopsign)
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterKeyMapping('dropStopsign', 'Drop the stop sign youre holding', 'keyboard', 'g')

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 