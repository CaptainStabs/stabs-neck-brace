local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    -- Functions for adding and removing collar
    exports['qb-target']:AddGlobalPlayer({
        options = { -- This is your options table, in this table all the options will be specified for the target to accept
            { -- This is the first table with options, you can make as many options inside the options table as you want
            num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
            type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
            event = "collar:attachCollar", -- This is the event it will trigger on click, this can be a client event, server event, command or qbcore registered command, NOTICE: Normal command can't have arguments passed through, QBCore registered ones can have arguments passed through
            icon = 'fas fa-example', -- This is the icon that will display next to this trigger option
            label = 'Apply cervical collar', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
            -- item = 'handcuffs', -- This is the item it has to check for, this option will only show up if the player has this item, this is OPTIONA
            -- job = 'ambulance', -- This is the job, this option won't show up if the player doesn't have this job, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2},
            }, {
            num = 2, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
            type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
            event = "collar:detachCollar", -- This is the event it will trigger on click, this can be a client event, server event, command or qbcore registered command, NOTICE: Normal command can't have arguments passed through, QBCore registered ones can have arguments passed through
            icon = 'fas fa-example', -- This is the icon that will display next to this trigger option
            label = 'Remove cervical collar', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
            -- item = 'handcuffs', -- This is the item it has to check for, this option will only show up if the player has this item, this is OPTIONA
            -- job = 'ambulance', -- This is the job, this option won't show up if the player doesn't have this job, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2},
            }
        },
        distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
        })
    

end)