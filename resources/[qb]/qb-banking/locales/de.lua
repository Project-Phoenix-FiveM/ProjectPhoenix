local Translations = {
    error = {
        not_give = "Item konnte der ID nicht gegeben werden.",
        givecash = "Usage /givecash [ID] [AMOUNT]",
        wrong_id = "ID nicht gefunden.",
        dead = "Du bist tot.",
        too_far_away = "Du bist zu weit weg.",
        not_enough = "Du besitzt nicht so viel.",
        invalid_amount = "Ungültige Menge angegeben"
    },
    success = {
        debit_card = "Du hast erfolgreich eine Debitkarte erhalten.",
        cash_deposit = "Du hast $%{value}. eingezahlt",
        cash_withdrawal = "Du hast $%{value}. abgehoben",
        updated_pin = "Du hast erfolgreich dein PIN geändert",
        savings_deposit = "Du hast $%{value}. auf dein Sparkonto eingezahlt",
        savings_withdrawal = "Du hast $%{value}. von deinem Sparkonto abgehoben",
        opened_savings = "Du hast nun ein Sparkonto.",
        give_cash = "Du hast $%{cash} an ID: %{id} gegeben",
        received_cash = "Du hast $%{cash} von ID %{id} erhalten"
    },
    info = {
        bank_blip = "Bank",
        access_bank_target = "Bank öffnen",
        access_bank_key = "[E] - Bank öffnen",
        current_to_savings = "Momentanes Konto auf Sparkonto übertragen",
        savings_to_current = "Sparkonto auf Momentanes Konto übertragen"
    },
    command = {
        givecash = "Spieler Bargeld geben."
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
