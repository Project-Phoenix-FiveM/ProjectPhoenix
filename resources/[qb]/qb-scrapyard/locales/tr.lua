local Translations = {
    error = {
        smash_own = "Sahibi olan bir aracı parçalayamazsınız.",
        cannot_scrap = "Bu Araç Hurdaya Çıkamaz.",
        not_driver = "Sen Sürücü Değilsin",
        demolish_vehicle = "Araç Parçalamanıza İzin Verilmiyor",
        canceled = "İptal edildi",
    },
    text = {
        scrapyard = 'Hurda Alanı',
        disassemble_vehicle = '[E] - Aracı Sök',
        disassemble_vehicle_target = 'Aracı Sök',
        email_list = "[E] - Araç Listesi Gönder",
        email_list_target = "Araç Listesi Gönder",
        demolish_vehicle = "Aracı Parçala",
    },
    email = {
        sender = "Turner’s Araç Parçalama",
        subject = "Araç Listesi",
        message = "Sadece Birkaç Aracı Parçalayabilirsiniz.<br />Beni Rahatsız Etmediğin sürece Parçaladığın Her Şeyi Kendin Alabilirsin.<br /><br /><strong>Araç Listesi:</strong><br />",
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
