local Translations = {
    error = {
        not_give = "Nie można nadać przedmiotu o podanym identyfikatorze.",
        givecash = "Zastosowanie /givecash [ID] [ILOŚĆ]",
        wrong_id = "Błędny identyfikator.",
        dead = "Jesteś martwy LOL.",
        too_far_away = "Jesteś za daleko lmfao.",
        not_enough = "Nie masz tej kwoty.",
        invalid_amount = "Nieprawidłowa podana kwota"
    },
    success = {
        debit_card = "Pomyślnie zamówiłeś kartę debetową.",
        cash_deposit = "Udało Ci się dokonać wpłaty gotówkowej w wysokości $%{value}.",
        cash_withdrawal = "Udało Ci się dokonać wypłaty gotówki w wysokości $%{value}.",
        updated_pin = "Pomyślnie zaktualizowałeś kod PIN karty debetowej.",
        savings_deposit = "Udało Ci się dokonać wpłaty oszczędności $%{value}.",
        savings_withdrawal = "Udało Ci się dokonać wypłaty oszczędności $%{value}.",
        opened_savings = "Udało Ci się otworzyć konto oszczędnościowe.",
        give_cash = "Pomyślnie dano $%{cash} dla ID %{id}",
        received_cash = "Pomyślnie odebrano $%{cash} od ID %{id}"
    },
    info = {
        bank_blip = "Bank",
        access_bank_target = "Dostęp do banku",
        access_bank_key = "[E] - Dostęp do banku",
        current_to_savings = "Przenieś konto bieżące do oszczędności",
        savings_to_current = "Przenieś oszczędności na konto bieżące "
    },
    command = {
        givecash = "Daj graczowi gotówkę."
    }
}

if GetConvar('qb_locale', 'en') == 'pl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
