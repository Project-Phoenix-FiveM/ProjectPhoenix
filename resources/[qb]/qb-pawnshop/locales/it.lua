local Translations = {
    error = {
        negative = 'Cerchi di vendere una cifra negativa?',
        no_melt = 'Non mi hai dato niente da sciogliere...',
        no_items = 'Articoli non sufficienti',
    },
    success = {
        sold = 'Hai venduto %{value} x %{value2} per $%{value3}',
        items_received = 'Hai ricevuto %{value} x %{value2}',
    },
    info = {
        title = 'Banco dei pegni',
        subject = 'Fonderia',
        message = 'Abbiamo finito di fondere i tuoi articoli. Puoi venire a prenderli in qualsiasi momento.',
        open_pawn = 'Apri il negozio dei pegni',
        sell = 'Vendi oggetti',
        sell_pawn = 'Vendi articoli al negozio dei pegni',
        melt = 'Fondi articoli',
        melt_pawn = 'Apri la fonderia',
        melt_pickup = 'Prendi oggetti fusi',
        pawn_closed = 'Il banco dei pegni è chiuso. Torna tra le %{value}:00 AM - %{value2}:00 PM',
        sell_items = 'Prezzo di vendita $%{value}',
        back = '⬅ Indietro',
        melt_item = 'Fondi %{value}',
        max = 'Quantità massima %{value}',
        submit = 'Fondi',
        melt_wait = 'Dammi %{value} minuti e farò sciogliere la tua roba',
    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
