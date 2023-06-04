-- Add translations by MC
local Translations = {
    headers = {
        ['bsm'] = 'Boss Menu - ',
    },
    body = {
        ['manage'] = 'Manage Employees',
        ['managed'] = 'Check your Employees List',
        ['hire'] = 'Hire Employees',
        ['hired'] = 'Hire Nearby Civilians',
        ['storage'] = 'Storage Access',
        ['storaged'] = 'Open Storage',
        ['outfits'] = 'Outfits',
        ['outfitsd'] = 'See Saved Outfits',
        ['money'] = 'Money Management',
        ['moneyd'] = 'Check your Company Balance',
        ['mempl'] = 'Manage Employees - ',
        ['mngpl'] = 'Manage ',
        ['grade'] = 'Grade: ',
        ['fireemp'] = 'Fire Employee',
        ['hireemp'] = 'Hire Employees - ',
        ['cid'] = 'Citizen ID: ',
        ['balance'] = 'Balance: $',
        ['deposit'] = 'Deposit',
        ['depositd'] = 'Deposit Money into account',
        ['withdraw'] = 'Withdraw',
        ['withdrawd'] = 'Withdraw Money from account',
        ['depositm'] = 'Deposit Money <br> Available Balance: $',
        ['withdrawm'] = 'Withdraw Money <br> Available Balance: $',
        ['submit'] = 'Confirm',
        ['amount'] = 'Amount',
        ['return'] = 'Return',
        ['exit'] = 'Return',
    },
    drawtext = {
        ['label'] = '[E] Open Job Management',
    },
    target = {
        ['label'] = 'Boss Menu',
    },
    headersgang = {
        ['bsm'] = 'Gang Management  - ',
    },
    bodygang = {
        ['manage'] = 'Manage Gang Members',
        ['managed'] = 'Recruit or Fire Gang Members',
        ['hire'] = 'Recruit Members',
        ['hired'] = 'Hire Gang Members',
        ['storage'] = 'Storage Access',
        ['storaged'] = 'Open Gang Stash',
        ['outfits'] = 'Outfits',
        ['outfitsd'] = 'Change Clothes',
        ['money'] = 'Money Management',
        ['moneyd'] = 'Check your Gang Balance',
        ['mempl'] = 'Manage Gang Members - ',
        ['mngpl'] = 'Manage ',
        ['grade'] = 'Grade: ',
        ['fireemp'] = 'Fire',
        ['hireemp'] = 'Hire Gang Members - ',
        ['cid'] = 'Citizen ID: ',
        ['balance'] = 'Balance: $',
        ['deposit'] = 'Deposit',
        ['depositd'] = 'Deposit Money into account',
        ['withdraw'] = 'Withdraw',
        ['withdrawd'] = 'Withdraw Money from account',
        ['depositm'] = 'Deposit Money <br> Available Balance: $',
        ['withdrawm'] = 'Withdraw Money <br> Available Balance: $',
        ['submit'] = 'Confirm',
        ['amount'] = 'Amount',
        ['return'] = 'Return',
        ['exit'] = 'Exit',
    },
    drawtextgang = {
        ['label'] = '[E] Open Gang Management',
    },
    targetgang = {
        ['label'] = 'Gang Menu',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
