Config = {}

---------------------------------
-- settings
---------------------------------
Config.Keybind          = 'J'
Config.Img              = "rsg-inventory/html/images/"
Config.Money            = 'cash' -- 'cash', 'bank' or 'bloodmoney'
Config.ServerNotify     = true
Config.EnableRentSystem = false
Config.LicenseRequired  = false

---------------------------------
-- rent settings
---------------------------------
Config.MaxCandyshops    = 1
Config.RentStartup      = 100
Config.RentPerHour      = 1
Config.CandyshopCronJob = '0 * * * *' -- cronjob runs every hour (0 * * * *)
Config.MaxRent          = 100

---------------------------------
-- storage settings
---------------------------------
Config.BarTrayMaxWeight  = 4000000
Config.BarTrayMaxSlots   = 5
Config.CandyMakingMaxWeight = 4000000
Config.CandyMakingMaxSlots  = 48
Config.StockMaxWeight    = 4000000
Config.StockMaxSlots     = 48

---------------------------------
-- npc settings
---------------------------------
Config.DistanceSpawn = 20.0
Config.FadeIn = true

---------------------------------
-- player candy shop locations
---------------------------------
Config.PlayerCandyshopLocations = {
    -- { 
    --     name = 'Valentine Candy Shop',
    --     candyshopid = 'valcandyshop',
    --     coords = vector3(-300.34, 790.59, 118.98),
    --     npcmodel = `u_m_m_valbartender_01`,
    --     npccoords = vector4(-300.34, 790.59, 118.98, 290.68),
    --     jobaccess = 'valcandyshop',
    --     blipname = 'Valentine Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
    { 
        name = 'Blackwater Candy Shop',
        candyshopid = 'blacandyshop',
        coords = vector3(-787.3425, -1377.6573, 43.9754),
        npcmodel = `u_m_o_blwbartender_01`,
        npccoords = vector4(-787.3425, -1377.6573, 43.9754, 1.1592),
        jobaccess = 'blacandyshop',
        blipname = 'Blackwater Candy Shop',
        blipsprite = 'blip_shop',
        blipscale = 0.2,
        showblip = true
    },
    -- { 
    --     name = 'Rhodes Candy Shop',
    --     candyshopid = 'rhocandyshop',
    --     coords = vector3(1355.45, -1385.84, 80.48),
    --     npcmodel = `u_m_m_rhdbartender_01`,
    --     npccoords = vector4(1355.45, -1385.84, 80.48, 265.21),
    --     jobaccess = 'rhocandyshop',
    --     blipname = 'Rhodes Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
    -- { 
    --     name = 'Saint Denis Candy Shop',
    --     candyshopid = 'doycandyshop',
    --     coords = vector3(2807.32, -1180.81, 47.93),
    --     npcmodel = `u_m_m_nbxbartender_02`,
    --     npccoords = vector4(2807.32, -1180.81, 47.93, 246.29),
    --     jobaccess = 'doycandyshop',
    --     blipname = 'Saint Denis Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
    -- { 
    --     name = 'Strawberry Candy Shop',
    --     candyshopid = 'strcandyshop',
    --     coords = vector3(2650.81, -1235.04, 53.38),
    --     npcmodel = `u_m_m_nbxbartender_01`,
    --     npccoords = vector4(2650.81, -1235.04, 53.38, 89.88),
    --     jobaccess = 'strcandyshop',
    --     blipname = 'Strawberry Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
    -- { 
    --     name = 'Old Light Candy Shop',
    --     candyshopid = 'oldcandyshop',
    --     coords = vector3(2960.28, 540.28, 45.34),
    --     npcmodel = `u_f_m_tljbartender_01`,
    --     npccoords = vector4(2960.28, 540.28, 45.34, 95.97),
    --     jobaccess = 'oldcandyshop',
    --     blipname = 'Old Light Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
    -- { 
    --     name = 'Armadillo Candy Shop',
    --     candyshopid = 'armcandyshop',
    --     coords = vector3(-3680.80, -2580.01, -13.32),
    --     npcmodel = `u_m_o_armbartender_01`,
    --     npccoords = vector4(-3680.80, -2580.01, -13.32, 100.74),
    --     jobaccess = 'armcandyshop',
    --     blipname = 'Armadillo Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
    -- { 
    --     name = 'Tumbleweed Candy Shop',
    --     candyshopid = 'tumcandyshop',
    --     coords = vector3(-5505.07, -2895.44, -1.75),
    --     npcmodel = `u_m_m_tumbartender_01`,
    --     npccoords = vector4(-5505.07, -2895.44, -1.75, 222.65),
    --     jobaccess = 'tumcandyshop',
    --     blipname = 'Tumbleweed Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
    -- {
    --     name = 'Guarma Candy Shop',
    --     candyshopid = 'guarcandyshop',
    --     coords = vector3(1310.2455, -6820.7627, 43.6372),
    --     npcmodel = `msp_guarma2_males_01`,
    --     npccoords = vector4(1310.2455, -6820.7627, 43.6372, 154.3169),
    --     jobaccess = 'guarcandyshop',
    --     blipname = 'Guarma Candy Shop',
    --     blipsprite = 'blip_shop',
    --     blipscale = 0.2,
    --     showblip = true
    -- },
}

---------------------------------
-- candy shop crafting
---------------------------------
Config.CandyshopCrafting = {
    -- simple candies
    {
        title =  'Hard Milk Candy',
        category = 'Basic Candies',
        crafttime = 5000,
        craftingxp = 0,
        ingredients = {
            [1] = { item = 'consumable_sugarcube', amount = 2 },
            [2] = { item = 'consumable_milk', amount = 1 },
            [3] = { item = 'skillet', amount = 1, consume = false },
        },
        receive = 'consumable_candy_hard_milk',
        giveamount = 1
    },
    -- hard candies
    {
        title =  'Peppermint Candy',
        category = 'Hard Candies',
        crafttime = 10000,
        bpo = 'bpo_hard_candy',
        bpc = 'bpc_hard_candy',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 2 },
            [2] = { item = 'peppermint_oil',  amount = 1 },
            [3] = { item = 'corn_syrup',      amount = 1 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
        },
        receive = 'consumable_peppermint',
        giveamount = 1
    },
    {
        title =  'Lemon Drop',
        category = 'Hard Candies',
        crafttime = 10000,
        bpo = 'bpo_hard_candy',
        bpc = 'bpc_hard_candy',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 2 },
            [2] = { item = 'lemon',   amount = 1 },
            [3] = { item = 'corn_syrup',      amount = 1 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
        },
        receive = 'consumable_lemon_drops',
        giveamount = 1
    },
    {
        title =  'Candy Canes',
        category = 'Hard Candies',
        crafttime = 10000,
        bpo = 'bpo_hard_candy',
        bpc = 'bpc_hard_candy',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 2 },
            [2] = { item = 'consumable_spice_cinnamon_sticks',        amount = 1 },
            [3] = { item = 'corn_syrup',      amount = 1 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
        },
        receive = 'consumable_candycanes',
        giveamount = 1
    },
    -- soft candies
    {
        title =  'Blueberry Taffy',
        category = 'Soft Candies',
        crafttime = 15000,
        bpo = 'bpo_soft_candy',
        bpc = 'bpc_soft_candy',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 2 },
            [2] = { item = 'corn_syrup',      amount = 2 },
            [3] = { item = 'blueberry', amount = 1 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
            [5] = { item = 'salt', amount = 1 },
        },
        receive = 'consumable_candy_salt_water_taffy_blueberry',
        giveamount = 1
    },
    {
        title =  'Grape Taffy',
        category = 'Soft Candies',
        crafttime = 15000,
        bpo = 'bpo_soft_candy',
        bpc = 'bpc_soft_candy',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 2 },
            [2] = { item = 'corn_syrup',      amount = 2 },
            [3] = { item = 'grapes',     amount = 1 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
            [5] = { item = 'salt', amount = 1 },
        },
        receive = 'consumable_candy_salt_water_taffy_grape',
        giveamount = 1
    },
    {
        title =  'Strawberry Taffy',
        category = 'Soft Candies',
        crafttime = 15000,
        bpo = 'bpo_soft_candy',
        bpc = 'bpc_soft_candy',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 2 },
            [2] = { item = 'corn_syrup',      amount = 2 },
            [3] = { item = 'consumable_strawberry', amount = 1 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
            [5] = { item = 'salt', amount = 1 },
        },
        receive = 'consumable_candy_salt_water_taffy_strawberry',
        giveamount = 1
    },
    {
        title =  'Green Apple Taffy',
        category = 'Soft Candies',
        crafttime = 15000,
        bpo = 'bpo_soft_candy',
        bpc = 'bpc_soft_candy',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 2 },
            [2] = { item = 'corn_syrup',      amount = 2 },
            [3] = { item = 'consumable_apple', amount = 1 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
            [5] = { item = 'salt', amount = 1 },
        },
        receive = 'consumable_candy_salt_water_taffy_pear',
        giveamount = 1
    },
    -- sugar wafers
    {
        title =  'Chocolate Sugar Wafer',
        category = 'Wafers',
        crafttime = 20000,
        bpo = 'bpo_wafers',
        bpc = 'bpc_wafers',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 3 },
            [2] = { item = 'consumable_chef_butter',          amount = 2 },
            [3] = { item = 'consumable_chef_cream',           amount = 1 },
            [4] = { item = 'consumable_chocolate',       amount = 2 },
            [5] = { item = 'consumable_candy_bag',   amount = 1 },
        },
        receive = 'consumable_sugar_wafer_chocolate',
        giveamount = 1
    },
    {
        title =  'Strawberry Sugar Wafer',
        category = 'Wafers',
        crafttime = 20000,
        bpo = 'bpo_wafers',
        bpc = 'bpc_wafers',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 3 },
            [2] = { item = 'consumable_chef_butter',          amount = 2 },
            [3] = { item = 'consumable_chef_cream',           amount = 1 },
            [4] = { item = 'consumable_strawberry',   amount = 2 },
            [5] = { item = 'consumable_candy_bag',   amount = 1 },
        },
        receive = 'consumable_sugar_wafer_strawberry',
        giveamount = 1
    },
    {
        title =  'Vanilla Sugar Wafer',
        category = 'Wafers',
        crafttime = 20000,
        bpo = 'bpo_wafers',
        bpc = 'bpc_wafers',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_sugarcube',           amount = 3 },
            [2] = { item = 'consumable_chef_butter',          amount = 2 },
            [3] = { item = 'consumable_chef_cream',           amount = 1 },
            [4] = { item = 'vanilla_extract',   amount = 2 },
            [5] = { item = 'consumable_candy_bag',   amount = 1 },
        },
        receive = 'consumable_sugar_wafer_vanilla',
        giveamount = 1
    },
    -- chocolate candies
    {
        title =  'Chocolate Bar',
        category = 'Chocolate Candies',
        crafttime = 12000,
        bpo = 'bpo_chocolate',
        bpc = 'bpc_chocolate',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_chocolate',       amount = 4 },
            [2] = { item = 'consumable_sugarcube',           amount = 1 },
            [3] = { item = 'consumable_candy_bag',   amount = 1 },
            [4] = { item = 'consumable_honey_comb',   amount = 1 },
        },
        receive = 'consumable_honeycomb_candy',
        giveamount = 1
    },
    -- specialty treats
    {   
        title =  'Candy Apple',
        category = 'Specialty Treats',
        crafttime = 20000,
        bpo = 'bpo_specialty',
        bpc = 'bpc_specialty',
        craftingxp = 0,
        ingredients = { 
            [1] = { item = 'consumable_apple',           amount = 1 },
            [2] = { item = 'consumable_sugarcube',           amount = 3 },
            [3] = { item = 'corn_syrup',      amount = 2 },
            [4] = { item = 'consumable_candy_bag',   amount = 1 },
            [5] = { item = 'lumber_sticks',    amount = 1 },
        },
        receive = 'consumable_apple_candy',
        giveamount = 1
    },

    ---------------------------------------------------------
    -- packing list
    ---------------------------------------------------------
    -- {   
    --     title =  'Packing consumable_sugarcube',
    --     category = 'Packing',
    --     crafttime = 15000,
    --     bpo = 'bpo_packing',
    --     bpc = 'bpc_packing',
    --     craftingxp = 0,
    --     ingredients = { 
    --         [1] = { item = 'consumable_sugarcube',               amount = 30 },
    --         [2] = { item = "burlap_sack",         amount = 1 },
    --     },
    --     receive = 'resource_bag_consumable_sugarcube',
    --     giveamount = 1
    -- },
    -- {
    --     title =  'Packing Chocolate',
    --     category = 'Packing',
    --     crafttime = 15000,
    --     bpo = 'bpo_packing',
    --     bpc = 'bpc_packing',
    --     craftingxp = 0,
    --     ingredients = { 
    --         [1] = { item = 'consumable_chocolate',           amount = 30 },
    --         [2] = { item = "burlap_sack",         amount = 1 },
    --     },
    --     receive = 'resource_bag_chocolate',
    --     giveamount = 1
    -- },
    -- ---------------------------------------------------------
    -- -- unpacking list
    -- ---------------------------------------------------------
    -- {
    --     title =  'Unpacking consumable_sugarcube',
    --     category = 'Unpacking',
    --     crafttime = 15000,
    --     bpo = 'bpo_unpacking',
    --     bpc = 'bpc_unpacking',
    --     craftingxp = 0,
    --     ingredients = { 
    --         [1] = { item = 'resource_bag_consumable_sugarcube',  amount = 1 },
    --     },
    --     receive = 'consumable_sugarcube',
    --     giveamount = 30
    -- },
    -- {
    --     title =  'Unpacking Chocolate',
    --     category = 'Unpacking',
    --     crafttime = 15000,
    --     bpo = 'bpo_unpacking',
    --     bpc = 'bpc_unpacking',
    --     craftingxp = 0,
    --     ingredients = { 
    --         [1] = { item = 'resource_bag_chocolate', amount = 1 },
    --     },
    --     receive = 'chocolate',
    --     giveamount = 30
    -- },    
}