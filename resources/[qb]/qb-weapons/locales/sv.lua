local Translations = {
    error = {
        canceled = 'Avbruten',
        max_ammo = 'Max Ammokapacitet',
        no_weapon = 'Du har inget vapen.',
        no_support_attachment = 'Det här vapnet tillåter inte detta tillbehör.',
        no_weapon_in_hand = 'Du har inget vapen i handen.',
        weapon_broken = 'Vapnet är trasigt och kan inte användas.',
        no_damage_on_weapon = 'Vapnet är inte trasigt..',
        weapon_broken_need_repair = 'Vapnet är trasigt och måste repareras för att kunna användas igen.',
        attachment_already_on_weapon = 'Du har redan en %{value} på det här vapnet.'
    },
    success = {
        reloaded = 'Omladdat'
    },
    info = {
        loading_bullets = 'Laddar kulor',
        repairshop_not_usable = 'Reparation är ~r~INTE~w~ möjligt för tillfället.',
        weapon_will_repair = 'Ditt vapen kommer att repareras.',
        take_weapon_back = '[E] - Ta tillbaka vapen',
        repair_weapon_price = '[E] Reparera vapen, ~g~$%{value}~w~',
        removed_attachment = 'Du tp bort %{value} från vapnet!',
        hp_of_weapon = 'Ditt vapens HP'
    },
    mail = {
        sender = 'Viktor',
        subject = 'Reparation',
        message = 'Din %{value} är fixad, hämta upp det på en gång om du vill ha tillbaka skiten, jag vill inte ha med det att göra längre. <br><br> Hörs hej!'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
