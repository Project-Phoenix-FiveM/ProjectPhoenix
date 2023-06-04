local Translations = {
    error = {
        canceled = 'Afbrudt',
        max_ammo = 'Maks ammo kapacitet',
        no_weapon = 'Du har intet våben.',
        no_support_attachment = 'Denne våben har ingen tilføjelser.',
        no_weapon_in_hand = 'Du har intet våben i dine hænder.',
        weapon_broken = 'Dette våben er beskadigt og kan ikke bruges.',
        no_damage_on_weapon = 'Dette våben er ikke beskadigt..',
        weapon_broken_need_repair = 'Dit våben er beskadigt, du skal reparere det før du kan bruge det.',
        attachment_already_on_weapon = 'Du har allerede en %{value} på dit våben.'
    },
    success = {
        reloaded = 'Ladet'
    },
    info = {
        loading_bullets = 'Lader patroner',
        repairshop_not_usable = 'Denne shop for reparationer er ~r~IKKE~w~ en mulighed.',
        weapon_will_repair = 'Dit våben vil blive repareret.',
        take_weapon_back = '[E] - Tag våben tilbage',
        repair_weapon_price = '[E] Reparer for ~g~%{value} DKK~w~',
        removed_attachment = 'Du fjernede %{value} fra dit våben!',
        hp_of_weapon = 'HP på dit våben'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Reparer',
        message = 'Din %{value} er repareret, du kan hente det på følgende lokation. <br><br> Peace out madafaka'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
