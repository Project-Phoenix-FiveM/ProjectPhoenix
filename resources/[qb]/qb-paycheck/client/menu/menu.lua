------------------
--   Const
local QBCore = exports['qb-core']:GetCoreObject()

--   Variable
local menu = {}
local QbMenu = {}
------------------
local function Open_menu(data)
     if Config.menu == 'qb-menu' then
          menu:withdraw_menu(data)
          return
     end
     QbMenu:withdraw_menu(data)
end

AddEventHandler('qb-paycheck:menu:Open_menu', function()
     QBCore.Functions.TriggerCallback('qb-paycheck:server:account_information', function(result)
          if result then
               Open_menu(result)
               return
          end
          QBCore.Functions.Notify(Lang:t('error.failed_to_open_menu'), "error")
     end)
end)
------------------
--   functions
------------------
local function format_int(number)
     local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
     int = int:reverse():gsub("(%d%d%d)", "%1,")
     return minus .. int:reverse():gsub("^,", "") .. fraction
end

local function withdraw_all(maximum)
     if maximum == 0 then
          QBCore.Functions.Notify(Lang:t('info.no_money_in_account'), "primary")
          return
     end
     QBCore.Functions.TriggerCallback('qb-paycheck:server:withdraw_all', function(result, reason)
          if result then
               Speach('thanks')
               TriggerEvent('animations:client:EmoteCommandStart', { "ID" })
               QBCore.Functions.Notify(Lang:t('success.successful_withdraw') .. reason .. '$', "success")
          else
               QBCore.Functions.Notify(Lang:t('error.withdraw_failed') .. reason, "error")
          end
     end)
end

local function withdraw_amount(maximum)
     if maximum == 0 then
          QBCore.Functions.Notify(Lang:t('info.no_money_in_account'), "primary")
          return
     end
     local inputData = exports['qb-input']:ShowInput({
          header = Lang:t('menu.withdraw_amount.header'),
          submitText = Lang:t('menu.withdraw_amount.submitText'),
          inputs = {
               {
                    type = 'text',
                    isRequired = true,
                    name = 'amount',
                    text = Lang:t('menu.withdraw_amount.textbox') .. maximum
               },
          }
     })
     if inputData then
          if not inputData.amount then return end
          local amount = tonumber(inputData.amount)
          if type(amount) == "string" then
               QBCore.Functions.Notify(Lang:t('error.bad_input'), "error")
               return
          end
          if not (0 < amount) then
               QBCore.Functions.Notify(Lang:t('error.money_amount_more_than_zero'), "error")
               withdraw_amount(maximum)
               return
          end

          if amount >= math.maxinteger then
               QBCore.Functions.Notify(Lang:t('error.can_not_withdraw_much') .. amount, "error")
               return
          end

          if not (amount <= maximum) and amount < math.maxinteger then
               QBCore.Functions.Notify(Lang:t('error.can_not_withdraw_much') .. amount, "error")
               withdraw_amount(maximum)
               return
          end

          QBCore.Functions.TriggerCallback('qb-paycheck:server:withdraw_amount', function(result, reason)
               if result then
                    TriggerEvent('animations:client:EmoteCommandStart', { "ID" })
                    QBCore.Functions.Notify(Lang:t('success.successful_withdraw') .. reason .. '$', "success")
                    Speach('thanks')
               else
                    QBCore.Functions.Notify(Lang:t('error.withdraw_failed') .. reason, "error")
               end
          end, inputData.amount)
     end
end

------------------
--   qb-menu
------------------

function menu:withdraw_menu(data)
     if data == nil then return end
     Speach('hi')
     TriggerEvent('animations:client:EmoteCommandStart', { "wait10" })
     local money = string.format(Lang:t('menu.withdraw_menu.money_string'), format_int(data.money))
     local Menu = {
          {
               header = Lang:t('menu.withdraw_menu.header'),
               icon = 'fa-solid fa-credit-card',
               disabled = true
          },
          {
               header = Lang:t('menu.withdraw_menu.account_Information'),
               subheader = money,
               icon = 'fa-solid fa-hand-holding-dollar',
               submenu = false,
          },
          {
               header = Lang:t('menu.withdraw_menu.withdraw_all'),
               icon = 'fa-solid fa-money-bill-transfer',
               args = { 1 },
               submenu = false,
          },
          {
               header = Lang:t('menu.withdraw_menu.withdraw_amount'),
               icon = 'fa-solid fa-arrow-up-wide-short',
               args = { 2 },
               submenu = true,
          },
          {
               header = Lang:t('menu.withdraw_menu.transaction_history'),
               icon = 'fa-solid fa-clock-rotate-left',
               args = { 3 },
               submenu = true,
          },
          {
               header = Lang:t('menu.leave'),
               event = "qb-menu:closeMenu",
               leave = true
          }
     }

     local req = exports['qb-menu']:createMenu(Menu) 

     if req == 1 then
          -- Withdraw All
          withdraw_all(data.money)
          return
     elseif req == 2 then
          -- Withdraw Amount
          withdraw_amount(data.money)
          return
     elseif req == 3 then
          TriggerEvent('animations:client:EmoteCommandStart', { "notepad" })
          QBCore.Functions.TriggerCallback('qb-paycheck:server:get_logs', function(result)
               menu:logs_menu(result)
          end)
          return
     end
     TriggerEvent('animations:client:EmoteCommandStart', { "c" })
end

function menu:logs_menu(data)
     if data == nil then return end
     Speach('whatever')

     local Menu = {
          {
               header = Lang:t('menu.logs_menu.paycheck_logs'),
               icon = 'fa-solid fa-list',
               disabled = true
          },
          {
               header = Lang:t('menu.leave'),
               event = "qb-menu:closeMenu",
               leave = true
          }
     }

     for key, transaction in pairs(data) do
          local icon = ''
          local header = ''
          local metadata = json.decode(transaction.metadata)
          local subheader = Lang:t('menu.logs_menu.before')
          local footer = Lang:t('menu.logs_menu.after')
          subheader = string.format(subheader, format_int(metadata.account.old_value))
          footer = string.format(footer, format_int(metadata.account.current_value))

          if transaction.state == true then
               header = string.format(Lang:t('menu.logs_menu.recived'), format_int(transaction.amount))
               if metadata.desc.source then
                    if metadata.desc.source.name then
                         header = header .. Lang:t('menu.logs_menu.to') .. (metadata.desc.source.name or "")
                    end
                    if metadata.desc.source.job then
                         header = header .. Lang:t('menu.logs_menu.from') .. (metadata.desc.source.job or "")
                    end
               end
               icon = "fa-solid fa-arrow-right-to-bracket"

          else
               header = string.format(Lang:t('menu.logs_menu.withdraw'), format_int(transaction.amount))
               if metadata.desc.source then
                    if metadata.desc.source.name then
                         header = header .. Lang:t('menu.logs_menu.to') .. (metadata.desc.source.name or "")
                    end
                    if metadata.desc.source.job then
                         header = header .. Lang:t('menu.logs_menu.from') .. (metadata.desc.source.job or "")
                    end
               end
               icon = "fa-solid fa-arrow-right-from-bracket"
          end

          Menu[#Menu + 1] = {
               header = header,
               subheader = subheader,
               footer = footer,
               icon = icon
          }
     end
     exports['qb-menu']:createMenu(Menu)
     TriggerEvent('animations:client:EmoteCommandStart', { "c" })
end

------------------
--   qb-menu
------------------

function QbMenu:withdraw_menu(data)
     if data == nil then return end
     Speach('hi')
     TriggerEvent('animations:client:EmoteCommandStart', { "wait10" })
     local money = string.format(Lang:t('menu.withdraw_menu.money_string'), format_int(data.money))
     local Menu = {
          {
               header = Lang:t('menu.withdraw_menu.header'),
               icon = 'fa-solid fa-credit-card',
               disabled = true
          },
          {
               header = Lang:t('menu.withdraw_menu.account_Information'),
               txt = money,
               icon = 'fa-solid fa-hand-holding-dollar',
          },
          {
               header = Lang:t('menu.withdraw_menu.withdraw_all'),
               icon = 'fa-solid fa-money-bill-transfer',
               params = {
                    event = 'qb-paycheck:client:function_caller',
                    args = { id = 1, money = data.money },
               }
          },
          {
               header = Lang:t('menu.withdraw_menu.withdraw_amount'),
               icon = 'fa-solid fa-arrow-up-wide-short',
               params = {
                    event = 'qb-paycheck:client:function_caller',
                    args = { id = 2, money = data.money },
               }
          },
          {
               header = Lang:t('menu.withdraw_menu.transaction_history'),
               icon = 'fa-solid fa-clock-rotate-left',
               params = {
                    event = 'qb-paycheck:client:function_caller',
                    args = { id = 3, money = data.money },
               }
          },
          {
               header = Lang:t('menu.leave'),
               icon = 'fa-solid fa-circle-xmark',
               params = {
                    event = "qb-paycheck:client:close_menu",
               }
          }
     }

     exports['qb-menu']:openMenu(Menu)

end

AddEventHandler('qb-paycheck:client:function_caller', function(data)
     TriggerEvent('animations:client:EmoteCommandStart', { "c" })
     if data.id == 1 then
          -- Withdraw All
          withdraw_all(data.money)
          return
     elseif data.id == 2 then
          -- Withdraw Amount
          withdraw_amount(data.money)
          return
     elseif data.id == 3 then
          QBCore.Functions.TriggerCallback('qb-paycheck:server:get_logs', function(result)
               QbMenu:logs_menu(result)
          end)
          return
     end
end)

function QbMenu:logs_menu(data)
     if data == nil then return end
     Speach('whatever')
     TriggerEvent('animations:client:EmoteCommandStart', { "notepad" })
     local Menu = {
          {
               header = Lang:t('menu.logs_menu.paycheck_logs'),
               icon = 'fa-solid fa-list',
               disabled = true
          },
          {
               header = Lang:t('menu.leave'),
               icon = 'fa-solid fa-circle-xmark',
               params = {
                    event = "qb-paycheck:client:close_menu",
               }
          }
     }

     for key, transaction in pairs(data) do
          local icon = ''
          local header = ''
          local metadata = json.decode(transaction.metadata)
          local subheader = Lang:t('menu.logs_menu.before')
          local footer = Lang:t('menu.logs_menu.after')
          subheader = string.format(subheader, format_int(metadata.account.old_value))
          footer = string.format(footer, format_int(metadata.account.current_value))

          if transaction.state == true then
               header = string.format(Lang:t('menu.logs_menu.recived'), format_int(transaction.amount))
               if metadata.desc.source then
                    if metadata.desc.source.name then
                         header = header .. Lang:t('menu.logs_menu.to') .. (metadata.desc.source.name or "")
                    end
                    if metadata.desc.source.job then
                         header = header .. Lang:t('menu.logs_menu.from') .. (metadata.desc.source.job or "")
                    end
               end
               icon = "fa-solid fa-arrow-right-to-bracket"

          else
               header = string.format(Lang:t('menu.logs_menu.withdraw'), format_int(transaction.amount))
               if metadata.desc.source then
                    if metadata.desc.source.name then
                         header = header .. Lang:t('menu.logs_menu.to') .. (metadata.desc.source.name or "")
                    end
                    if metadata.desc.source.job then
                         header = header .. Lang:t('menu.logs_menu.from') .. (metadata.desc.source.job or "")
                    end
               end
               icon = "fa-solid fa-arrow-right-from-bracket"
          end

          Menu[#Menu + 1] = {
               header = header,
               txt = subheader .. ' | ' .. footer,
               icon = icon
          }
     end
     exports['qb-menu']:openMenu(Menu)
end

AddEventHandler('qb-paycheck:client:close_menu', function()
     TriggerEvent('qb-menu:closeMenu')
end)

AddEventHandler('qb-menu:closeMenu', function()
     if not GetCurrentResourceName() == 'qb-paycheck' then
          return
     end
     TriggerEvent('animations:client:EmoteCommandStart', { "c" })
end)
