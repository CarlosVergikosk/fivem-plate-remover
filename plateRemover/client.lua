--MADE TO INSONIA RP
--FREE YO USE

local index 			 	  = nil
local number 				  = nil
ESX                           = nil

RegisterCommand('removeplate', function(source, args, rawCommand)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 70)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(GetVehiclePedIsIn(playerPed, true)).x, GetEntityCoords(GetVehiclePedIsIn(playerPed, true)).y,GetEntityCoords(GetVehiclePedIsIn(playerPed, true)).z, coords.x, coords.y, coords.z)	
	if ((distance < 3.5) and (IsPedInAnyVehicle(playerPed,  false) == false)) then
			TriggerEvent("mythic_progbar:client:progress", {
				name = "retirarmatricula",
				duration = 7000,
				label = "removing plate...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mini@repair",
					anim = "fixing_a_player",
				}
			}, function(status)
				if not status then
					StopAnimTask(PlayerPedId(), 'mini@repair', 'fixing_a_player', 1.0)
				end
			end)
			Citizen.Wait(6000)
			index = GetVehicleNumberPlateTextIndex(vehicle)
			number = GetVehicleNumberPlateText(vehicle)
			SetVehicleNumberPlateText(vehicle, ' ')
			hasPlate = false
					
	else
	
		exports['mythic_notify']:SendAlert('error', 'No vehicle nearby')
	
	end
end)

RegisterCommand('putplate', function(source, args, rawCommand)

	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 70)
	local distance = GetDistanceBetweenCoords(GetEntityCoords(GetVehiclePedIsIn(playerPed, true)).x, GetEntityCoords(GetVehiclePedIsIn(playerPed, true)).y,GetEntityCoords(GetVehiclePedIsIn(playerPed, true)).z, coords.x, coords.y, coords.z)
	if ((distance < 3.5) and (IsPedInAnyVehicle(playerPed,  false) == false)) then
			TriggerEvent("mythic_progbar:client:progress", {
				name = "retirarmatricula",
				duration = 7000,
				label = "placing plate...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mini@repair",
					anim = "fixing_a_player",
				}
			}, function(status)
				if not status then
					StopAnimTask(PlayerPedId(), 'mini@repair', 'fixing_a_player', 1.0)
				end
			end)
			Citizen.Wait(6000)
			SetVehicleNumberPlateTextIndex(vehicle, index)
			SetVehicleNumberPlateText(vehicle, number)
			index 			 	  = nil
			number 				  = nil
			hasPlate = true	
	else
	
		exports['mythic_notify']:SendAlert('error', 'No vehicle nearby')
	
	end
	
end)

