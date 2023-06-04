local Translations = {
    error = {
        ["already_mission"] = "คุณกำลังทำภารกิจจาก NPC อยู่แล้ว",
        ["not_in_taxi"] = "คุณไม่ได้อยู่ในรถแท็กซี่",
        ["missing_meter"] = "รถคันนี้ไม่มีมิเตอร์แท็กซี่",
        ["no_vehicle"] = "คุณไม่ได้อยู่ในยานพาหนะ",
        ["not_active_meter"] = "มิเตอร์แท็กซี่ไม่ทำงาน",
        ["no_meter_sight"] = "ไม่มีมิเตอร์แท็กซี่ในระยะสายตา",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "ปล่อยคนลง",
        ["npc_on_gps"] = "มีการระบุ NPC บน GPS ของคุณ",
        ["go_to_location"] = "นำ NPC ไปยังตำแหน่งที่กำหนด",
        ["vehicle_parking"] = "กด [E] เพื่อจอดรถ",
        ["job_vehicles"] = "กด [E] เพื่อใช้รถทำงาน",
        ["drop_off_npc"] = "กด [E] เพื่อปล่อย NPC ลง",
        ["call_npc"] = "กด [E] เรียก NPC",
        ["blip_name"] = "ดาวน์ทาวน์แค็บ",
        ["taxi_label_1"] = "แท็กซี่มาตรฐาน",
        ["no_spawn_point"] = "หาสถานที่ไปเอารถแท็กซี่ไม่ได้",
        ["taxi_returned"] = "ที่จอดแท็กซี่"
    },
    menu = {
        ["taxi_menu_header"] = "รถแท็กซี่",
        ["close_menu"] = "⬅ ปิดเมนู",
        ['boss_menu'] = "เมนูผู้นำ"
    }
}

if GetConvar('qb_locale', 'en') == 'th' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
