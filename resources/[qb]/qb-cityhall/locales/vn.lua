local Translations = {
    error = {
        not_in_range = 'Bạn đang ở xa Tòa thị chính'
    },
    success = {
        recived_license = 'Bạn đã nhận %{value} với giá $50'
    },
    info = {
        new_job_app = 'Đơn xin việc của bạn đã gửi tới Tổng giám đốc (%{job})',
        bilp_text = 'Dịch vụ công',
        city_services_menu = '~g~E~w~ - Danh sách dịch vụ công',
        id_card = 'Thẻ công dân',
        driver_license = 'Bằng lái xe',
        weaponlicense = 'Bằng sử dụng vũ khí',
        new_job = 'Chúc mừng bạn đã nhận được công việc mới! (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Cảm ơn bạn đã ứng tuyển vào %(job).",
        jobAppMsg = "Thân chào %{gender} %{lastname}<br /><br />%{job} đã nhận được đơn xin việc của bạn.<br /><br />Tổng giám đốc đang xem xét yêu cầu của bạn và sẽ liên hệ với bạn để phỏng vấn trong thời gian sớm nhất.<br /><br />Một lần nữa, cảm ơn bạn đã nộp đơn ứng tuyển.",
        mr = 'Ông',
        mrs = 'Bà',
        sender = 'Toàn thị chính',
        subject = 'Yêu cầu học lái xe',
        message = 'Xin chào %{gender} %{lastname}<br /><br />Chúng tôi vừa nhận được một tin nhắn rằng ai đó muốn tham gia các bài học lái xe<br />Nếu bạn muốn tham gia dạy học khóa học này, hãy liên hệ:<br />Tên: <strong>%{firstname} %{lastname}</strong><br />Số điện thoại: <strong>%{phone}</strong><br/><br/>Thân,<br />Tòa thị chính Los Santos',
    }
}

if GetConvar('qb_locale', 'en') == 'vn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
