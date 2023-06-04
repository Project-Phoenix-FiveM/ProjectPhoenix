local Translations = {
    notify = {
        ydhk = 'Teil pole selle sõiduki võtmeid.',
        nonear = 'Läheduses pole kedagi, kellele võtmed kätte anda',
        vlock = 'Sõiduk lukus!',
        vunlock = 'Sõiduk avatud!',
        vlockpick = 'Sul õnnestus ukselukk lahti keerata!',
        fvlockpick = 'Te ei leia võtmeid ja olete pettunud.',
        vgkeys = 'Annad võtmed üle.',
        vgetkeys = 'Saate auto võtmed!',
        fpid = 'Täitke mängija ID ja plaadi argumendid',
        cjackfail = 'Autovargamine ebaõnnestus!',
        vehclose = 'Thers no close vehicle!',
    },
    progress = {
        takekeys = 'Võtmete kehast võtmine...',
        hskeys = 'Autovõtmete otsimine...',
        acjack = 'Autovarguse katse...',
    },
    info = {
        skeys = '~g~[H]~w~ – Võtmete otsimine',
        tlock = 'Lülitage sõiduki lukud sisse',
        palert = 'Sõiduki vargus käsil. Tüüp:',
        engine = 'Mootori sisse- ja väljalülitamine',
    },
    addcom = {
        givekeys = 'Andke võtmed kellelegi üle. Kui isikut tõendav dokument puudub, annab see lähimale inimesele või kõigile sõidukis viibijatele.',
        givekeys_id = 'id',
        givekeys_id_help = 'Mängija ID',
        addkeys = 'Lisab kellegi jaoks sõidukile võtmed.',
        addkeys_id = 'id',
        addkeys_id_help = 'Mängija ID',
        addkeys_plate = 'Numbrimärk',
        addkeys_plate_help = 'Numbrimärk',
        rkeys = 'Eemaldage kellegi jaoks sõiduki võtmed.',
        rkeys_id = 'id',
        rkeys_id_help = 'Mängija ID',
        rkeys_plate = 'Numbrimärk',
        rkeys_plate_help = 'Numbrimärk',
    }

}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
