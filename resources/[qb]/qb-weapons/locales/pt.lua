local Translations = {
    error = {
        canceled = 'Cancelado',
        max_ammo = 'Capacidade máxima de munição',
        no_weapon = 'Não tens uma arma.',
        no_support_attachment = 'Esta arma não suporta este attachment.',
        no_weapon_in_hand = 'Não tens uma arma na tua mão.',
        weapon_broken = 'Esta arma está destruída e não pode ser utilizada.',
        no_damage_on_weapon = 'Esta arma não está danificada..',
        weapon_broken_need_repair = 'A tua arma está destruída, precisas de a reparar antes de a usares outra vez.',
        attachment_already_on_weapon = 'Tu já tens um %{value} na tua arma.'
    },
    success = {
        reloaded = 'Recarregado'
    },
    info = {
        loading_bullets = 'A carregar munição',
        repairshop_not_usable = 'A mesa de reparação neste momento não está disponível.',
        weapon_will_repair = 'A tua arma vai ser reparada.',
        take_weapon_back = '[E] - Pegar na arma de volta',
        repair_weapon_price = '[E] Reparar arma, ~g~%{value}€~w~',
        removed_attachment = 'Removeste %{value} da tua arma!',
        hp_of_weapon = 'HP da tua arma'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Reparação',
        message = 'A teu/tua %{value} está reparado(a). Podes recolher neste local. <br><br> Paz madafaka'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
