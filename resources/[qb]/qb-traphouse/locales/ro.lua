local Translations = {
    error = {
        not_enough = "Nu ai suficienti bani (cash)..",
        no_slots = "Nu mai sunt sloturi disponibile",
        occured = "A aparut o eroare...",
        have_keys = "Aceasta persoana, are deja cheile",
        p_have_keys = "%{value} are deja cheile",
        not_owner = "Nu ai in proprietate nicio casa conspirativa",
        not_online = "Aceasta persoana nu se afla in oras (stat)",
        no_money = "Nu mai sunt bani in dulap...",
        incorrect_code = "Codul introdus este incorect",
        up_to_6 = "Poti da acces la o casa conspirativa, la maxim 6 persoane!",
        cancelled = "Procesul de achizitie a fost anulat",
    },
    success = {
        added = "%{value} a fost adaugat(a) la casa conspirativa!",
    },
    info = {
        enter = "Acceseaza casa conspirativa",
        give_keys = "Ofera cheile casei conspirative",
        pincode = "Codul de acces: %{value}",
        taking_over = "Preluare ostila",
        pin_code_see = "~b~G~w~ - Vezi codul PIN",
        pin_code = "Codul PIN: %{value}",
        multikeys = "~b~/multikeys~w~ [id] - Ofera cheile casei conspirative",
        take_cash = "~b~E~w~ - Scoate bani (~g~$%{value}~w~)",
        inventory = "~b~H~w~ - Vezi inventarul",
        take_over = "~b~E~w~ - Preluare ostila (~g~$5000~w~)",
        leave = "~b~E~w~ - Iesi din casa conspirativa",
    },
    targetInfo = {
        options = "Optiunile casei conspirative",
        enter = "Intra in casa conspirativa",
        give_keys = "Ofera cheile casei conspirative",
        pincode = "Codul PIN de acces: %{value}",
        taking_over = "Preluare ostila",
        pin_code_see = "Vezi codul PIN",
        pin_code = "Codul PIN: %{value}",
        multikeys = "Ofera cheile (foloseste /multikey [id])",
        take_cash = "I-a banii ($%{value})",
        inventory = "Vezi inventarul",
        take_over = "Preluare ostila ($5000)",
        leave = "Paraseste casa conspirativa",
        close_menu = "⬅ Inchide meniul",
    }
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end
