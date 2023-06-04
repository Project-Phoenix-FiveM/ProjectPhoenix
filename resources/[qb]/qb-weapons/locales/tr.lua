local Translations = {
    error = {
        canceled = 'İptal edildi',
        max_ammo = 'Maks Cephane Kapasitesi',
        no_weapon = 'Silahın yok.',
        no_support_attachment = 'Bu silah bu eklentiyi desteklemiyor.',
        no_weapon_in_hand = 'Elinde silah yok.',
        weapon_broken = 'Bu silah kırık ve kullanılamaz.',
        no_damage_on_weapon = 'Bu silah hasar görmedi..',
        weapon_broken_need_repair = 'Silahınız bozuldu, tekrar kullanabilmeniz için tamir etmeniz gerekiyor..',
        attachment_already_on_weapon = 'Silahınızda zaten bir %{value} var.'
    },
    success = {
        reloaded = 'Şarjör değiştirildi'
    },
    info = {
        loading_bullets = 'Şarjör değiştiriliyor',
        repairshop_not_usable = 'Şu anda tamirhane kullanılabilir DEĞİL.',
        weapon_will_repair = 'Silahın tamir edilecek.',
        take_weapon_back = '[E] - Silahı Geri Al',
        repair_weapon_price = '[E] Silah Tamiri, ~g~$%{value}~w~',
        removed_attachment = 'Silahınızdan %{value} çıkardınız!',
        hp_of_weapon = 'Silahınızın dayanıklılığı'
    },
    mail = {
        sender = 'Tyrone',
        subject = 'Tamirat',
        message = '%{value} onarıldı, aynı yerden geri alabilirsin. <br><br> Peace out madafaka'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
