local ESX = exports["es_extended"]:getSharedObject()

---@type table<string, {status: string, clientType: string}>
---@field status string The esx_status key to fill (hunger/thirst/drunk)
---@field clientType string The item type passed to esx_basicneeds:onUse (eat/drink)
local items = {
    food  = { status = 'hunger', clientType = 'eat'   },
    drink = { status = 'thirst', clientType = 'drink'  },
    booze = { status = 'drunk',  clientType = 'drink'  }
}

for itemName, data in pairs(items) do
    ESX.RegisterUsableItem(itemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return end

        TriggerClientEvent('esx_basicneeds:onUse', source, data.clientType)

        SetTimeout(5000, function()
            TriggerClientEvent('esx_status:add', source, data.status, 1000000)
            xPlayer.removeInventoryItem(itemName, 1)
        end)
    end)
end
