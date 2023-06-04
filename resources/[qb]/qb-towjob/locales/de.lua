local Translations = {
    error = {
        finish_work = "Beenden Sie zuerst alle Ihre Arbeiten",
        vehicle_not_correct = "Dies ist nicht das richtige Fahrzeug",
        failed = "Du bist durchgefallen",
        not_towing_vehicle = "Sie müssen in Ihrem Abschleppfahrzeug sitzen",
        too_far_away = "Du bist zu weit weg",
        no_work_done = "Sie haben noch keine Arbeit erledigt",
        no_deposit = "$%{value} Kaution erforderlich",
    },
    success = {
        paid_with_cash = "$%{value} Kaution mit Bargeld bezahlt",
        paid_with_bank = "$%{value} Kaution von der Bank bezahlt",
        refund_to_cash = "$%{value} Kaution mit Bargeld bezahlt",
        you_earned = "Sie haben $%{value} verdient",
    },
    menu = {
        header = "Verfügbare LKWs",
        close_menu = "⬅ Menü schließen",
    },
    mission = {
        delivered_vehicle = "Sie haben ein Fahrzeug ausgeliefert",
        get_new_vehicle = "Ein neues Fahrzeug kann abgeholt werden",
        towing_vehicle = "Anheben des Fahrzeugs ...",
        goto_depot = "Bringen Sie das Fahrzeug zum Hayes Depot",
        vehicle_towed = "Fahrzeug abgeschleppt",
        untowing_vehicle = "Entfernen Sie das Fahrzeug",
        vehicle_takenoff = "Fahrzeug abgeholt",
    },
    info = {
        tow = "Platzieren Sie ein Auto auf der Rückseite Ihres Abschleppers",
        toggle_npc = "NPC-Job umschalten",
        skick = "Versuchter Exploit-Missbrauch",
    },
    label = {
        payslip = "Gehaltsabrechnung",
        vehicle = "Fahrzeug",
        npcz = "NPCZone",
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
