local Translations = {
    error = {
        not_give = "Kunne ikke give dette item til det angivne id.",
        givecash = "Brug /givecash [ID] [BELØB]",
        wrong_id = "Forkert ID.",
        dead = "Du er død LOL.",
        too_far_away = "Du er for langt væk lmfao.",
        not_enough = "Du har ikke dette beløb.",
        invalid_amount = "Ugyldigt beløb"
    },
    success = {
        debit_card = "Du har bestilt et betalingskort.",
        cash_deposit = "Du har foretaget en indbetaling på %{value} DKK.",
        cash_withdrawal = "Du har foretaget en udbetalling på %{value} DKK.",
        updated_pin = "Du har opdateret din pinkode.",
        savings_deposit = "Du har foretaget et opsparingsindskud på %{value} DKK.",
        savings_withdrawal = "Du foretog din opsparing på %{value} DKK.",
        opened_savings = "Du har åbnet en opsparingskonto.",
        give_cash = "Du gav %{cash} DKK til ID %{id}",
        received_cash = "Modtog %{cash} DKK fra ID %{id}"
    },
    info = {
        bank_blip = "Bank",
        access_bank_target = "Tilgå Bank",
        access_bank_key = "[E] - Tilgå Bank",
        current_to_savings = "Overfør nuværende konto til opsparings",
        savings_to_current = "Overfør opsparing til nuværende konto",
        deposit = "Indbetal %{amount} DKK på nuværende konto",
        withdraw = "Udbetal %{amount} DKK fra nuværende konto",
    },
    command = {
        givecash = "Giv penge til spiller."
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
