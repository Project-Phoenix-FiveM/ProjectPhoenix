# Dependencies

- [qb-target](https://github.com/BerkieBb/qb-target)
- [keep-menu](https://github.com/swkeep/keep-menu) -- recommended menu
- it supports 'qb-menu' too

# Preview

- [video](https://youtu.be/1MbqnIDTAO0)

## Installation

- if you are using qb-menu and don't want to use keep-menu :(
- set Confing.menu to 'qb-menu'

## Step 0:

- import sql.sql in your database
- make sure keep-menu is already installed
- ensure keep-paycheck after qb-core and keep-menu
- make sure scirpt's name is correct (keep-paycheck)

```
ensure qb-core
...
ensure keep-menu
...
ensure keep-paycheck
```

## Step 1 (Redirect qb-core's paychecks to scirpt):

- edit qb-core/server/functions.lua (make sure you already have a backup of this file)
- replace code at PaycheckInterval() to

```lua
function PaycheckInterval()
    if next(QBCore.Players) then
        for _, Player in pairs(QBCore.Players) do
            if Player then
                local payment = Player.PlayerData.job.payment
                local citizenid = Player.PlayerData.citizenid

                if Player.PlayerData.job and payment > 0 and (QBShared.Jobs[Player.PlayerData.job.name].offDutyPay or Player.PlayerData.job.onduty) then
                    if QBCore.Config.Money.PayCheckSociety then
                        local account = exports['qb-management']:GetAccount(Player.PlayerData.job.name)
                        if account ~= 0 then -- Checks if player is employed by a society
                            if account < payment then -- Checks if company has enough money to pay society
                                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('error.company_too_poor'), 'error')
                            else
                                TriggerEvent('keep-paycheck:server:AddMoneyToPayCheck', citizenid,payment,Player.PlayerData.job.name)
                                exports['qb-management']:RemoveMoney(Player.PlayerData.job.name, payment)
                            end
                        else
                            TriggerEvent('keep-paycheck:server:AddMoneyToPayCheck', citizenid,payment,Player.PlayerData.job.name)
                        end
                    else
                        TriggerEvent('keep-paycheck:server:AddMoneyToPayCheck', citizenid,payment,Player.PlayerData.job.name)
                    end
                end
            end
        end
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckInterval)
end
```

## Redirect external scirpts payment method to keep-paycheck

- to redirect their payments first find all AddMoney functions that resposible for payments.

```lua
Player.Functions.AddMoney('cash/bank', amount)
```

- then replace them with keep-paycheck payment event

```lua
local payment = money -- how much money player should recive in their accounts
local citizenid = Player.PlayerData.citizenid
local from = Player.PlayerData.job.name -- job name / shown as 'from' in transaction history

TriggerEvent('keep-paycheck:server:AddMoneyToPayCheck', citizenid, payment , from)
```
