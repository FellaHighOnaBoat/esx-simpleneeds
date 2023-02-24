Config = {}
Config.NewESX = true --If you are using an esx version that can utilise ESX = exports["es_extended"]:getSharedObject(), set it to true.
ESX = nil
--Name = spawncode of the item
--Type = hunger/thirst/drunk - eat fills hunger, drink fills thirst, alcohol gives drunk effect

local items = {
    {name = 'food', type = 'eat'},
    {name = 'drink', type = 'drink'},
    {name = 'booze', type = 'drunk'}
}

if Config.NewESX then
    ESX = exports["es_extended"]:getSharedObject()
else
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

for i=1, #items do
    ESX.RegisterUsableItem(items[i].name, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if items[i].type == 'drink' then
            TriggerClientEvent('esx_basicneeds:onDrink', source)
            Citizen.Wait(5000)
            TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
        elseif items[i].type == 'eat' then
            TriggerClientEvent('esx_basicneeds:onEat', source)
            Citizen.Wait(5000)
            TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)
        elseif items[i].type == 'drunk' then
            TriggerClientEvent('esx_basicneeds:onDrink', source)
            Citizen.Wait(5000)
            TriggerClientEvent('esx_status:add', source, 'drunk', 1000000)
        end
        xPlayer.removeInventoryItem(items[i].name, 1)
    end)
end