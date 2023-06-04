local Translations = {
    error = {
        canceled = 'Atšaukta',
        max_ammo = 'Maksimali šovinių talpa',
        no_weapon = 'Jūs neturite ginklo.',
        no_support_attachment = 'Šis ginklas negali turėti šio priedo.',
        no_weapon_in_hand = 'Jūs neturite ginklo rankoje.',
        weapon_broken = 'Šis ginklas yra sulūžęs ir negali būti naudojamas.',
        no_damage_on_weapon = 'Šis ginklas nėra sugadintas...',
        weapon_broken_need_repair = 'Jūsų ginklas yra sulūžęs, jums reikia jį sutaisyti, kad naudoti vėl.',
        attachment_already_on_weapon = 'Jūs jau turite %{value} ant savo ginklo.'
    },
    success = {
        reloaded = 'Užtaisytas'
    },
    info = {
        loading_bullets = 'Užtaisomi šoviniai',
        repairshop_not_usable = 'Taisyklos šiuo metu ~r~NEGALIMA~w~ naudoti.',
        weapon_will_repair = 'Jūsų ginklas bus sutaisytas.',
        take_weapon_back = '[E] - Atgauti ginklą',
        repair_weapon_price = '[E] Sutaisyti ginklą, ~g~$%{value}~w~',
        removed_attachment = 'Jūs panaikinote %{value} iš savo ginklo!',
        hp_of_weapon = 'Jūsų ginklo patvarumas'
    },
    mail = {
        sender = 'Tironas',
        subject = 'Taisymas',
        message = 'Jūsų %{value} yra sutaisytas. Galite jį atsiimti vietoje. <br><br> Davaice'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
