-- Made by IB1G, edited by Inferno (Christopher M.)

local LicencePlate = {}
LicencePlate.Index = false
LicencePlate.Number = false

-- Command to remove plate
RegisterCommand("removeplate", function()
    -- Check if the player has plates stored
    if not LicencePlate.Index and not LicencePlate.Number then
        -- Client's ped
        local PlayerPed = PlayerPedId()
        -- Client's coords
        local Coords = GetEntityCoords(PlayerPed)
        -- Client's vehicle location
        local PedVehicleLocation = GetEntityCoords(GetVehiclePedIsIn(PlayerPed, false))
        -- Closest vehicle
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        -- Distance between client's ped and closest vehicle
        local Distance = Vdist(PedVehicleLocation.x, PedVehicleLocation.y, PedVehicleLocation.z, Coords.x, Coords.y, Coords.z)
        -- If within range and Ped is in a vehicle
        if Distance < 3.5 and IsPedInAnyVehicle(PlayerPed, false) then
            -- Notification and animation
            TriggerEvent("mythic_progbar:client:progress", {
                name = "retirarmatricula",
                duration = 7000,
                label = "Removing plate...",
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
                    StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
                end
            end)
            -- Wait 6 seconds
            Citizen.Wait(6000)
            -- Store plate index
            LicencePlate.Index = GetVehicleNumberPlateTextIndex(Vehicle)
            -- Store plate number
            LicencePlate.Number = GetVehicleNumberPlateText(Vehicle)
            -- Set the plate to nothing
            SetVehicleNumberPlateText(Vehicle, " ")
        else
            -- Notification
            exports["mythic_notify"]:SendAlert("error", "No vehicle nearby")
        end
    else
        -- Notification
        exports["mythic_notify"]:SendAlert("error", "You already have a licence plate on you")
    end
end)

-- Command to put plate back
RegisterCommand("putplate", function()
    -- Check if the player has plates stored
    if LicencePlate.Index and LicencePlate.Number then
        -- Client's ped
        local PlayerPed = PlayerPedId()
        -- Client's coords
        local Coords = GetEntityCoords(PlayerPed)
        -- Client's vehicle location
        local PedVehicleLocation = GetEntityCoords(GetVehiclePedIsIn(PlayerPed, false))
        -- Closest vehicle
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        -- Distance between client's ped and closest vehicle
        local Distance = Vdist(PedVehicleLocation.x, PedVehicleLocation.y, PedVehicleLocation.z, coords.x, coords.y, coords.z)
        -- If within range and Ped is in a vehicle
        if Distance < 3.5 and IsPedInAnyVehicle(PlayerPed, false) then
            -- Notification
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
                    StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
                end
            end)
            -- Wait 6 seconds
            Citizen.Wait(6000)
            -- Set plate index to stored index
            SetVehicleNumberPlateTextIndex(Vehicle, index)
            -- Set plate number to stored number
            SetVehicleNumberPlateText(Vehicle, number)
            -- Set the plate to nothing
            SetVehicleNumberPlateText(Vehicle, " ")
            -- Reset stored values
            LicencePlate.Index = false
            LicencePlate.Number = false
        else
            -- Notification
            exports['mythic_notify']:SendAlert("error", "No vehicle nearby")
        end
    else
        -- Notification
        exports['mythic_notify']:SendAlert("error", "You do not have a licence plate on you")
    end
end)
