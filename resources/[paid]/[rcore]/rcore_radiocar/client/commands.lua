AddEventHandler("xsound:streamerMode", function(value)
    disableMusic = value

    if value then
        for k, v in pairs(soundInfo) do
            Destroy(v.id)
        end
    end
end)