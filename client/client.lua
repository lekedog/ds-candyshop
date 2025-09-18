local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

---------------------------------
-- blips
---------------------------------
CreateThread(function()
    for _,v in pairs(Config.PlayerCandyshopLocations) do
        if v.showblip == true then    
            local PlayerSaloonBlip = BlipAddForCoords(-1282792512, v.coords)
            SetBlipSprite(PlayerSaloonBlip, joaat(v.blipsprite), true)
            SetBlipScale(PlayerSaloonBlip, v.blipscale)
            SetBlipName(PlayerSaloonBlip, v.blipname)
        end
    end
end)

---------------------------------------------
-- get correct menu
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:opencandyshop', function(candyshopid, jobaccess, name, rentprice)
    if not Config.EnableRentSystem then
        local PlayerData = RSGCore.Functions.GetPlayerData()
        local playerjob = PlayerData.job.name
        if playerjob == jobaccess then
            TriggerEvent('ds-candyshop:client:openjobmenu', candyshopid)
        else
            TriggerEvent('ds-candyshop:client:opencustomermenu', candyshopid)
        end
    else
        RSGCore.Functions.TriggerCallback('ds-candyshop:server:getcandyshopdata', function(result)
            local owner = result[1].owner
            local status = result[1].status
            if owner ~= 'vacant' then
                local PlayerData = RSGCore.Functions.GetPlayerData()
                local playerjob = PlayerData.job.name
                if playerjob == jobaccess then
                    TriggerEvent('ds-candyshop:client:openrentjobmenu', candyshopid, status)
                else
                    TriggerEvent('ds-candyshop:client:opencustomermenu', candyshopid, status)
                end
            else
                TriggerEvent('ds-candyshop:client:rentcandyshop', candyshopid, name, rentprice)
            end
        end, candyshopid)
    end
end)

---------------------------------------------
-- candy shop job menu (non rent)
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:openjobmenu', function(candyshopid, status)
    lib.registerContext({
        id = 'job_menu',
        title = locale('cl_lang_1'),
        options = {
            {
                title = locale('cl_lang_2'),
                icon = 'fa-solid fa-store',
                event = 'ds-candyshop:client:ownerviewitems',
                args = { candyshopid = candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_3'),
                icon = 'fa-solid fa-circle-plus',
                iconColor = 'green',
                event = 'ds-candyshop:client:newstockitem',
                args = { candyshopid = candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_4'),
                icon = 'fa-solid fa-circle-minus',
                iconColor = 'red',
                event = 'ds-candyshop:client:removestockitem',
                args = { candyshopid = candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_5'),
                icon = 'fa-solid fa-sack-dollar',
                event = 'ds-candyshop:client:withdrawmoney',
                args = { candyshopid = candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_6'),
                icon = 'fa-solid fa-box',
                event = 'ds-candyshop:client:ownerstoragemenu',
                args = { candyshopid = candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_7'),
                icon = 'fa-solid fa-box',
                event = 'ds-candyshop:client:craftingmenu',
                args = { candyshopid = candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_9'),
                icon = 'fa-solid fa-user-tie',
                event = 'rsg-bossmenu:client:mainmenu',
                arrow = true
            },
        }
    })
    lib.showContext('job_menu')
end)

---------------------------------------------
-- candy shop job menu (rent)
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:openrentjobmenu', function(candyshopid, status)
    if status == 'open' then
        lib.registerContext({
            id = 'job_menu',
            title = locale('cl_lang_1'),
            options = {
                {
                    title = locale('cl_lang_2'),
                    icon = 'fa-solid fa-store',
                    event = 'ds-candyshop:client:ownerviewitems',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_3'),
                    icon = 'fa-solid fa-circle-plus',
                    iconColor = 'green',
                    event = 'ds-candyshop:client:newstockitem',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_4'),
                    icon = 'fa-solid fa-circle-minus',
                    iconColor = 'red',
                    event = 'ds-candyshop:client:removestockitem',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_5'),
                    icon = 'fa-solid fa-sack-dollar',
                    event = 'ds-candyshop:client:withdrawmoney',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_6'),
                    icon = 'fa-solid fa-box',
                    event = 'ds-candyshop:client:ownerstoragemenu',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_7'),
                    icon = 'fa-solid fa-box',
                    event = 'ds-candyshop:client:craftingmenu',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_8'),
                    icon = 'fa-solid fa-box',
                    event = 'ds-candyshop:client:rentmenu',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
                {
                    title = locale('cl_lang_9'),
                    icon = 'fa-solid fa-user-tie',
                    event = 'rsg-bossmenu:client:mainmenu',
                    arrow = true
                },
            }
        })
        lib.showContext('job_menu')
    else
        lib.registerContext({
            id = 'job_menu',
            title = locale('cl_lang_1'),
            options = {
                {
                    title = locale('cl_lang_8'),
                    icon = 'fa-solid fa-box',
                    event = 'ds-candyshop:client:rentmenu',
                    args = { candyshopid = candyshopid },
                    arrow = true
                },
            }
        })
        lib.showContext('job_menu')
    end
end)

---------------------------------------------
-- candy shop customer menu
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:opencustomermenu', function(candyshopid, status)
    if status == 'closed' then
        lib.notify({ title = locale('cl_lang_10'), type = 'error', duration = 7000 })
        return
    end
    lib.registerContext({
        id = 'candyshop_customer_menu',
        title = locale('cl_lang_11'),
        options = {
            {
                title = locale('cl_lang_12'),
                icon = 'fa-solid fa-store',
                event = 'ds-candyshop:client:customerviewitems',
                args = { candyshopid = candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_13'),
                icon = 'fa-solid fa-box',
                event = 'ds-candyshop:client:storagebartray',
                args = { candyshopid = candyshopid },
                arrow = true
            },
        }
    })
    lib.showContext('candyshop_customer_menu')
end)

---------------------------------------------
-- candy shop rent money menu
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:rentmenu', function(data)

    RSGCore.Functions.TriggerCallback('ds-candyshop:server:getcandyshopdata', function(result)
    
        local rent = result[1].rent
        if rent > 50  then rentColorScheme = 'green' end
        if rent <= 50 and rent > 10 then rentColorScheme = 'yellow' end
        if rent <= 10 then rentColorScheme = 'red' end
        
        lib.registerContext({
            id = 'candyshop_rent_menu',
            title = locale('cl_lang_14'),
            menu = 'job_menu',
            options = {
                {
                    title = locale('cl_lang_15')..rent,
                    progress = rent,
                    colorScheme = rentColorScheme,
                },
                {
                    title = locale('cl_lang_16'),
                    icon = 'fa-solid fa-dollar-sign',
                    event = 'ds-candyshop:client:payrent',
                    args = { candyshopid = data.candyshopid },
                    arrow = true
                },
            }
        })
        lib.showContext('candyshop_rent_menu')

    end, data.candyshopid)
    
end)

-------------------------------------------------------------------------------------------
-- job : view candy shop items
-------------------------------------------------------------------------------------------
RegisterNetEvent('ds-candyshop:client:ownerviewitems', function(data)

    RSGCore.Functions.TriggerCallback('ds-candyshop:server:checkstock', function(result)

        if result == nil then
            lib.registerContext({
                id = 'candyshop_no_inventory',
                title = locale('cl_lang_17'),
                menu = 'job_menu',
                options = {
                    {
                        title = locale('cl_lang_18'),
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('candyshop_no_inventory')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = RSGCore.Shared.Items[result[k].item].label..' ($'..result[k].price..')',
                    description = locale('cl_lang_19')..result[k].stock,
                    icon = 'fa-solid fa-box',
                    event = 'ds-candyshop:client:buyitem',
                    icon = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    image = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    args = {
                        item = result[k].item,
                        stock = result[k].stock,
                        price = result[k].price,
                        label = RSGCore.Shared.Items[result[k].item].label,
                        candyshopid = result[k].candyshopid
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'candyshop_inv_menu',
                title = locale('cl_lang_17'),
                menu = 'job_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('candyshop_inv_menu')
        end
    end, data.candyshopid)

end)

-------------------------------------------------------------------------------------------
-- customer : view candy shop items
-------------------------------------------------------------------------------------------
RegisterNetEvent('ds-candyshop:client:customerviewitems', function(data)
    RSGCore.Functions.TriggerCallback('ds-candyshop:server:checkstock', function(result)
        if result == nil then
            lib.registerContext({
                id = 'candyshop_no_inventory',
                title = locale('cl_lang_17'),
                menu = 'candyshop_customer_menu',
                options = {
                    {
                        title = locale('cl_lang_18'),
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('candyshop_no_inventory')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = RSGCore.Shared.Items[result[k].item].label..' ($'..result[k].price..')',
                    description = locale('cl_lang_19')..result[k].stock,
                    icon = 'fa-solid fa-box',
                    event = 'ds-candyshop:client:buyitem',
                    icon = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    image = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    args = {
                        item = result[k].item,
                        stock = result[k].stock,
                        price = result[k].price,
                        label = RSGCore.Shared.Items[result[k].item].label,
                        candyshopid = result[k].candyshopid
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'candyshop_inv_menu',
                title = locale('cl_lang_17'),
                menu = 'candyshop_customer_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('candyshop_inv_menu')
        end
    end, data.candyshopid)

end)

-------------------------------------------------------------------
-- sort table function
-------------------------------------------------------------------
local function compareNames(a, b)
    return a.value < b.value
end

-------------------------------------------------------------------
-- add / update stock item
-------------------------------------------------------------------
RegisterNetEvent('ds-candyshop:client:newstockitem', function(data)

    local items = {}

    for k,v in pairs(RSGCore.Functions.GetPlayerData().items) do
        local content = { value = v.name, label = v.label..' ('..v.amount..')' }
        items[#items + 1] = content
    end

    table.sort(items, compareNames)

    local item = lib.inputDialog(locale('cl_lang_20'), {
        { 
            type = 'select',
            options = items,
            label = locale('cl_lang_21'),
            required = true
        },
        { 
            type = 'input',
            label = locale('cl_lang_22'),
            placeholder = '0',
            icon = 'fa-solid fa-hashtag',
            required = true
        },
        { 
            type = 'input',
            label = locale('cl_lang_23'),
            placeholder = '0.00',
            icon = 'fa-solid fa-dollar-sign',
            required = true
        },
    })
    
    if not item then 
        return 
    end
    
    local hasItem = RSGCore.Functions.HasItem(item[1], tonumber(item[2]))
    
    if hasItem then
        TriggerServerEvent('ds-candyshop:server:newstockitem', data.candyshopid, item[1], tonumber(item[2]), tonumber(item[3]))
    else
    lib.notify({ title = (RSGCore.Shared.Items[item[1]] and RSGCore.Shared.Items[item[1]].label or item[1]) .. " is missing!", type = 'error', duration = 7000 })
    end

end)

-------------------------------------------------------------------------------------------
-- remove stock item
-------------------------------------------------------------------------------------------
RegisterNetEvent('ds-candyshop:client:removestockitem', function(data)
    RSGCore.Functions.TriggerCallback('ds-candyshop:server:checkstock', function(result)
        if result == nil then
            lib.registerContext({
                id = 'candyshop_no_stock',
                title = locale('cl_lang_25'),
                menu = 'candyshop_owner_menu',
                options = {
                    {
                        title = locale('cl_lang_26'),
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('candyshop_no_stock')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = RSGCore.Shared.Items[result[k].item].label,
                    description = locale('cl_lang_19')..result[k].stock,
                    icon = 'fa-solid fa-box',
                    serverEvent = 'ds-candyshop:server:removestockitem',
                    icon = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    image = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    args = {
                        item = result[k].item,
                        candyshopid = result[k].candyshopid
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'candyshop_stock_menu',
                title = locale('cl_lang_25'),
                menu = 'job_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('candyshop_stock_menu')
        end
    end, data.candyshopid)
end)

-------------------------------------------------------------------------------------------
-- withdraw money 
-------------------------------------------------------------------------------------------
RegisterNetEvent('ds-candyshop:client:withdrawmoney', function(data)
    RSGCore.Functions.TriggerCallback('ds-candyshop:server:getmoney', function(result)
        local input = lib.inputDialog(locale('cl_lang_27'), {
            { 
                type = 'input',
                label = locale('cl_lang_28')..result.money,
                icon = 'fa-solid fa-dollar-sign',
                required = true
            },
        })
        if not input then
            return 
        end
        local withdraw = tonumber(input[1])
        if withdraw <= result.money then
            TriggerServerEvent('ds-candyshop:server:withdrawfunds', withdraw, data.candyshopid)
        else
            lib.notify({ title = locale('cl_lang_29'), type = 'error', duration = 7000 })
        end
    end, data.candyshopid)
end)

---------------------------------------------
-- buy item amount
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:buyitem', function(data)
    local input = lib.inputDialog(locale('cl_lang_30')..data.label, {
        { 
            label = locale('cl_lang_31'),
            type = 'input',
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })
    if not input then
        return
    end
    
    local amount = tonumber(input[1])
    
    if data.stock >= amount then
        local newstock = (data.stock - amount)
        TriggerServerEvent('ds-candyshop:server:buyitem', amount, data.item, data.candyshopid)
    else
        lib.notify({ title = locale('cl_lang_32'), type = 'error', duration = 7000 })
    end
end)

---------------------------------------------
-- rent candy shop
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:rentcandyshop', function(candyshopid, name)
    
    local input = lib.inputDialog(locale('cl_lang_33')..name, {
        {
            label = locale('cl_lang_34')..Config.RentStartup,
            type = 'select',
            options = {
                { value = 'yes', label = locale('cl_lang_35') },
                { value = 'no',  label = locale('cl_lang_36') }
            },
            required = true
        },
    })

    -- check there is an input
    if not input then
        return 
    end

    -- if no then return
    if input[1] == 'no' then
        return
    end

    RSGCore.Functions.TriggerCallback('rsg-multijob:server:checkjobs', function(canbuy)
        if not canbuy then
            lib.notify({ title = locale('cl_lang_50'), type = 'error', duration = 7000 })
            return
        else
            RSGCore.Functions.TriggerCallback('ds-candyshop:server:countowned', function(result)
        
                if result >= Config.MaxCandyshops then
                    lib.notify({ title = locale('cl_lang_48'), description = locale('cl_lang_49'), type = 'error', duration = 7000 })
                    return
                end
        
                -- check player has a licence
                if Config.LicenseRequired then
                    local hasItem = RSGCore.Functions.HasItem('candyshoplicence', 1)
        
                    if hasItem then
                        TriggerServerEvent('ds-candyshop:server:rentcandyshop', candyshopid)
                    else
                        lib.notify({ title = locale('cl_lang_37'), type = 'error', duration = 7000 })
                    end
                else
                    TriggerServerEvent('ds-candyshop:server:rentcandyshop', candyshopid)
                end
                
            end)
        end
    end)
end)

-------------------------------------------------------------------------------------------
-- pay rent
-------------------------------------------------------------------------------------------
RegisterNetEvent('ds-candyshop:client:payrent', function(data)

        local input = lib.inputDialog(locale('cl_lang_38'), {
            { 
                label = locale('cl_lang_39'),
                type = 'input',
                icon = 'fa-solid fa-dollar-sign',
                required = true
            },
        })
        if not input then
            return 
        end
        
        TriggerServerEvent('ds-candyshop:server:addrentmoney', input[1], data.candyshopid)

end)

---------------------------------------------
-- owner candy shop storage menu
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:ownerstoragemenu', function(data)
    lib.registerContext({
        id = 'owner_storage_menu',
        title = locale('cl_lang_43'),
        menu = 'job_menu',
        options = {
            {
                title = locale('cl_lang_40'),
                icon = 'fa-solid fa-box',
                event = 'ds-candyshop:client:storagebartray',
                args = { candyshopid = data.candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_41'),
                icon = 'fa-solid fa-box',
                event = 'ds-candyshop:client:storagecandymaking',
                args = { candyshopid = data.candyshopid },
                arrow = true
            },
            {
                title = locale('cl_lang_42'),
                icon = 'fa-solid fa-box',
                event = 'ds-candyshop:client:storagestock',
                args = { candyshopid = data.candyshopid },
                arrow = true
            },
        }
    })
    lib.showContext('owner_storage_menu')
end)

---------------------------------------------
-- bar tray storage
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:storagebartray', function(data)
    TriggerServerEvent('ds-candyshop:server:storagebartray', data.candyshopid)
end)

---------------------------------------------
-- candy making storage
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:storagecandymaking', function(data)
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local playerjob = PlayerData.job.name
    if playerjob == data.candyshopid then
       TriggerServerEvent('ds-candyshop:server:storagecandymaking', data.candyshopid)
    end
end)

---------------------------------------------
-- stock storage
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:storagestock', function(data)
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local playerjob = PlayerData.job.name
    if playerjob == data.candyshopid then
       TriggerServerEvent('ds-candyshop:server:storagestock', data.candyshopid)
    end
end)

---------------------------------------------
-- candy shop crafting menu
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:craftingmenu', function(data)
    local hasBPC = data.bpc and RSGCore.Functions.HasItem(data.bpc, 1)
    local hasBPO = data.bpo and RSGCore.Functions.HasItem(data.bpo, 1)
    if data.bpc or data.bpo then
        if not (hasBPC or hasBPO) then
            local bpLabel = (RSGCore.Shared.Items[data.bpc] and RSGCore.Shared.Items[data.bpc].label) or (RSGCore.Shared.Items[data.bpo] and RSGCore.Shared.Items[data.bpo].label) or data.bpc or data.bpo
            lib.notify({ title = bpLabel .. " required", type = 'error', duration = 7000 })
            return
        end
    end
    -- If using BPC, consume it. If using BPO, do not consume.
    if hasBPC then
        TriggerServerEvent('ds-candyshop:server:consumeBlueprint', data.bpc)
    end
    -- existing crafting logic...

end)
