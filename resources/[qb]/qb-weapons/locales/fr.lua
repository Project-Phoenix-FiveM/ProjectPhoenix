local Translations = {
    error = {
        canceled = 'Annulé',
        max_ammo = 'Capacitée maximale de munition',
        no_weapon = 'Vous n\'avez pas d\'arme.',
        no_support_attachment = 'Cette arme ne supporte pas cet accessoire.',
        no_weapon_in_hand = 'Vous n\'avez pas d\'arme dans vos mains.',
        weapon_broken = 'Cette arme est cassée est ne peux donc pas être utilisée.',
        no_damage_on_weapon = 'Cette arme n\'est pas endommagée..',
        weapon_broken_need_repair = 'Votre arme est cassée, Vous devez la réparée pour vous en reservir.',
        attachment_already_on_weapon = 'Vous aviez déjà un %{value} sur votre arme.'
    },
    success = {
        reloaded = 'Rechargée'
    },
    info = {
        loading_bullets = 'Charger les munitions',
        repairshop_not_usable = 'L\'atelier de réparation n\'est ~r~PAS~w~ utilisable.',
        weapon_will_repair = 'Votre arme va être réparée.',
        take_weapon_back = '[E] - Récuperer votre arme',
        repair_weapon_price = '[E] Réparer l\'arme, ~g~$%{value}~w~',
        removed_attachment = 'Vous avez retiré %{value} de votre arme!',
        hp_of_weapon = 'Durabilité de votre arme'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Réparation',
        message = 'Votre %{value} Est réparé et vous pouvez venir le récuperer. <br><br> Peace out madafaka'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
