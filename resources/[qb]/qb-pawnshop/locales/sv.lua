local Translations = {
    error = {
        negative = 'Du försöker sälja ett negativt antal?',
        no_melt = 'Du gav mig inget att smälta ner...',
        no_items = 'Du har inte tillräckligt med prylar',
    },
    success = {
        sold = 'Du har sålt %{value} x %{value2} för $%{value3}',
        items_received = 'Du har tagit emot %{value} x %{value2}',
    },
    info = {
        title = 'Pantbank',
        subject = 'Smälter föremål',
        message = 'Vi är klar med att smälta ner dina föremål. Du kan komma och hämta upp dom när du har möjlighet.',
        open_pawn = 'Öppna Pantbanken',
        sell = 'Sälj saker',
        sell_pawn = 'Sälj saker till Pantbanken',
        melt = 'Smält föremål',
        melt_pawn = 'Öppna Smältbutiken',
        melt_pickup = 'Hämta upp nedsmälta föremål',
        pawn_closed = 'Pantbanken är stängd. Kom tillbaka mellan %{value}:00 - %{value2}:00',
        sell_items = 'Försäljningspris $%{value}',
        back = '⬅ Gå tillbaka',
        melt_item = 'Smält %{value}',
        max = 'Max antal %{value}',
        submit = 'Smält',
        melt_wait = 'Ge mig %{value} minuter så hinner jag smälta ner dina prylar',
    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end