local Translations = {
    labels = {
        engine = 'Motor',
        bodsy = 'Caroserie',
        radiator = 'Radiator',
        axle = 'Cutie de viteze',
        brakes = 'Sistem de franare',
        clutch = 'Ambreiaj',
        fuel = 'Rezervor',
        sign_in = 'Intra in tura',
        sign_off = 'Iesi din tura',
        o_stash = '[E] Deschide depozit',
        h_vehicle = '[E] Parcheaza vehicul',
        g_vehicle = '[E] Foloseste vehicul',
        o_menu = '[E] Deschide meniul',
        work_v = '[E] Lucreaza la vehicul',
        progress_bar = 'Reparam ...',
        veh_status = 'Status vehicul:',
        job_blip = 'Mecanic auto',
    },
  
    lift_menu = {
        header_menu = 'Optiuni vehicul',
        header_vehdc = 'Deconecteaza vehicul',
        desc_vehdc = 'Scoate vehiculul de pe lift',
        header_stats = 'Verifica statut',
        desc_stats = 'Verifica vehiculul',
        header_parts = 'Verifica componentele',
        desc_parts = 'Repara componente',
        c_menu = '⬅ Inchide meniul',
    },
  
    parts_menu = {
        status = 'Statut: ',
        menu_header = 'Meniu componente',
        repair_op = 'Repara:',
        b_menu = '⬅ Inapoi',
        d_menu = 'Inapoi la componente',
        c_menu = '⬅ Inchide meniul'
    },
  
      nodamage_menu = {
        header = 'No Damage',
        bh_menu = 'Back Menu',
        bd_menu = 'There Is No Damage To This Part!',
        c_menu = '⬅ Close Menu'
    },
  
      notifications = {
        not_enough = 'Nu ai suficient',
        not_have = 'Nu ai',
        not_materials = 'Nu ai suficiente materiale in depozit',
        rep_canceled = 'Reparare anulata',
        repaired = 'a fost reparat!',
        uknown = 'Statut necunoscut',
        not_valid = 'Nu este un vehicul valid',
        not_close = 'Nu esti suficient de aproape de vehicul',
        veh_first = 'Trebuie sa fi in vehicul mai intai',
        outside = 'Trebuie sa fi inafara vehiculului',
        wrong_seat = 'Nu esti sofer, sau esti pe o bicicleta',
        not_vehicle = 'Nu esti intr-un vehicul',
        progress_bar = 'Se repara vehiculul...',
        process_canceled = 'Procesul a fost anulat',
        not_part = 'Nu este un part valid',
        partrep ='Piesa %{value} a fost reparata!',
    }
  }

  if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
