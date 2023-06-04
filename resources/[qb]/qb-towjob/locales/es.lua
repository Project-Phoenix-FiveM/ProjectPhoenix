local Translations = {
    error = {
        finish_work = "Primero necesitas terminar tu trabajo.",
        vehicle_not_correct = "Este no es el vehículo correcto",
        failed = "Fallado",
        not_towing_vehicle = "Debes estar en una grúa primero",
        too_far_away = 'Estás demasiado lejos',
        no_work_done = "Aún no has hecho ningún encargo.",
        no_deposit = "Se necesita un depósito de %{value}$",
    },
    success = {
        paid_with_cash = "Depósito de %{value}$ pagado en efectivo",
        paid_with_bank = "Depósito de %{value}$ pagado por transferencia bancaria",
        refund_to_cash = "Depósito de %{value}$ devuelto en efectivo",
        you_earned = "Has cobrado %{value}$",
    },
    menu = {
        header = "Vehículos disponibles",
        close_menu = "⬅ Cerrar Menú",
    },
    mission = {
        delivered_vehicle = "Has entregado un vehículo",
        get_new_vehicle = "Puedes ir a recoger un nuevo vehículo",
        towing_vehicle = "Enganchando vehículo...",
        goto_depot = "Lleva el vehículo al Depósito de Hayes",
        vehicle_towed = "Vehículo remolcado",
        untowing_vehicle = "Desenganchar vehículo",
        vehicle_takenoff = "Vehículo desenganchado",
    },
    info = {
        tow = "Coloca el vehículo en la parte de atrás de tu grúa de plataforma",
        toggle_npc = "Alternar trabajos de NPC",
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
