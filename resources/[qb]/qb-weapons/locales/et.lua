local Translations = {
    error = {
        canceled = 'Katkestatud',
        max_ammo = 'Maksimaalne laskemoona mahutavus',
        no_weapon = 'Sul pole relva.',
        no_support_attachment = 'See relv ei toeta seda kinnitust.',
        no_weapon_in_hand = 'Sul pole relva käes.',
        weapon_broken = 'See relv on katki ja seda ei saa kasutada.',
        no_damage_on_weapon = 'See relv ei ole kahjustatud..',
        weapon_broken_need_repair = 'Teie relv on katki, peate selle parandama, enne kui saate seda uuesti kasutada.',
        attachment_already_on_weapon = 'Teie relv on katki, peate selle parandama, enne kui saate seda uuesti kasutada.'
    },
    success = {
        reloaded = 'Uuesti laaditud'
    },
    info = {
        loading_bullets = 'Kuulide laadimine',
        repairshop_not_usable = 'Praegune remonditöökoda ~pole~ kasutatav.',
        weapon_will_repair = 'Teie relv parandatakse.',
        take_weapon_back = '[E] - Võtke relv tagasi',
        repair_weapon_price = '[E] Relv parandamine, ~g~$%{value}~w~',
        removed_attachment = 'Eemaldasite oma relvast %{value}!',
        hp_of_weapon = 'Teie relva vastupidavus'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Parandus',
        message = 'Teie %{value} on parandatud ja saate selle kohapealt kätte saada. <br><br> Peace out madafaka'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
