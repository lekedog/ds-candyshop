local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

---------------------------------------------
-- crafting menu
---------------------------------------------
local CategoryMenus = {}

CreateThread(function()
    for _, v in ipairs(Config.CandyshopCrafting) do
        local IngredientsMetadata = {}
        local setheader = RSGCore.Shared.Items[tostring(v.receive)].label
        local itemimg = "nui://"..Config.Img..RSGCore.Shared.Items[tostring(v.receive)].image

        for i, ingredient in ipairs(v.ingredients) do
            table.insert(IngredientsMetadata, { label = RSGCore.Shared.Items[ingredient.item].label, value = ingredient.amount })
        end

        local option = {
            title = setheader,
            icon = itemimg,
            event = 'ds-candyshop:client:checkingredients',
            metadata = IngredientsMetadata,
            args = {
                title = setheader,
                category = v.category,
                ingredients = v.ingredients,
                crafttime = v.crafttime,
                bpo = v.bpo,
                bpc = v.bpc,
                craftingxp = v.craftingxp,
                receive = v.receive,
                giveamount = v.giveamount,

            }
        }

        if not CategoryMenus[v.category] then
            CategoryMenus[v.category] = {
                id = 'crafting_menu_' .. v.category,
                title = v.category,
                menu = 'job_menu',
                onBack = function() end,
                options = { option }
            }
        else
            table.insert(CategoryMenus[v.category].options, option)
        end
    end
end)

CreateThread(function()
    for category, MenuData in pairs(CategoryMenus) do
        RegisterNetEvent('ds-candyshop:client:' .. category)
        AddEventHandler('ds-candyshop:client:' .. category, function()
            lib.registerContext(MenuData)
            lib.showContext(MenuData.id)
        end)
    end
end)

RegisterNetEvent('ds-candyshop:client:craftingmenu', function()
    local Menu = {
        id = 'crafting_menu',
        title = locale('cl_lang_44'),
        menu = 'job_menu',
        onBack = function() end,
        options = {}
    }

    for category, MenuData in pairs(CategoryMenus) do
        table.insert(Menu.options, {
            title = category,
            description = locale('cl_lang_45') .. category,
            event = 'ds-candyshop:client:' .. category,
            arrow = true
        })
    end

    lib.registerContext(Menu)
    lib.showContext(Menu.id)
end)

---------------------------------------------
-- craft item
---------------------------------------------
RegisterNetEvent('ds-candyshop:client:checkingredients', function(data)
    -- Blueprint check (bpc or bpo)
    if data.bpc or data.bpo then
        local hasBPC = data.bpc and RSGCore.Functions.HasItem(data.bpc, 1)
        local hasBPO = data.bpo and RSGCore.Functions.HasItem(data.bpo, 1)
        if not (hasBPC or hasBPO) then
            lib.notify({ title = "Missing either BPO or BPC!", type = 'error', duration = 7000 })
            return
        end
    end
    RSGCore.Functions.TriggerCallback('ds-candyshop:server:checkingredients', function(hasRequired)
        if not hasRequired then 
            return 
        end
        LocalPlayer.state:set("inv_busy", true, true) -- lock inventory
        if lib.progressBar({
            duration = tonumber(data.crafttime),
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disableControl = true,
            disable = {
                move = true,
                mouse = true,
            },
            label = locale('cl_lang_46').. (RSGCore.Shared.Items[data.receive] and RSGCore.Shared.Items[data.receive].label or tostring(data.receive)),
        }) then
            TriggerServerEvent('ds-candyshop:server:finishcrafting', data)
        end
        LocalPlayer.state:set("inv_busy", false, true) -- unlock inventory
    end, data.ingredients)
end)