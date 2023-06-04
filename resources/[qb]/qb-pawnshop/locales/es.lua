local Translations = {
    error = {
        negative = 'Has intentado vender una cantidad negativa',
        no_melt = 'No hay nada en la fundición...',
        no_items = 'No tienes suficiente cantidad',
    },
    success = {
        sold = 'Has vendido %{value} x %{value2} por $%{value3}',
        items_received = 'Has recibido %{value} x %{value2}',
    },
    info = {
        title = 'Casa de Empeños',
        subject = 'Artículos para fundir',
        message = 'Hemos terminado de fundir sus productos. Puede venir a recogerlos cuando quiera..',
        open_pawn = 'Abre la casa de empeños',
        sell = 'Vender artículos',
        sell_pawn = 'Vender artículos a la casa de empeños',
        melt = 'Fundir productos',
        melt_pawn = 'Abre la fundición',
        melt_pickup = 'Recoger producto fundido',
        pawn_closed = 'La casa de empeños está cerrada. Vuelve entre las %{value}:00 AM y las %{value2}:00 PM',
        sell_items = 'Precio de venta $%{value}',
        back = '⬅ Volver',
        melt_item = 'Fundir %{value}',
        max = 'Cantidad máxima %{value}',
        submit = 'Fundir',
        melt_wait = 'Dame %{value} minutos y fundiré tus productos',
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
