local Translations = {
    error = {
        canceled = 'Abgebrochen',
        max_ammo = 'Maximale Muntions Kapazität',
        no_weapon = 'Du hast keine Waffen.',
        no_support_attachment = 'Diese waffe untersützt diesen komponenten nicht.',
        no_weapon_in_hand = 'Du hast keine Waffe in der Hand.',
        weapon_broken = 'Diese Waffe ist Kapputt! Du kannst sie nicht Benutzen!.',
        no_damage_on_weapon = 'Die Waffe hat keine Schäden..',
        weapon_broken_need_repair = 'Deine Waffe ist Kapput Repariere sie bevor du sie nutzen Kannst.',
        attachment_already_on_weapon = 'Du hast %{value} Bereits auf deiner Waffe.'
    },
    success = {
        reloaded = 'Nachgeladen'
    },
    info = {
        loading_bullets = 'Lade Kugeln',
        repairshop_not_usable = 'Der ReparierShop ist im moment ~r~NICHT~w~ Nutzbar.',
        weapon_will_repair = 'Deine Waffe wird Repariert.',
        take_weapon_back = '[E] - Nehme deine Waffe',
        repair_weapon_price = '[E] Repariere die waffe Für:, ~g~$%{value}~w~',
        removed_attachment = 'Du hast %{value} von deiner Waffe Entfernt!',
        hp_of_weapon = 'Status der Waffe'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Reperatur',
        message = 'Dein %{value} du kannst es bei der Position abholen. <br><br> Peace out madafaka'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
