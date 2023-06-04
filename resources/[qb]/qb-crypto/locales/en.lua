local Translations = {
    error = {
        you_dont_have_a_cryptostick = 'You don\'t have a cryptostick',
        cryptostick_malfunctioned = 'Cryptostick malfunctioned'
    },
    success = {
        you_have_exchanged_your_cryptostick_for = 'You have exchanged your Cryptostick for: %{amount} QBit(s)'
    },
    credit = {
        there_are_amount_credited = 'You have been credited %{amount} Qbit(s)!',
        you_have_qbit_purchased = 'You have purchased %{dataCoins} Qbit(s)!'
    },
    debit = {
        you_have_sold = 'You have sold %{dataCoins} Qbit(s)!'
    },
    text = {
        enter_usb = '[E] - Enter USB',
        system_is_rebooting = 'System is rebooting - %{rebootInfoPercentage} %',
        you_have_not_given_a_new_value = 'You have not given a new value ... Current value: %{crypto}',
        this_crypto_does_not_exist = 'This crypto does not exist, available crypto(s): Qbit',
        you_have_not_provided_crypto_available_qbit = 'You have not provided Crypto, available: Qbit',
        the_qbit_has_a_value_of = 'Qbit has a value of: %{crypto}',
        you_have_with_a_value_of = 'You have %{playerPlayerDataMoneyCrypto} QBit(s) with a value of: %{mypocket},-'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
