local Translations = {
    error = {
        not_give = "Kon het item niet geven aan het opgegeven ID.",
        givecash = "Gebruik /givecash [ID] [BEDRAG]",
        wrong_id = "Verkeerd ID.",
        dead = "Je bent dood LOL.",
        too_far_away = "Je bent te ver weg lmfao.",
        not_enough = "Je hebt niet genoeg van dit bedrag.",
        invalid_amount = "Ongeldig opgegeven bedrag"
    },
    success = {
        debit_card = "Je hebt succesvol een debitcard besteld.",
        cash_deposit = "Je hebt succesvol $%{value} gestort.",
        cash_withdrawal = "Je hebt succesvol $%{value} opgenomen.",
        updated_pin = "Je hebt succesvol je debitcard-pincode bijgewerkt.",
        savings_deposit = "Je hebt succesvol $%{value} gestort op je spaarrekening.",
        savings_withdrawal = "Je hebt succesvol $%{value} opgenomen van je spaarrekening.",
        opened_savings = "Je hebt succesvol een spaarrekening geopend.",
        give_cash = "Succesvol $%{cash} gegeven aan ID %{id}",
        received_cash = "Succesvol $%{cash} ontvangen van ID %{id}"
    },
    info = {
        bank_blip = "Bank",
        access_bank_target = "Toegang tot de bank",
        access_bank_key = "[E] - Toegang tot de bank",
        current_to_savings = "Overboeken van betaalrekening naar spaarrekening",
        savings_to_current = "Overboeken van spaarrekening naar betaalrekening",
        deposit = "Stort $%{amount} op de betaalrekening",
        withdraw = "Neem $%{amount} op van de betaalrekening",
    },
    command = {
        givecash = "Geef geld aan speler."
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
