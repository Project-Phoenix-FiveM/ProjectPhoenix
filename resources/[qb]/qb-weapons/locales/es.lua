local Translations = {
    error = {
        canceled = 'Cancelado',
        max_ammo = 'Munición al máximo',
        no_weapon = 'No tienes ningún arma.',
        no_support_attachment = 'Este arma no puede llevar este accesorio.',
        no_weapon_in_hand = 'No tienes ningún arma en la mano.',
        weapon_broken = 'Este arma esta estropeada y no puedes usarla.',
        no_damage_on_weapon = 'Este arma no esta dañada..',
        weapon_broken_need_repair = 'Tu arma esta estropeada, necesitas repararla antes de poder usarla.',
        attachment_already_on_weapon = 'Ya tienes un %{value} en tu arma.'
    },
    success = {
        reloaded = 'Recargada'
    },
    info = {
        loading_bullets = 'Cargando Munición',
        repairshop_not_usable = 'La tienda de reparación en este momento ~r~NO~w~ puede ser usada.',
        weapon_will_repair = 'Tu arma sera reparada.',
        take_weapon_back = '[E] - Coger Tu Arma',
        repair_weapon_price = '[E] Reparar Arma, ~g~$%{value}~w~',
        removed_attachment = 'Has quitado el %{value} de tu arma!',
        hp_of_weapon = 'Durabilidad de tu arma'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Reparación',
        message = 'Tu %{value} ha sido reparada puedes recogarla en esta ubicación. <br><br> Espavila matao'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
