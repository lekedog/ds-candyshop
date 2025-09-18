# DS-CandyShop
A candy shop job system based on rex-saloon, adapted for confectionery operations in RedM servers.

## Features
- 9 candy shop locations across the map
- Extensive candy crafting system with multiple categories:
  - Basic Candies (Hard Milk Candys)
  - Hard Candies (Peppermint, Lemon Drops, Candycanes)
  - Soft Candies (Taffy)
  - Chocolate Candies (Chocolate Bars)
  - Specialty Treats (Candy Apples)
- Stock management system
- Employee hierarchy (Apprentice, Candy Maker, Shop Owner)
- Optional rent system
- Storage systems for ingredients and finished products
- Boss menu integration

## Dependencies
- rsg-core
- rsg-multijob
- ox_lib
- ox_target
- rsg-inventory

## Installation
1. Ensure that the dependencies are added and started
2. Add ds-candyshop to your resources folder
3. Add ds-candyshop.sql to your database
4. Add items from shared_items.lua to your rsg-core\shared\items.lua
5. Add images to your rsg-inventory\html\images (you'll need to create candy-themed images)
6. Add jobs from shared_jobs.lua to your rsg-core\shared\jobs.lua

## Starting the Resource
Add the following to your server.cfg file:
```
ensure ds-candyshop
```

## Candy Shop Locations
- Valentine Candy Shop
- Blackwater Candy Shop  
- Rhodes Candy Shop
- Saint Denis Candy Shop
- Strawberry Candy Shop
- Old Light Candy Shop
- Armadillo Candy Shop
- Tumbleweed Candy Shop
- Guarma Candy Shop

## Crafting Categories
The candy shop features an extensive crafting system with ingredients like sugar, chocolate, corn syrup, various extracts and flavorings. Players can create everything from simple hard candys to complex chocolate candy bars and specialty candy apples.

## Configuration
Edit the config.lua file to customize:
- Keybinds
- Storage weights and slots
- Rent system settings
- Candy shop locations
- Crafting recipes and times

## Notes
You will need your own IMAGES
