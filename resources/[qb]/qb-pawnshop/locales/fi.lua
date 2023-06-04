local Translations = {
    error = {
        negative = 'Yritätkö myydä virheellistä määrää meille?',
        no_melt = 'Sinulla ei ole mitään annettavaa minulle...',
        no_items = 'Ei tarpeaski itemeitä',
    },
    success = {
        sold = 'Sinä sait myytyä %{value} x %{value2} hintaan $%{value3}',
        items_received = 'Sinä sait %{value} x %{value2}',
    },
    info = {
        title = 'Panttilainaamo',
        subject = 'Sulata tavaroita',
        message = 'Olemme saaneet esineesi sulatuksen valmiiksi. Voit tulla noutamaan niitä milloin tahansa.',
        open_pawn = 'Avaa panttilainaamo',
        sell = 'Myy tavaraa',
        sell_pawn = 'Myy itemeitä panttilainaamolle',
        melt = 'Sulatetut itemit',
        melt_pawn = 'Avaa sulatuksen valikko',
        melt_pickup = 'Ota vastaan sulatetut itemit',
        pawn_closed = 'Panttilainaamo on suljettu. Tule takaisin %{value}:00 AM - %{value2}:00 PM',
        sell_items = 'Myyntihinta $%{value}',
        back = '⬅ Mene takaisin',
        melt_item = 'Sulatus %{value}',
        max = 'Maxsimi määrä %{value}',
        submit = 'Sulata',
        melt_wait = 'Anna minulle %{value} minuttia aikaa, Sitten tavarasi on sulatettu',
    }
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end