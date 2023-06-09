local QBCore = exports['qb-core']:GetCoreObject()

local function logger(citizenid, state, amount, metadata)
     local query = 'INSERT INTO paycheck_logs (citizenid, state, amount, metadata) VALUES (:citizenid, :state, :amount, :metadata)'
     local data = {
          ['citizenid'] = citizenid,
          ['state'] = state,
          ['amount'] = amount,
          ['metadata'] = json.encode(metadata),
     }
     MySQL.Async.insert(query, data)
end

local function init_account(citizenid, amount)
     local query = 'INSERT INTO paycheck_account (citizenid, money) VALUES (:citizenid, :money) ON DUPLICATE KEY UPDATE money = :money'
     local data = {
          ['citizenid'] = citizenid,
          ['money'] = amount,
     }
     MySQL.Async.insert(query, data)
end

local function update_money(citizenid, amount)
     MySQL.Async.execute('UPDATE `paycheck_account` SET `money` = ? WHERE `citizenid` = ?',
          { amount, citizenid }, function(Changed)
          if Changed == 1 then

          end
     end)
end

local function withdraw(Player, citizenid, res, amount)
     if not type(res[1].money) == "number" then
          -- sanity check money
          update_money(citizenid, 0)
          return false, 'money type in not a number'
     end

     if res[1].money == 0 then
          -- no money
          return false, 'no money in account'
     end

     if res[1].money < 0 then
          update_money(citizenid, 0)
          return false, 'minus money value'
     end

     -- have money
     local remaining = math.floor(res[1].money - amount)
     if not (remaining >= 0) then
          return false, 'minus remaining'
     end

     update_money(citizenid, remaining)
     Player.Functions.AddMoney('cash', amount)
     logger(citizenid, 0, amount, {
          desc = {
               type = 'to',
               source = {
                    citizenid = citizenid,
                    name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
               }
          },
          account = {
               old_value = res[1].money,
               current_value = remaining
          }
     })
     return true, amount
end

local function addmoney_to_paycheck(citizenid, amount, job)
     if not (amount >= 0 and amount <= math.maxinteger) then return end

     MySQL.Async.fetchAll('SELECT * FROM paycheck_account WHERE citizenid = ?', { citizenid }, function(res)
          local m = 0
          if not next(res) then
               init_account(citizenid, amount)
               if not res[1] then
                    m = 0
               else
                    m = res[1].money
               end
               logger(citizenid, 1, amount, {
                    desc = {
                         type = 'from',
                         source = {
                              job = job or 'unknown'
                         }
                    },
                    account = {
                         old_value = m,
                         current_value = amount
                    }
               })
               return
          end
          local money = math.floor(amount + res[1].money)
          update_money(citizenid, money)
          logger(citizenid, 1, amount, {
               desc = {
                    type = 'from',
                    source = {
                         job = job or 'unknown'
                    }
               },
               account = {
                    old_value = res[1].money,
                    current_value = money
               }
          })
     end)
end

RegisterNetEvent('qb-paycheck:server:AddMoneyToPayCheck', function(citizenid, amount, from)
     addmoney_to_paycheck(citizenid, amount, from)
end)

QBCore.Functions.CreateCallback('qb-paycheck:server:account_information', function(source, cb)
     local Player = QBCore.Functions.GetPlayer(source)
     local citizenid = Player.PlayerData.citizenid

     MySQL.Async.fetchAll('SELECT * FROM paycheck_account WHERE citizenid = ?', { citizenid }, function(res)
          local data = {
               money = 0
          }
          if not next(res) then
               init_account(citizenid, 0)
               cb(data)
               return
          end
          data.money = res[1].money
          cb(data)
     end)
end)

QBCore.Functions.CreateCallback('qb-paycheck:server:withdraw_all', function(source, cb)
     local Player = QBCore.Functions.GetPlayer(source)
     local citizenid = Player.PlayerData.citizenid

     MySQL.Async.fetchAll('SELECT * FROM paycheck_account WHERE citizenid = ?', { citizenid }, function(res)
          if not next(res) then cb(false) return end
          local state, reason = withdraw(Player, citizenid, res, res[1].money)
          cb(state, reason)
     end)
end)

QBCore.Functions.CreateCallback('qb-paycheck:server:withdraw_amount', function(source, cb, amount)
     local Player = QBCore.Functions.GetPlayer(source)
     local citizenid = Player.PlayerData.citizenid

     MySQL.Async.fetchAll('SELECT * FROM paycheck_account WHERE citizenid = ?', { citizenid }, function(res)
          if not next(res) then cb(false) return end
          local state, reason = withdraw(Player, citizenid, res, amount)
          cb(state, reason)
     end)
end)

QBCore.Functions.CreateCallback('qb-paycheck:server:get_logs', function(source, cb, limit)
     limit = limit or 10 --placeholder
     local Player = QBCore.Functions.GetPlayer(source)
     local citizenid = Player.PlayerData.citizenid
     local query = 'SELECT state, amount, metadata,created FROM paycheck_logs WHERE citizenid = ? order by created desc limit 15'
     local LOGS = MySQL.Sync.fetchAll(query, { citizenid })
     cb(LOGS)
end)
