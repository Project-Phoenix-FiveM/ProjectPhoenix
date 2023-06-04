local Translations = {
    error = {
        negative = '沒有更多的物品可以販售?',
        no_melt = '您沒有什麼東西可以熔解...',
        no_items = '物品不足',
    },
    success = {
        sold = '販賣了 %{value} 個 %{value2} 得款 $%{value3}',
        items_received = '收到了 %{value} x %{value2}',
    },
    info = {
        title = '當舖',
        subject = '熔解物品',
        message = '我們已經將您的物品熔解完成, 您隨時可以來取.',
        open_pawn = '與%{value}交易',
        sell = '典當物品',
        sell_pawn = '將物品賣給當舖',
        melt = '熔解物品',
        melt_pawn = '將物品熔解',
        melt_pickup = '領取熔解物品',
        pawn_closed = '當舖已打烊. 請在 %{value}:00 AM - %{value2}:00 PM 之間來訪',
        sell_items = '售價 $%{value}',
        back = '⬅ 返回',
        melt_item = '熔解 %{value}',
        max = '最大數量 %{value}',
        submit = '熔解',
        melt_wait = '給我 %{value} 分鐘, 我會將您委託的物品熔解',
    }
}

if GetConvar('qb_locale', 'en') == 'tc' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
