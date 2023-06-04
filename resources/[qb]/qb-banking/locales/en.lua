local Translations = {
    error = {
        not_give = "Could not give item to the given id.",
        givecash = "Usage /givecash [ID] [AMOUNT]",
        wrong_id = "Wrong ID.",
        dead = "You are dead LOL.",
        too_far_away = "You are too far away lmfao.",
        not_enough = "You don\'t have this amount.",
        invalid_amount = "Invalid Amount Given"
    },
    success = {
        debit_card = "You have successfully ordered a Debit Card.",
        cash_deposit = "You successfully made a cash deposit of $%{value}.",
        cash_withdrawal = "You successfully made a cash withdrawal of $%{value}.",
        updated_pin = "You have successfully updated your debit card pin.",
        savings_deposit = "You successfully made a savings deposit of $%{value}.",
        savings_withdrawal = "You successfully made a savings withdrawal of $%{value}.",
        opened_savings = "You have successfully opened a savings account.",
        give_cash = "Successfully gave $%{cash} to ID %{id}",
        received_cash = "Successfully received $%{cash} from ID %{id}"
    },
    info = {
        bank_blip = "Bank",
        access_bank_target = "Access Bank",
        access_bank_key = "[E] - Access Bank",
        current_to_savings = "Transfer Current Account to Savings",
        savings_to_current = "Transfer Savings to Current Account",
        deposit = "Deposit $%{amount} into Current Account",
        withdraw = "Withdraw $%{amount} from Current Account",
    },
    command = {
        givecash = "Give cash to player."
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
