local QBCore = exports['qb-core']:GetCoreObject()
collars = {}

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

QBCore.Functions.CreateCallback('neckBrace:server:CheckCollarAttached', function(_, cb, targetPlayer)
    local targetPlayer = tostring(targetPlayer)
    print("CheckCollarAttached", dump(collars))
    print('this should be collars number', collars[targetPlayer])
    print('targetPlayer', targetPlayer)
    if collars[targetPlayer] ~= nil then
        collarModel = collars[targetPlayer]
        print('attached, model', collarModel)

    else 
        collarModel = nil
    end
    cb(collarModel)
end)

RegisterServerEvent("AttachCollarToPlayer")
AddEventHandler("AttachCollarToPlayer", function(targetPlayer, collar)
    local targetPlayer = tostring(targetPlayer)
    collars[targetPlayer] = collar
    print("ATTACHCollar", dump(collars))
end)

RegisterServerEvent("RemoveCollarFromPlayer")
AddEventHandler("RemoveCollarFromPlayer", function(targetPlayer)
    local targetPlayer = tostring(targetPlayer)
    local collar = NetworkGetEntityFromNetworkId(collars[targetPlayer])
    DeleteEntity(collar)
    collars[targetPlayer] = nil
    print("after removal", collars[targetPlayer])
end)
