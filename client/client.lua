local QBCore = exports['qb-core']:GetCoreObject()
collar = nil
local objectHash = GetHashKey('cervical_collar')

local function AttachCollarToPlayer(targetPlayer, collar)
    TriggerServerEvent("AttachCollarToPlayer", targetPlayer, NetworkGetNetworkIdFromEntity(collar))
end

local function RemoveCollarFromPlayer(targetPlayer)
    TriggerServerEvent("RemoveCollarFromPlayer", targetPlayer)
end

local function attachCollar()
    local closestPlayer = GetClosestPlayer()
    if closestPlayer ~= nil then
        playerPed = GetPlayerPed(closestPlayer)
        
        local playerServerId = GetPlayerServerId(closestPlayer)

        QBCore.Functions.TriggerCallback('neckBrace:server:CheckCollarAttached', function(collarModel)
            if DoesEntityExist(playerPed) and not DoesEntityExist(collar) and collarModel == nil then
                local neckBone = GetPedBoneIndex(playerPed, 39317)
                collar = CreateObject(objectHash, 0.0, 0.0, 0.0, true, true, true)

                local collarNetId = NetworkGetNetworkIdFromEntity(collar)

                NetworkRegisterEntityAsNetworked(collar)
                SetNetworkIdCanMigrate(collarNetId, true)
                SetNetworkIdExistsOnAllMachines(collarNetId, true)
                SetEntityAsMissionEntity(collar)

                -- send serverId to be saved on server side
                AttachCollarToPlayer(playerServerId, collarNetId)

                AttachEntityToEntity(collar, playerPed, neckBone, 0.03, 0.01, 0, -25.0, 90.0, 180.0, true, true, false, true, 1, true)
                SetPedCanHeadIk(playerPed, false)
                
                Citizen.CreateThread(function()
                    while DoesEntityExist(collar) do
                        SetPedCanHeadIk(playerPed, false) -- Only visible to other people
                        Citizen.Wait(0)
                    end
                end)
            end
        end, playerServerId)
        
    end
end


function detachCollar()
    local closestPlayer = GetClosestPlayer()
    local playerServerId = GetPlayerServerId(closestPlayer)
    QBCore.Functions.TriggerCallback('neckBrace:server:CheckCollarAttached', function(serverCollarModel)
        if serverCollarModel ~= nil then
            local playerPed = GetPlayerPed(closestPlayer)
            local collarEntity = NetToEnt(serverCollarModel)
            collar = nil
            RemoveCollarFromPlayer(playerServerId, serverCollarModel)
            SetPedCanHeadIk(playerPed, true)

    else
        print("Nothing to delete")
    end

    end, playerServerId)
end

function GetClosestPlayer()
    local players = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    
    for i = 1, #players do
        local playerId = players[i]
        if playerId ~= PlayerId() then
            local playerPed = GetPlayerPed(playerId)
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = playerId
            end
        end
    end
    return closestPlayer
end

local function LoadModel(modelHash)
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end
    end
end

RegisterNetEvent("collar:detachCollar")
AddEventHandler("collar:detachCollar", function()
    detachCollar()
end)

RegisterNetEvent("collar:attachCollar")
AddEventHandler("collar:attachCollar", function()
    attachCollar()
end)

-- Debugging commands
RegisterCommand("removeCollar", function()
    detachCollar()
end, false)


-- RegisterCommand("applyCollar", function()
--     AttachCollar()
-- end, false)

-- RegisterCommand("checkCollar", function()
--     local closestPlayer = GetClosestPlayer()
--     if closestPlayer ~= nil then
--         playerPed = GetPlayerPed(closestPlayer)
        
--         local playerServerId = GetPlayerServerId(closestPlayer)

--         QBCore.Functions.TriggerCallback('neckBrace:server:CheckCollarAttached', function(collarModel)
--             print('collarattached', collarModel)
--         end, playerServerId)
--     end
-- end)

Citizen.CreateThread(function()
    LoadModel(objectHash)
end)
