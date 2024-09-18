local phoneCoords = {x = 1691.65, y = 2578.45, z = 45.56}  -- Example prison coordinates
local phoneObject = nil
local phoneSpawned = false
local spawnProbability = 2  -- 2% chance for the phone to spawn

-- Function to spawn a phone
local function spawnPhone()
    -- Only spawn the phone if it isn't already spawned
    if not phoneSpawned then
        -- Generate a random number between 1 and 100
        local chance = math.random(1, 100)
        
        -- Check if the random number falls within the spawn probability
        if chance <= spawnProbability then
            -- Load the phone model
            RequestModel('prop_phone_ing')  -- Example model
            while not HasModelLoaded('prop_phone_ing') do
                Wait(0)
            end
            
            -- Create the phone object at the coordinates
            phoneObject = CreateObject(GetHashKey('prop_phone_ing'), phoneCoords.x, phoneCoords.y, phoneCoords.z, true, true, false)
            
            -- Make the phone targetable with ox_target
            exports.ox_target:addLocalEntity(phoneObject, {
                {
                    name = 'pickup_phone',
                    icon = 'fas fa-phone',
                    label = 'Pick up Phone',
                    onSelect = function()
                        TriggerServerEvent('prison:pickupPhone')  -- Trigger a server event to give the player a phone
                        DeleteObject(phoneObject)  -- Remove the phone from the world
                        phoneSpawned = false  -- Set phoneSpawned to false
                    end
                }
            })
            
            phoneSpawned = true
            print("Phone spawned successfully.")  -- Debugging message
        else
            print("Phone did not spawn this time.")  -- Debugging message
        end
    end
end

-- Periodically check and try to spawn the phone every 30 minutes (1800 seconds)
CreateThread(function()
    while true do
        Wait(1800000)  -- 30 minutes in milliseconds
        spawnPhone()
    end
end)
