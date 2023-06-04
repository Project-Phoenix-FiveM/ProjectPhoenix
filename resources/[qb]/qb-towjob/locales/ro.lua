--[[
Romanian base language translation for qb-towjob
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    error = {
        finish_work = "Termina-ti mai intai munca inceputa",
        vehicle_not_correct = "Acesta nu este vehiculul corect/corespunzator",
        failed = "Oh, nasol.. ai esuat..",
        not_towing_vehicle = "Trebuie sa fi in vehiculul de remorcare",
        too_far_away = "Esti prea departe",
        no_work_done = "Nu ai terminat taskurile atribuite",
        no_deposit = "Este necesara suma de $%{value} ca depozit/garantie",
    },
    success = {
        paid_with_cash = "Ai platit suma de $%{value} in cash, ca si garantie.",
        paid_with_bank = "Ai platit suma de $%{value} prin banca, ca si garantie.",
        refund_to_cash = "Ai primit inapoi suma de $%{value} reprezentand garantia depusa.",
        you_earned = "Ai castigat suma de $%{value}",
    },
    menu = {
        header = "Vehicule disponibile",
        close_menu = "⬅ Inchide meniul",
    },
    mission = {
        delivered_vehicle = "Ai livrat un vehicul",
        get_new_vehicle = "Poti sa livrezi un nou vehicul",
        towing_vehicle = "Se ridica vehiculul...",
        goto_depot = "Vehiculul trebuie dus la Hayes Depot",
        vehicle_towed = "Vehicul remorcat",
        untowing_vehicle = "Da jos vehiculul",
        vehicle_takenoff = "Da jos de pe remorca vehiculul",
    },
    info = {
        tow = "Tractezi o masina pe rampa de tractare",
        toggle_npc = "Activezi/Dezactivezi joburile cu NPC",
        skick = "Tentativa de abuz de exploatare",
    },
    label = {
        payslip = "Fisa de salariu",
        vehicle = "Vehicule",
        npcz = "Misiuni NPC",
    }
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
