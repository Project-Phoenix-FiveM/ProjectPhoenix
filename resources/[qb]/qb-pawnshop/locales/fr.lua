local Translations = {
    error = {
        negative = 'Vous essayez de vendre une quantitée négative?',
        no_melt = 'Vous ne m\'avez rien donné a fondre...',
        no_items = 'Pas assez d\'objet',
    },
    success = {
        sold = 'Vous avez vendu %{value} x %{value2} pour $%{value3}',
        items_received = 'Vous avez reçu %{value} x %{value2}',
    },
    info = {
        title = 'Prêteur sur gage',
        subject = 'Fondre des Objets',
        message = 'Nous avons finis de fondre vos objets. Vous pouvez venir les récuperer a n\'importe quel moment.',
        open_pawn = 'Ouvrir le Prêteur sur gage',
        sell = 'Vendre des objets',
        sell_pawn = 'Vendre des objets au Prêteur sur gage',
        melt = 'Fondre des Objets',
        melt_pawn = 'Ouvrir la fonderie',
        melt_pickup = 'Récupérer les objets fondu',
        pawn_closed = 'Le prêteur sur gage est fermé. Revenez entre %{value}:00 du matin et %{value2}:00 de l\'après-midi',
        sell_items = 'Prix de vente: $%{value}',
        back = '⬅ Aller en arrière',
        melt_item = 'Fondre %{value}',
        max = 'Quantitée Max. %{value}',
        submit = 'Fondre',
        melt_wait = 'Donnez moi %{value} minutes et j\'aurais fondu vos objets.',
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end