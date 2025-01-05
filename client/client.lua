-- Functie om een voertuig te spawnen
local function spawnVehicle(vehicleModel)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- Zorg dat het voertuigmodel geladen wordt
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(0)
    end

    -- Voertuig spawnen
    local vehicle = CreateVehicle(vehicleModel, playerCoords.x, playerCoords.y, playerCoords.z + 1.0, GetEntityHeading(playerPed), true, false)
    SetPedIntoVehicle(playerPed, vehicle, -1) -- Speler in het voertuig zetten
    SetModelAsNoLongerNeeded(vehicleModel) -- Model niet meer nodig

    -- Basisinstellingen voor het voertuig
    SetVehicleNumberPlateText(vehicle, "CUSTOM")
    SetVehicleEngineOn(vehicle, true, true, false)

    -- Meld in de chat dat het voertuig is gespawnd
    lib.notify({
        title = 'Voertuig Gespawnd',
        description = ('Je hebt een %s gespawnd!'):format(vehicleModel),
        type = 'success'
    })
end

-- Open het voertuig spawner menu
local function openVehicleMenu()
    local menuOptions = {
        {
            label = 'Adder (Supercar)',
            description = 'Een snelle supercar.',
            icon = 'fa-car',
            args = { model = 'adder' }
        },
        {
            label = 'Blista (Compact)',
            description = 'Een kleine compacte auto.',
            icon = 'fa-car',
            args = { model = 'blista' }
        },
        {
            label = 'Dominator (Muscle)',
            description = 'Een krachtige muscle car.',
            icon = 'fa-car',
            args = { model = 'dominator' }
        },
        {
            label = 'Exit Menu',
            description = 'Sluit het menu.',
            icon = 'fa-times',
            close = true
        }
    }

    lib.registerContext({
        id = 'vehicle_spawn_menu',
        title = 'Voertuig Spawner',
        options = menuOptions
    })

    lib.showContext('vehicle_spawn_menu')
end

-- Event voor menu-opties
RegisterNetEvent('ox:optionSelected', function(data)
    if data.args and data.args.model then
        spawnVehicle(data.args.model)
    end
end)

-- Command om menu te openen
RegisterCommand('spawnvehicle', function()
    openVehicleMenu()
end, false)
