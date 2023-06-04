local Translations = {
    notify = {
        ydhk = 'Sie haben keine Schlüssel für das Fahrzeug!',
        nonear = 'Es ist niemand in der Nähe, der den Schlüssel bekommen könnte!',
        vlock = 'Fahrzeug verriegelt!',
        vunlock = 'Fahrzeug entriegelt.',
        vlockpick = 'Sie haben es geschafft, das Türschloss zu knacken!',
        fvlockpick = 'Sie können keine Schlüssel finden und sind frustriert.',
        vgkeys = 'Sie geben die Schlüssel ab.',
        vgetkeys = 'Sie erhalten die Schlüssel für das Fahrzeug!',
        fpid = 'Geben Sie alle Argumente, nämlich die Bürger-ID und das Kennzeichen, an.',
        cjackfail = 'Knacken des Autos fehlgeschlagen!',
        vehclose = 'Thers no close vehicle!',
    },
    progress = {
        takekeys = 'Fahrzeugschlüssel abnehmen...',
        hskeys = 'Suche nach Fahrzeugschlüssel...',
        acjack = 'Versuchter Autodiebstahl...',
    },
    info = {
        skeys = '~g~[H]~w~ - Nach Schlüssel suchen',
        tlock = 'Fahrzeug auf-/zuschließen',
        palert = 'Fahrzeugdiebstahl im Gange. Typ: ',
        engine = 'Motor ein-/ausschalten',
    },
    addcom = {
        givekeys = 'Übergeben Sie die Schlüssel an jemanden. Wenn keine Bürger-ID angegeben, geht er an die nächstgelegene Person oder an alle Personen im Fahrzeug.',
        givekeys_id = 'id',
        givekeys_id_help = 'Bürger-ID',
        addkeys = 'Fügt Schlüssel zu einem Fahrzeug für jemanden hinzu.',
        addkeys_id = 'id',
        addkeys_id_help = 'Bürger-ID',
        addkeys_plate = 'kennzeichen',
        addkeys_plate_help = 'Kennzeichen',
        rkeys = 'Jemandem die Schlüssel eines Fahrzeugs abnehmen.',
        rkeys_id = 'id',
        rkeys_id_help = 'Bürger-ID',
        rkeys_plate = 'kennzeichen',
        rkeys_plate_help = 'Kennzeichen',
    }

}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
