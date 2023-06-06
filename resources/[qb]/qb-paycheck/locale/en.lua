local Translations = {
     error = {
          failed_to_open_menu = 'Failed to open menu',
          withdraw_failed = 'withdraw failed:',
          bad_input = 'Bad input',
          money_amount_more_than_zero = 'Money amount should be more than 0',
          can_not_withdraw_much = 'can not withdraw that much: '
     },
     success = {
          successful_withdraw = 'withdraw was successful: '
     },
     info = {
          no_money_in_account = 'No money in in your account'
     },
     mail = {

     },
     menu = {
          back = 'Back',
          leave = 'Leave',

          -- qb-target
          qb_target_label = 'PayCheck',

          -- qb-input / withdraw amount
          withdraw_amount = {
               header = 'Money Amount',
               submitText = 'withdraw',
               textbox = 'maximum: '
          },
          -- withdraw_menu
          withdraw_menu = {
               header = 'Bank (Paycheck)',
               account_Information = 'Account Information',
               withdraw_all = 'Withdraw All',
               withdraw_amount = 'Withdraw Amount',
               transaction_history = 'Transaction History',
               money_string = 'Money: %s$'
          },

          -- logs_menu
          logs_menu = {
               paycheck_logs = 'Paycheck Logs',
               before = 'Before : %s$',
               after = 'After : %s$',
               recived = 'Recived %s$',
               withdraw = 'Withdraw %s$',
               to = ' | to: ',
               from = ' | from: '
          }
     }
}

Lang = Locale:new({
     phrases = Translations,
     warnOnMissing = true
})
