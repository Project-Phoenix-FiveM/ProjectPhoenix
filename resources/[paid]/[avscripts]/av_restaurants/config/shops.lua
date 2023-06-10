-- Config for ingredients shop
Config.Account = 'bank' -- Account used to buy ingredients
Config.PedModel = `s_m_y_chef_01`
Config.NPCSpawn = {-2964.24, 432.17, 14.28, 87.08} -- x, y, z, heading
Config.BlipIcon = 478
Config.BlipScale = 0.8
Config.BlipColor = 3
Config.IngredientsPerPurchase = 40
Config.ShopItems = {
    ['ingredients'] = {label = "Ingredients", price = 40}, -- ['item_name'] = price
}
Config.ExtraIngredients = { -- Based on the restaurant rating it will give extra ingredients on purchase
    ["0"] = 0,
    ["1"] = math.random(1,3),
    ["2"] = math.random(3,5),
    ["3"] = math.random(5,8),
    ["4"] = math.random(8,10),
    ["5"] = math.random(10,15),
}
