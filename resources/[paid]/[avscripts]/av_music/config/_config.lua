Music = {}
Music.Framework = "QBCore" -- QBCore or ESX
Music.MaxCDs = 20 -- Max CDs a player can burn at the same time, no one wants someone with 9999999 items.
Music.RecordLabels = {
    ['wuchang'] = { -- Job name, used for index key..
        job = 'wuchang', -- Job name
        label = "Wu Chang Records", -- How ppl see the label name in the Music APP.
        description = "Since 2019", -- Subheader for the music app.
        logo = "https://cdn.discordapp.com/attachments/819358910782898248/1050778444360855632/wuchang.png", -- The one showed in the music app 250x250px.
        color = "#d62225", -- Color for the background gradient, needs to be HEXA https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Colors/Color_picker_tool
        coords = { -- Used for the AddSong/BurnCD menu
            {x = -818.6, y = -718.89, z = 32.34, distance = 1.5}, -- You can add multiple coords, duplicate this line and change values
        }
    },
    ['mandem'] = { -- Job name, used for index key..
        job = 'mandem', -- Job name
        label = "MDM Records", -- How ppl see the label name in the Music APP.
        description = "Since 2021", -- Subheader for the music app 250x250px.
        logo = "https://cdn.discordapp.com/attachments/819358910782898248/1050772336405663824/mandem.png", -- The one showed in the music app
        color = "#1478ea", -- Color for the background gradient, needs to be HEXA https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Colors/Color_picker_tool
        coords = {  -- Used for the AddSong/BurnCD menu
            {x = 500.71, y = -75.17, z = 58.16, distance = 1.5}, -- You can add multiple coords, duplicate this line and change values
        }
    },
}