RegisterNetEvent('av_restaurant:cashierMenu')
AddEventHandler('av_restaurant:cashierMenu', function(zone,data)
    lib.registerContext({
        id = 'av_restaurants:cashierMenu',
        title = "Total: $"..data['amount'],
        description = data['notes'],
        options = {
            {
                title = "Pay with Cash",
                serverEvent = "av_restaurant:confirmPay",
                args = {
                    zone = zone,
                    type = Config.CashAccountName,
                    society = data['society']
                }
            },
            {
                title = "Pay with Bank",
                serverEvent = "av_restaurant:confirmPay",
                args = {
                    zone = zone,
                    type = 'bank',
                    society = data['society']
                }
            }
        },
    })
    lib.showContext('av_restaurants:cashierMenu')
end)