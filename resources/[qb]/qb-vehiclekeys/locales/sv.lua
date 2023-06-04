local Translations = {
    notify = {
        ydhk = 'Du har inga nycklar till det här fordonet.',
        nonear = 'Det finns ingen i närheten.',
        vlock = 'Fordon låst!',
        vunlock = 'Fordon upplåst!',
        vlockpick = 'Du lyckades dyrka dörrlåset!',
        fvlockpick = 'Du hittar inte nycklarna och blir frustrerad.',
        vgkeys = 'Du överlämnar ett par nycklar.',
        vgetkeys = 'Du fick nycklar till fordonet!',
        fpid = 'Fyll i personens ID och reg.nr på fordonet',
        cjackfail = 'Bilstöld misslyckades!',
        vehclose = 'Det finns inget fordon tillräckligt nära!',
    },
    progress = {
        takekeys = 'Tar nycklar från personen...',
        hskeys = 'Letar efter bilnycklarna...',
        acjack = 'Snor fordonet...',
    },
    info = {
        skeys = '~g~[H]~w~ - Leta efter nycklarna',
        tlock = 'Lås/Lås upp fordon',
        palert = 'Fordonsstöld pågår. Typ: ',
        engine = 'Motor Av/På',
    },
    addcom = {
        givekeys = 'Överlämna nycklar till någon. Om inget ID anges, ges nycklarna till närmaste personen eller alla i fordonet.',
        givekeys_id = 'id',
        givekeys_id_help = 'Person ID',
        addkeys = 'Lägg till nycklar till ett fordon för någon.',
        addkeys_id = 'id',
        addkeys_id_help = 'Person ID',
        addkeys_plate = 'reg.nr',
        addkeys_plate_help = 'Reg.nr',
        rkeys = 'Ta bort nycklarna till ett fordon för någon.',
        rkeys_id = 'id',
        rkeys_id_help = 'Person ID',
        rkeys_plate = 'reg.nr',
        rkeys_plate_help = 'Reg.nr',
    }

}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end
