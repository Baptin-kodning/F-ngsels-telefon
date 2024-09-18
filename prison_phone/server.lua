-- Register the server-side event for when a player picks up the phone
RegisterNetEvent('prison:pickupPhone', function()
    local src = source  -- Get the player source who triggered the event
    
    -- Use the correct ox_inventory API to add an item to the player's inventory
    local success = exports.ox_inventory:AddItem(src, 'phone', 1)  -- Adds 1 phone to the player's inventory
    
    -- Debug message to check if the item was added successfully
    if success then
        print("Phone added to player's inventory.")  -- Success message
        TriggerClientEvent('ox_lib:notify', src, {  -- Notify the player about the successful pickup
            type = 'success',
            description = 'You picked up a phone!',
            duration = 5000
        })
    else
        print("Failed to add phone to player's inventory.")  -- Failure message
        TriggerClientEvent('ox_lib:notify', src, {  -- Notify the player about the failure
            type = 'error',
            description = 'Could not pick up the phone. Inventory is full or item does not exist.',
            duration = 5000
        })
    end
end)
