local Translations = {
    error = {
        ["failed_notification"] = "Selhání!",
        ["not_near_veh"] = "Nejste v blízkosti vozidla!",
        ["out_range_veh"] = "Jste příliš daleko od vozidla!",
        ["inside_veh"] = "Nemůžete opravit motor vozidla zevnitř!",
        ["healthy_veh"] = "Vozidlo je příliš zdravé a potřebujete lepší nářadí!",
        ["inside_veh_req"] = "Pro opravu vozidla musíte být uvnitř!",
        ["roadside_avail"] = "Je k dispozici silniční asistence, kterou zavoláte prostřednictvím svého telefonu!",
        ["no_permission"] = "Nemáte oprávnění opravovat vozidla",
        ["fix_message"] = "%{message}, a nyní jeďte do servisu!",
        ["veh_damaged"] = "Vaše vozidlo je příliš poškozené!",
        ["nofix_message_1"] = "Podívali jste se na hladinu oleje a ta je v normě",
        ["nofix_message_2"] = "Podívali jste se na své kolo a zdá se, že nic není v nepořádku",
        ["nofix_message_3"] = "Podíval jste se na lepicí pásku na olejové hadici a zdála se je v pořádku",
        ["nofix_message_4"] = "Zesílili jste rádio. Podivný zvuk motoru je nyní pryč",
        ["nofix_message_5"] = "Odstraňovač rezivění, který jste použili, neměl žádný účinek",
        ["nofix_message_6"] = "Nikdy se nepokoušejte opravit něco, co není rozbité, ale vy jste neposlechli",
    },
    success = {
        ["cleaned_veh"] = "Vozidlo vyčištěno!",
        ["repaired_veh"] = "Vozidlo opraveno!",
        ["fix_message_1"] = "Zkontroloval jste hladinu oleje",
        ["fix_message_2"] = "Únik oleje jste uzavřeli žvýkačkou",
        ["fix_message_3"] = "Uzavřel jste olejovou hadici pomocí pásky",
        ["fix_message_4"] = "Dočasně jste zastavili únik oleje",
        ["fix_message_5"] = "Kolo jste nakopli a opět funguje",
        ["fix_message_6"] = "Odstranili jste rez",
        ["fix_message_7"] = "Křičeli jste na auto a ono opět funguje",
    },
    progress = {
        ["clean_veh"] = "Čištění auta...",
        ["repair_veh"] = "Oprava vozidla...",

    }
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
