local webhook = "Your_Discord_Webhook"

function sendToDiscord(data)
    PerformHttpRequest(webhook, function() end, 'POST', json.encode({ username = 'AV Restaurants', embeds = data}), { ['Content-Type'] = 'application/json' })
end