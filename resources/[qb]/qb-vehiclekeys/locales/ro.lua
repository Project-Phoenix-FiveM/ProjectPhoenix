--[[
Romanian base language translation for qb-vehiclekeys
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    notify = {
        ydhk = 'Nu ai cheile acestui vehicul.',
        nonear = 'Nu este nimeni langa tine sa-i dai cheile vehiculului',
        vlock = 'Vehicul blocat - Alarma activa!',
        vunlock = 'Vehicul deblocat - Alarma inactiva!',
        vlockpick = 'Felicitari, ai reusit sa spargi incuietoarea!',
        fvlockpick = 'Nu ai putut clona cheile masinii si te stresezi.',
        vgkeys = 'Ai dat cheile vehiculului.',
        vgetkeys = 'Ai primit cheile vehiculului!',
        fpid = 'Trebuie sa introduci ID-ul jucatorului si numarul de inmatriculare',
        cjackfail = 'Furtul de mașină a eșuat',
        vehclose = 'Thers no close vehicle!',
    },
    progress = {
        takekeys = 'Iei chile de la vehicul...',
        hskeys = 'Clonezi cheile vehiculului...',
        acjack = 'Incerci sa fur vehiculul...',
    },
    info = {
        skeys = '~g~[H]~w~ - Cloneaza cheile',
        tlock = 'Blocheaza/Deblocheaza vehiculul',
        palert = 'Furt auto in desfasurare. Tip: ',
        engine = 'Porneste/Opreste motorul',
    },
    addcom = {
        givekeys = 'Dai cheile vehiculului unei alte persoane. Daca nu se precizeaza ID-ul, cheile se duc celei mai apropiate persoane de tine.',
        givekeys_id = 'ID',
        givekeys_id_help = 'ID-ul jucatorului caruia vrei sa-i dai cheile',
        addkeys = 'Adaugi un set de chei al unui vehicul pentru o alta persoana.',
        addkeys_id = 'ID',
        addkeys_id_help = 'ID-ul jucatorului',
        addkeys_plate = 'numar',
        addkeys_plate_help = 'Numarul de inmatriculare al vehiculului',
        rkeys = 'Anulezi setul de chei aditional, pentru o persoana.',
        rkeys_id = 'ID',
        rkeys_id_help = 'ID-ul jucatorului',
        rkeys_plate = 'numar',
        rkeys_plate_help = 'Numarul de inmatriculare al vehiculului',
    }

}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
