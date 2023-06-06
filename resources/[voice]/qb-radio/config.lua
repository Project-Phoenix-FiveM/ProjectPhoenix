Config = {}

Config.keyBind = {
    useRadio = "CAPS",
    openRadio = "F7",
    volUp1 = "PAGEUP",
    radioVolDown = "PAGEDOWN",
    RadioChannelUp = "F9",
    RadioChannelDown = "F10"
}

Config.RestrictedChannels = {
    [1] = {
        police = true,
        ambulance = true
    },
    [2] = {
        police = true,
        ambulance = true
    },
    [3] = {
        police = true,
        ambulance = true
    },
    [4] = {
        police = true,
        ambulance = true
    },
    [5] = {
        police = true
    },
    [6] = {
        police = true
    },
    [7] = {
        police = true
    },
    [8] = {
        police = true
    },
    [9] = {
        police = true,
        judge = true,
        court = true
    },
}

Config.MaxFrequency = 500

Config.messages = {
    ["not_on_radio"] = "You're not connected to a signal",
    ["on_radio"] = "You're already connected to this signal",
    ["joined_to_radio"] = "You're connected to: ",
    ["restricted_channel_error"] = "You are not allow to connect to this signal!",
    ["invalid_radio"] = "This frequency is not available.",
    ["you_on_radio"] = "You're already connected to this channel",
    ["you_leave"] = "You left the channel.",
    ['volume_radio'] = 'New volume ',
    ['decrease_radio_volume'] = 'The radio is already set to maximum volume',
    ['increase_radio_volume'] = 'The radio is already set to the lowest volume',
    ['increase_decrease_radio_channel'] = 'New channel ',
}
