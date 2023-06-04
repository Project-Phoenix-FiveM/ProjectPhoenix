local Translations = {
    error = {
        canceled = 'Anulat',
        max_ammo = 'Arma a ajuns la numarul maxim de gloante',
        no_weapon = 'Nu ai nici o arma.',
        no_support_attachment = 'Arma nu suporta atasamente.',
        no_weapon_in_hand = 'Nu ai o arma in mana.',
        weapon_broken = 'Arma este stricata si nu o poti folosi.',
        no_damage_on_weapon = 'Arma nu este stricata..',
        weapon_broken_need_repair = 'Arma ta este stricata, va trebuie sa o repari ca sa o folosesti.',
        attachment_already_on_weapon = 'Deja ai atasat: %{value} pe arma.'
    },
    success = {
        reloaded = 'Reincarcat'
    },
    info = {
        loading_bullets = 'Reincarci..',
        repairshop_not_usable = 'Magazinul de reparat ~r~NU~w~ poate fi folosit in acest moment.',
        weapon_will_repair = 'Arma ta va fi reparata.',
        take_weapon_back = '[E] - Ia-ti arma inapoi',
        repair_weapon_price = '[E] Repara arma, ~g~$%{value}~w~',
        removed_attachment = 'Ai scos %{value} de pe arma!',
        hp_of_weapon = 'HP-ul armei'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Repara',
        message = 'Arma: %{value} este reparata si o poti lua de la mine. <br><br> Du-te dracu bozo'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
