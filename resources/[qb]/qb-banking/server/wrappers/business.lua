businessAccounts = {}
currentAccounts = {}
savingsAccounts = {}
gangAccounts = {}
bankCards = {}

function GeneratebusinessAccount(acc, sc, bid)
    local self = {}
    self.accountNumber = tonumber(acc)
    self.sortCode = tonumber(sc)
    self.bid = bid

    local bankAccount = MySQL.query.await('SELECT * FROM bank_accounts WHERE account_number = ? AND sort_code = ? AND businessid = ?', { self.accountNumber, self.sortCode, self.bid })
    if bankAccount[1] ~= nil then
        self.account_id = bankAccount[1].record_id
        self.balance = bankAccount[1].amount
        self.account_type = "business"
        self.account_for = bankAccount[1].business
        if self.account_for == "realestate" then
            self.account_name = "Real Estates"
        elseif self.account_for == "police" then
            self.account_name = "Police"
        elseif self.account_for == "ems" then
            self.account_name = "EMS Medical Services"
        elseif self.account_for == "taxi" then
            self.account_name = "Taxi Services"
        elseif self.account_for == "cardealer" then
            self.account_name = "Car Dealership"
        end
    end

    self.saveAccount = function()
        MySQL.update('UPDATE `bank_accounts` SET `amount` = ? WHERE `record_id` = ?', { self.balance, self.account_id })
    end

    local rTable = {}

    rTable.getName = function()
        return self.account_name
    end

    rTable.getType = function()
        return self.account_type
    end

    rTable.getEntity = function()
        return self.account_for
    end

    rTable.getBalance = function()
        return self.balance
    end

    rTable.getBankDetails = function()
        return { ['number'] = self.accountNumber, ['sortcode'] = self.sortCode }
    end

    rTable.getBankStatement = function(limit)
        local resLimit = limit or 30
        local res = MySQL.query.await('SELECT * FROM `bank_statements` WHERE `account` = "business" AND `business` = ? AND `account_number` = ? AND `sort_code` = ? AND `businessid` = ? LIMIT ?', {
            bankAccount[1].business,
            self.accountNumber,
            self.sortCode,
            self.bid,
            resLimit
        })
        return res
    end

    -- Update Functions

    rTable.deductBalance = function(amt, text)
        if type(amt) == "number" and text then
            if amt <= self.balance then
                self.balance = self.balance - amt
                MySQL.insert('INSERT INTO `bank_statements` (`account`, `business`, `businessid`, `account_number`, `sort_code`, `withdraw`, `balance`, `type`) VALUES(?, ?, ?, ?, ?, ?, ?, ?)', {
                    'business',
                    self.account_for,
                    self.bid,
                    self.accountNumber,
                    self.sortCode,
                    amt,
                    self.balance,
                    text
                }, function(inserted)
                    if inserted > 0 then
                        self.saveAccount()
                    end
                end)
            end
        end
    end

    rTable.addBalance = function(amt, text)
        if type(amt) == "number" and text then
            self.balance = self.balance + amt
            MySQL.insert('INSERT INTO `bank_statements` (`account`, `business`, `businessid`, `account_number`, `sort_code`, `deposited`, `balance`, `type`) VALUES(?, ?, ?, ?, ?, ?, ?, ?)', {
                'business',
                self.account_for,
                self.bid,
                self.accountNumber,
                self.sortCode,
                amt,
                self.balance,
                text
            }, function(inserted)
                if inserted > 0 then
                    self.saveAccount()
                end
            end)
        end
    end

    rTable.payWages = function()
        -- Need to look into making at some point.Bala
    end

    return rTable
end

-------------------------------------
--- CREATE A NEW business ACCOUNT ---
-------------------------------------

local function createbusinessAccount(accttype, bid, startingBalance)
    if businessAccounts[accttype] == nil then
        businessAccounts[accttype] = {}
    end

    local newBalance = tonumber(startingBalance) or 1000000
    local checkExists = MySQL.query.await('SELECT * FROM `bank_accounts` WHERE `business` = ? AND `businessid` = ?', { accttype, bid })
    if checkExists[1] == nil then
        local sc = math.random(100000,999999)
        local acct = math.random(10000000,99999999)
        MySQL.insert('INSERT INTO `bank_accounts` (`business`, `businessid`, `account_number`, `sort_code`, `amount`, `account_type`) VALUES (?, ?, ?, ?, ?, ?)', {
            accttype,
            bid,
            acct,
            sc,
            newBalance,
            'business'
        },
        function(success)
            if success > 0 then
                businessAccounts[accttype][tonumber(bid)] = GeneratebusinessAccount(acct, sc, bid)
            end
        end)
    end
end

exports('createbusinessAccount', function(accttype, bid, startingbalance)
    createbusinessAccount(accttype, bid, startingbalance)
end)
