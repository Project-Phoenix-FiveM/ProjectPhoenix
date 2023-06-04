local Translations = {
    error = {
        finish_work = "Suorita kaikki työsi ensin loppuun.",
        vehicle_not_correct = "Tämä ei ole oikea ajoneuvo.",
        failed = "Olet epäonnistunut tehtävässä.",
        not_towing_vehicle = "Sinun täytyy olla hinausautossasi.",
        too_far_away = "Olet liian kaukana.",
        no_work_done = "Et ole tehnyt yhtään työtä vielä.",
        no_deposit = "$%{value} Talletus vaaditaan.",
    },
    success = {
        paid_with_cash = "$%{value} Talletus maksettu käteisellä.",
        paid_with_bank = "$%{value} Talletus maksettu pankkitililtä.",
        refund_to_cash = "$%{value} Talletus maksettu käteisellä.",
        you_earned = "Sinä tienasit: $%{value}",
    },
    menu = {
        header = "Saatavilla olevat ajoneuvot.",
        close_menu = "⬅ Sulje valikko",
    },
    mission = {
        delivered_vehicle = "Olet toimittanut ajoneuvon.",
        get_new_vehicle = "Uusi ajoneuvo noudettavissa.",
        towing_vehicle = "Kiinnitetään ajoneuvoa...",
        goto_depot = "Vie ajoneuvo Hayes Depottiin.",
        vehicle_towed = "Ajoneuvo hinattu.",
        untowing_vehicle = "Poista ajoneuvo.",
        vehicle_takenoff = "Ajoneuvo otettu pois.",
    },
    info = {
        tow = "Aseta ajoneuvo lavallesi.",
        toggle_npc = "Näytä NPC Työ",
        skick = "Yritti käyttää exploittia",
    },
    label = {
        payslip = "Palkkatodistus",
        vehicle = "Ajoneuvo",
        npcz = "NPC Alue",
    }
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end
