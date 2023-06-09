RegisterNetEvent('av_restaurant:boss')
AddEventHandler('av_restaurant:boss', function()
    local PlayerData = nil
    if Config.Framework == "QBCore" then
        PlayerData = QBCore.Functions.GetPlayerData().job
        if not PlayerData.isboss then
            TriggerEvent('av_restaurant:notification',Lang['not_boss'])
            return
        end
    elseif Config.Framework == "ESX" then
        PlayerData = ESX.GetPlayerData().job
        if PlayerData.grade_name ~= "boss" then
            TriggerEvent('av_restaurant:notification',Lang['not_boss'])
            return
        end
    end
    local job = PlayerData.name
    lib.callback('av_restaurant:getBusiness', false, function(bank)
        lib.registerContext({
            id = 'av_restaurants:getBusiness',
            title = string.upper(job)..' | Boss Menu',
            options = {
                {
                    title = "Withdraw Money $"..bank,
                    description = "Transfer society money to your Bank Account.",
                    serverEvent = "av_restaurant:bossWithdraw",
                },
                {
                    title = "Register Product",
                    description = "Register a new product for your store.",
                    event = "av_restaurant:registerItem",
                    args = {job = job}
                },
                {
                    title = "Manage Menu",
                    description = "Manage your Store Menu.",
                    event = "av_restaurant:manageMenu",
                    args = {job = job}
                },
                
            },
        })
        lib.showContext('av_restaurants:getBusiness')
    end, job)
end)

AddEventHandler('av_restaurant:manageMenu', function(data)
    local job = data['job']
    lib.registerContext({
        id = 'av_restaurants:manageMenu',
        title = 'Manage Menu',
        options = {
            {
                title = "Drinks",
                serverEvent = "av_restaurant:getItems",
                args = {
                    type = 'drink',
                    job = job
                }
            },
            {
                title = "Food",
                serverEvent = "av_restaurant:getItems",
                args = {
                    type = 'food',
                    job = job
                }
            },
            {
                title = "Joints",
                serverEvent = "av_restaurant:getItems",
                args = {
                    type = 'joint',
                    job = job
                }
            },
            {
                title = "Others",
                serverEvent = "av_restaurant:getItems",
                args = {
                    type = 'others',
                    job = job
                }
            },
            
        },
    })
    lib.showContext('av_restaurants:manageMenu')
end)

RegisterNetEvent('av_restaurant:listItems')
AddEventHandler('av_restaurant:listItems', function(items,job)
    local menu = {}
    if items then
        for k, v in pairs(items) do
            menu[#menu+1] = {
                title = v['label'],
                description = v['description'],
                event = "av_restaurant:deleteItem",
                args = {
                    label = v['label'],
                    item = v['name'],
                    job = job
                }
            }
        end
    end
    menu[#menu+1] = {
        title = "← Go Back",
        event = "av_restaurant:manageMenu",
        args = {
            job = job
        }
    }
    lib.registerContext({
        id = 'av_restaurants:listItems',
        title = 'Products',
        options = menu,
    })
    lib.showContext('av_restaurants:listItems')
end)

AddEventHandler('av_restaurant:deleteItem', function(data)
    local menu = {
        {
            title = "NO",
            event = "av_restaurant:boss"
        },
        {
            title = "YES",
            serverEvent = "av_restaurant:deleteItem",
            args = {
                name = data['item']
            }
        },
        {
            title = "NO",
            event = "av_restaurant:boss"
        },
        {
            title = "← Go Back",
            event = "av_restaurant:manageMenu",
            args = {
                job = data['job']
            }
        },
    }
    lib.registerContext({
        id = 'av_restaurants:deleteItem',
        title = 'Delete Product '..data['label']..'?',
        options = menu,
    })
    lib.showContext('av_restaurants:deleteItem')
end)