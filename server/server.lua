local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

---------------------------------------------
-- admin command for candy shop reset /resetcandyshop candyshopid
---------------------------------------------
RSGCore.Commands.Add('resetcandyshop', locale('sv_lang_7'), { { name = 'candyshopid', help = locale('sv_lang_8') } }, true, function(source, args)

    local candyshopid = args[1]
    local result = MySQL.prepare.await("SELECT COUNT(*) as count FROM ds_candyshop WHERE candyshopid = ?", { candyshopid })

    if result == 1 then
        -- update ds_candyshop table
        MySQL.update('UPDATE ds_candyshop SET owner = ? WHERE candyshopid = ?', {'vacant', candyshopid})
        MySQL.update('UPDATE ds_candyshop SET rent = ? WHERE candyshopid = ?', {0, candyshopid})
        MySQL.update('UPDATE ds_candyshop SET rent = ? WHERE candyshopid = ?', {0, candyshopid})
        MySQL.update('UPDATE ds_candyshop SET status = ? WHERE candyshopid = ?', {'closed', candyshopid})
        MySQL.update('UPDATE ds_candyshop SET money = ? WHERE candyshopid = ?', {0.00, candyshopid})
        -- delete stock in ds_candyshop_stock
        MySQL.Async.execute('DELETE FROM ds_candyshop_stock WHERE candyshopid = ?', { candyshopid })
        -- update funds in management_funds
        MySQL.update('UPDATE management_funds SET amount = ? WHERE job_name = ?', {0, candyshopid})
        -- delete job in player_jobs
        MySQL.Async.execute('DELETE FROM player_jobs WHERE job = ?', { candyshopid })
        -- delete stashes
        MySQL.Async.execute('DELETE FROM inventories WHERE identifier = ?', { 'candymaking_'..candyshopid })
        MySQL.Async.execute('DELETE FROM inventories WHERE identifier = ?', { 'bartray_'..candyshopid })
        MySQL.Async.execute('DELETE FROM inventories WHERE identifier = ?', { 'stock_'..candyshopid })
        TriggerClientEvent('ox_lib:notify', source, {title = locale('sv_lang_9'), type = 'success', duration = 7000 })
    else
        TriggerClientEvent('ox_lib:notify', source, {title = locale('sv_lang_10'), type = 'error', duration = 7000 })
    end

end, 'admin')


---------------------------------------------
-- functions
---------------------------------------------
function isPlayerCandyshopOwner(src, candyshopid)
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return false end
    local jobaccess = nil
    for k,v in ipairs(Config.PlayerCandyshopLocations) do
        if v.candyshopid == candyshopid then
            jobaccess = v.jobaccess
            break
        end
    end
    return jobaccess ~= nil and Player.PlayerData.job.name == jobaccess and Player.PlayerData.job.grade.level == 2
end
function isPlayerCandyshopWorker(src, candyshopid)
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return false end
    local jobaccess = nil
    for k,v in ipairs(Config.PlayerCandyshopLocations) do
        if v.candyshopid == candyshopid then
            jobaccess = v.jobaccess
            break
        end
    end
    return jobaccess ~= nil and Player.PlayerData.job.name == jobaccess
end
function countOwnedCandyshops(src)
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return 0 end
    local citizenid = Player.PlayerData.citizenid
    local result = MySQL.prepare.await("SELECT COUNT(*) as count FROM ds_candyshop WHERE owner = ?", { citizenid })
    return result
end

---------------------------------------------
-- count owned candy shops
---------------------------------------------
RSGCore.Functions.CreateCallback('ds-candyshop:server:countowned', function(source, cb)
    local src = source
    cb(countOwnedCandyshops(src))
end)

---------------------------------------------
-- get data
---------------------------------------------
RSGCore.Functions.CreateCallback('ds-candyshop:server:getcandyshopdata', function(source, cb, candyshopid)
    MySQL.query('SELECT * FROM ds_candyshop WHERE candyshopid = ?', { candyshopid }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- check stock
---------------------------------------------
RSGCore.Functions.CreateCallback('ds-candyshop:server:checkstock', function(source, cb, candyshopid)
    MySQL.query('SELECT * FROM ds_candyshop_stock WHERE candyshopid = ?', { candyshopid }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- update stock or add new stock
---------------------------------------------
RegisterNetEvent('ds-candyshop:server:newstockitem', function(candyshopid, item, amount, price)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if not isPlayerCandyshopWorker(src, candyshopid) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_not_candyshop_worker'), type = 'error', duration = 7000 })
        return
    end

    if not Player.Functions.RemoveItem(item, amount) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_no_item'), type = 'error', duration = 7000 })
        return
    end
    
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove', amount)
    local itemcount = MySQL.prepare.await("SELECT COUNT(*) as count FROM ds_candyshop_stock WHERE candyshopid = ? AND item = ?", { candyshopid, item })
    if itemcount == 0 then
        MySQL.Async.execute('INSERT INTO ds_candyshop_stock (candyshopid, item, stock, price) VALUES (@candyshopid, @item, @stock, @price)',
        {
            ['@candyshopid'] = candyshopid,
            ['@item'] = item,
            ['@stock'] = amount,
            ['@price'] = price
        })
    else
        MySQL.query('SELECT * FROM ds_candyshop_stock WHERE candyshopid = ? AND item = ?', { candyshopid, item }, function(data)
            local stockupdate = (amount + data[1].stock)
            MySQL.update('UPDATE ds_candyshop_stock SET stock = ? WHERE candyshopid = ? AND item = ?',{stockupdate, candyshopid, item})
            MySQL.update('UPDATE ds_candyshop_stock SET price = ? WHERE candyshopid = ? AND item = ?',{price, candyshopid, item})
        end)
    end
end)

---------------------------------------------
-- buy item amount / add money to account
---------------------------------------------
RegisterNetEvent('ds-candyshop:server:buyitem', function(amount, item, candyshopid)
    local src = source

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if amount <= 0 then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_invalid_amount'), type = 'error', duration = 7000 })
        return
    end

    -- Get stock data / verify existence
    local result = MySQL.query.await('SELECT id, stock, price FROM ds_candyshop_stock WHERE candyshopid = ? AND item = ?', {candyshopid, item})
    if not result[1] then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_stock_not_found'), type = 'error', duration = 7000 })
        return
    end
    local stockId = result[1].id
    local stockPrice = result[1].price
    local stockAmount = result[1].stock

    -- Verify stock amount
    if stockAmount < amount then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('Not enough in stock'), type = 'error', duration = 7000 })
        return
    end

    -- Verify player money
    local money = Player.PlayerData.money[Config.Money]
    local totalcost = (stockPrice * amount)
    if money < totalcost then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_1')..Config.Money, type = 'error', duration = 7000 })
        return
    end

    -- Sell item to player and update candy shop data
    if Player.Functions.AddItem(item, amount) then
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'add', amount)
        Player.Functions.RemoveMoney(Config.Money, totalcost)
        
        -- Update candy shop money
        MySQL.query('SELECT * FROM ds_candyshop WHERE candyshopid = ?', { candyshopid }, function(data2)
            local moneyupdate = (data2[1].money + totalcost)
            MySQL.update('UPDATE ds_candyshop SET money = ? WHERE candyshopid = ?',{moneyupdate, candyshopid})
        end)

        -- Update candy shop item
        local newStockAmount = stockAmount - amount
        if newStockAmount > 0 then
            MySQL.update('UPDATE ds_candyshop_stock SET stock = ? WHERE id = ?', { newStockAmount, stockId })
        else
            print('delete item from stock, id of stock', stockId)
            MySQL.Async.execute('DELETE FROM ds_candyshop_stock WHERE id = ?', { stockId })
        end
    end
end)

---------------------------------------------
-- remove stock item
---------------------------------------------
RegisterNetEvent('ds-candyshop:server:removestockitem', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if not isPlayerCandyshopWorker(src, data.candyshopid) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_not_candyshop_worker'), type = 'error', duration = 7000 })
        return
    end

    MySQL.query('SELECT * FROM ds_candyshop_stock WHERE candyshopid = ? AND item = ?', { data.candyshopid, data.item }, function(result)
        if Player.Functions.AddItem(result[1].item, result[1].stock) then
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[result[1].item], 'add', result[1].stock)
        end
        MySQL.Async.execute('DELETE FROM ds_candyshop_stock WHERE id = ?', { result[1].id })
    end)
end)

---------------------------------------------
-- get money
---------------------------------------------
RSGCore.Functions.CreateCallback('ds-candyshop:server:getmoney', function(source, cb, candyshopid)
    MySQL.query('SELECT * FROM ds_candyshop WHERE candyshopid = ?', { candyshopid }, function(result)
        if result[1] then
            cb(result[1])
        else
            cb(nil)
        end
    end)
end)

---------------------------------------------
-- withdraw money
---------------------------------------------
RegisterNetEvent('ds-candyshop:server:withdrawfunds', function(amount, candyshopid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if not isPlayerCandyshopOwner(src, candyshopid) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_not_candyshop_owner'), type = 'error', duration = 7000 })
        return
    end

    MySQL.query('SELECT * FROM ds_candyshop WHERE candyshopid = ?', {candyshopid} , function(result)
        if result[1] ~= nil then
            if result[1].money >= amount then
                local updatemoney = (result[1].money - amount)
                MySQL.update('UPDATE ds_candyshop SET money = ? WHERE candyshopid = ?', { updatemoney, candyshopid })
                Player.Functions.AddMoney(Config.Money, amount)
            end
        end
    end)
end)

---------------------------------------------
-- rent candy shop
---------------------------------------------
RegisterNetEvent('ds-candyshop:server:rentcandyshop', function(candyshopid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local money = Player.PlayerData.money[Config.Money]
    local citizenid = Player.PlayerData.citizenid

    local candyshopData = MySQL.query.await('SELECT * FROM ds_candyshop WHERE candyshopid = ?', { candyshopid })[1]
    if not candyshopData then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('invalid_candyshop'), type = 'error', duration = 7000 })
        return 
    end
    if candyshopData.owner ~= 'vacant' then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('candyshop_already_rented'), type = 'error', duration = 7000 })
        return
    end

    if money > Config.RentStartup then
        if countOwnedCandyshops(src) >= Config.MaxCandyshops then
            TriggerClientEvent('ox_lib:notify', src, {title = locale('cl_lang_48'), description = locale('cl_lang_49'), type = 'error', duration = 7000 })
            return
        end

        Player.Functions.RemoveMoney(Config.Money, Config.RentStartup)
        Player.Functions.SetJob(candyshopid, 2)
        if Config.LicenseRequired then
            Player.Functions.RemoveItem('candyshoplicence', 1)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['candyshoplicence'], 'remove', 1)
        end
        MySQL.update('UPDATE ds_candyshop SET owner = ? WHERE candyshopid = ?',{ citizenid, candyshopid })
        MySQL.update('UPDATE ds_candyshop SET rent = ? WHERE candyshopid = ?',{ Config.RentStartup, candyshopid })
        MySQL.update('UPDATE ds_candyshop SET status = ? WHERE candyshopid = ?', {'open', candyshopid})
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_2'), type = 'success', duration = 7000 })
    else
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_3'), type = 'error', duration = 7000 })
    end
end)

---------------------------------------------
-- add candy shop rent
---------------------------------------------
RegisterNetEvent('ds-candyshop:server:addrentmoney', function(rentmoney, candyshopid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if not isPlayerCandyshopWorker(src, candyshopid) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_not_candyshop_worker'), type = 'error', duration = 7000 })
        return
    end

    MySQL.query('SELECT * FROM ds_candyshop WHERE candyshopid = ?', { candyshopid }, function(result)
        local currentrent = result[1].rent
        local rentupdate = (currentrent + rentmoney)
        if rentupdate >= Config.MaxRent then
            TriggerClientEvent('ox_lib:notify', src, {title = 'Can\'t add that much rent!', type = 'error', duration = 7000 })
        else
            if Player.Functions.RemoveMoney(Config.Money, rentmoney) then
                MySQL.update('UPDATE ds_candyshop SET rent = ? WHERE candyshopid = ?',{ rentupdate, candyshopid })
                MySQL.update('UPDATE ds_candyshop SET status = ? WHERE candyshopid = ?', {'open', candyshopid})
                TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_4'), type = 'success', duration = 7000 })
            else
                TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_not_enough_money'), type = 'error', duration = 7000 })
            end
        end
    end)
end)

---------------------------------------------
-- check player has the ingredients
---------------------------------------------
local function hasIngredients(src, ingredients)
    local icheck = 0
    for k, v in pairs(ingredients) do
        if exports['rsg-inventory']:GetItemCount(src, v.item) < v.amount then
            return false
        end
    end
    return true
end

RSGCore.Functions.CreateCallback('ds-candyshop:server:checkingredients', function(source, cb, ingredients)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if hasIngredients(src, ingredients) then
        cb(true)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_5'), type = 'error', duration = 7000 })
        cb(false)
    end
end)

---------------------------------------------
-- finish crafting / give item
---------------------------------------------
RegisterNetEvent('ds-candyshop:server:finishcrafting', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local receive = data.receive
    local giveamount = data.giveamount

    if not hasIngredients(src, data.ingredients) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_lang_5'), type = 'error', duration = 7000 })
        return
    end

    for k, v in pairs(data.ingredients) do
        Player.Functions.RemoveItem(v.item, v.amount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[v.item], 'remove', v.amount)
    end
    -- Remove BPC if present
    if data.bpc then
        local bpcCount = exports['rsg-inventory']:GetItemCount(src, data.bpc)
        if bpcCount > 0 then
            Player.Functions.RemoveItem(data.bpc, 1)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[data.bpc], 'remove', 1)
        end
    end
    Player.Functions.AddItem(receive, giveamount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[receive], 'add', giveamount)
        -- Add reputation for crafting using j-reputations export
        exports['j-reputations']:addrep('candyshop', 1, src)
end)

---------------------------------
-- open candy shop bartray storage
---------------------------------
RegisterServerEvent('ds-candyshop:server:storagebartray', function(candyshopid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local data = { label = 'Candy Shop Display', maxweight = Config.BarTrayMaxWeight, slots = Config.BarTrayMaxSlots }
    local stashName = 'bartray_'.. candyshopid
    exports['rsg-inventory']:OpenInventory(src, stashName, data)
end)

---------------------------------
-- open candy making storage
---------------------------------
RegisterServerEvent('ds-candyshop:server:storagecandymaking', function(candyshopid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if not isPlayerCandyshopWorker(src, candyshopid) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_not_candyshop_worker'), type = 'error', duration = 7000 })
        return
    end

    local data = { label = 'Candy Making Station', maxweight = Config.CandyMakingMaxWeight, slots = Config.CandyMakingMaxSlots }
    local stashName = 'candymaking_'.. candyshopid
    exports['rsg-inventory']:OpenInventory(src, stashName, data)
end)

---------------------------------
-- open stock storage
---------------------------------
RegisterServerEvent('ds-candyshop:server:storagestock', function(candyshopid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if not isPlayerCandyshopWorker(src, candyshopid) then
        TriggerClientEvent('ox_lib:notify', src, {title = locale('sv_not_candyshop_worker'), type = 'error', duration = 7000 })
        return
    end

    local data = { label = 'Candy Shop Stock', maxweight = Config.StockMaxWeight, slots = Config.StockMaxSlots }
    local stashName = 'stock_'.. candyshopid
    exports['rsg-inventory']:OpenInventory(src, stashName, data)
end)

---------------------------------------------
-- candy shop rent system
---------------------------------------------
lib.cron.new(Config.CandyshopCronJob, function ()

    if not Config.EnableRentSystem then
        print(locale('sv_lang_11'))
        return
    end

    local result = MySQL.query.await('SELECT * FROM ds_candyshop')

    if not result then goto continue end

    for i = 1, #result do

        local candyshopid = result[i].candyshopid
        local owner = result[i].owner
        local rent = result[i].rent
        local money = result[i].money

        if rent >= 1 then
            local moneyupdate = (rent - Config.RentPerHour)
            MySQL.update('UPDATE ds_candyshop SET rent = ? WHERE candyshopid = ?', {moneyupdate, candyshopid})
            MySQL.update('UPDATE ds_candyshop SET status = ? WHERE candyshopid = ?', {'open', candyshopid})
        else
            MySQL.update('UPDATE ds_candyshop SET status = ? WHERE candyshopid = ?', {'closed', candyshopid})
        end

    end

    ::continue::

    if Config.ServerNotify then
        print(locale('sv_lang_6'))
    end

end)