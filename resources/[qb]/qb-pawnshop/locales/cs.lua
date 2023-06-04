local Translations = {
    error = {
        negative = 'Zkoušíš prodat záporné množství?',
        no_melt = 'Nedal jsi mi nic k roztavení...',
        no_items = 'Nedostatek položek',
        inventory_full = 'Váš inventář je plný! Zkuste to příště, až inventář nebude plný. Ztracené věci: %{value}'
    },
    success = {
        sold = 'Prodali jste %{value} x %{value2} za $%{value3}',
        items_received = 'Obdrželi jste %{value} x %{value2}',
    },
    info = {
        title = 'Zastavárna',
        subject = 'Roztavení položek',
        message = 'Dokončili jsme roztavení vašich položek. Můžete si je kdykoli vyzvednout.',
        open_pawn = 'Otevřít zastavárnu',
        sell = 'Prodat věci',
        sell_pawn = 'Prodat určité předměty a získat za ně peníze',
        melt = 'Rozpustit věci',
        melt_pawn = 'Rozpustit určité předměty a získat z nich materiály',
        melt_pickup = 'Vyzvednout rozstavené věci',
        pawn_closed = 'Zastavárna je zavřena. Přijďte mezi %{value}:00 a %{value2}:00',
        sell_items = 'Prodejní cena $%{value}',
        back = '⬅ Zpět',
        melt_item = 'Rozpusť %{value}',
        max = 'Maximální počet %{value}',
        submit = 'Rozpustit',
        melt_wait = 'Dej mi %{value} minut a rozpustím tvé věci',
    }
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end