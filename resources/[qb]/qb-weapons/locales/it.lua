local Translations = {
    error = {
        canceled = 'Annullato',
        max_ammo = 'Capacità massima munizioni',
        no_weapon = 'Non hai nessuna arma.',
        no_support_attachment = 'Questa arma non supporta questo componente.',
        no_weapon_in_hand = 'Non hai un\'arma in mano.',
        weapon_broken = 'Questa arma è rotta e non può essere utilizzata.',
        no_damage_on_weapon = 'Questa arma non è danneggiata..',
        weapon_broken_need_repair = 'La tua arma è rotta, devi ripararla prima di poterla usare di nuovo.',
        attachment_already_on_weapon = 'Hai già un %{value} nella tua arma.'
    },
    success = {
        reloaded = 'Ricaricata'
    },
    info = {
        loading_bullets = 'Caricando proiettili',
        repairshop_not_usable = 'Il negozio di riparazione in questo momento ~r~NON~w~ è aperto.',
        weapon_will_repair = 'La tua arma verrà riparata.',
        take_weapon_back = '[E] - Prendi arma',
        repair_weapon_price = '[E] Ripara arma, ~g~$%{value}~w~',
        removed_attachment = 'Hai rimosso %{value} dalla tua arma!',
        hp_of_weapon = 'HP of ur weapon'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Riparazione',
        message = 'La tua %{value} è stata riparata e pui prenderla alla posizione. <br><br> Peace out madafaka'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
