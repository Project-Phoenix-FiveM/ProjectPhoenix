local identityMenu = {
  id = 'identity_menu',
  title = 'Select identity',
  options = {},
}

for i = 1, #Config.MenuCards, 1 do
  identityMenu.options[#identityMenu.options + 1] = {
      title = Config.MenuCards[i].title,
      icon = Config.MenuCards[i].icon,
      serverEvent = 'um-idcard-npc:server:AddItemtoExport',
      args = Config.MenuCards[i].args,
      disabled = false,
      onSelect = function()
          identityMenu.options[i].disabled = true
          lib.registerContext({identityMenu})
      end,
  }
end

lib.registerContext({identityMenu})

RegisterNetEvent('um-idcard-npc:client:OxNotify', function(itemName)
  lib.notify({title = 'Identity Menu', description = 'Your identity has been approved: ' ..itemName, icon = 'id-card'})
end)
