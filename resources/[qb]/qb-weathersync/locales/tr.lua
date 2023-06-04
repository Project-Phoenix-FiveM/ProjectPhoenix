local Translations = {
    weather = {
        now_frozen = 'Hava durumu donduruldu.',
        now_unfrozen = 'Hava durumu dondurulmadı.',
        invalid_syntax = 'Geçersiz komut, doğru komut: /weather <havatipi> ',
        invalid_syntaxc = 'Geçersiz komut, yerine /weather <havatipi> kullan!',
        updated = 'Hava durumu güncellendi.',
        invalid = 'Geçersiz hava durumu türü, geçerli hava durumu türleri: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Geçersiz hava durumu türü, geçerli hava durumu türleri:: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Hava durumu %{value} olarak değişecek.',
        accessdenied = '/weather komutu erişimi reddedildi.',
    },
    dynamic_weather = {
        disabled = 'Dinamik hava durumu değişiklikleri artık devre dışı.',
        enabled = 'Dinamik hava durumu değişiklikleri artık etkinleştirildi.',
    },
    time = {
        frozenc = 'Zaman donduruldu.',
        unfrozenc = 'zaman dondurulmadı.',
        now_frozen = 'Zaman şimdi dondu.',
        now_unfrozen = 'Zaman artık donmuş değil.',
        morning = 'Saat sabaha ayarlandı.',
        noon = 'Saat öğleye ayarlandı.',
        evening = 'Saat akşama ayarlandı.',
        night = 'Saat geceye ayarlandı.',
        change = 'Zaman değişti %{value}:%{value2}.',
        changec = 'Zaman değişti: %{value}!',
        invalid = 'Geçersiz komut, doğru komut: /time <saat> <dakika> !',
        invalidc = 'Geçersiz komut. Yerine /time <saat> <dakika> kullan!',
        access = '/time komutu erişimi reddedildi.',
    },
    blackout = {
        enabled = 'Karartma etkinleştirildi.',
        enabledc = 'Karartma etkinleştirildi.',
        disabled = 'Karartma devre dışı.',
        disabledc = 'Karartma devre dışı.',
    },
    help = {
        weathercommand = 'Havayı değiştir.',
        weathertype = 'havatipi',
        availableweather = 'Mevcut tipler: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Zamanı değiştir.',
        timehname = 'saat',
        timemname = 'dakika',
        timeh = '0 - 23 arasında bir sayı',
        timem = '0 - 59 arasında bir sayı',
        freezecommand = 'Zamanı dondur / çöz.',
        freezeweathercommand = 'Dinamik hava durumu değişikliklerini etkinleştir/devre dışı bırak.',
        morningcommand = 'Saati 09:00\'a ayarlayın',
        nooncommand = 'Saati 12:00\'ye ayarla',
        eveningcommand = 'Saati 18:00\'e ayarla',
        nightcommand = 'Saati 23:00\'e ayarla',
        blackoutcommand = 'Karartma modunu aç/kapat.',
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

