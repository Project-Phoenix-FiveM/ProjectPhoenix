local Translations = {
    labels = {
        engine = 'Motor',
        bodsy = 'Carroçaria',
        radiator = 'Radiador',
        axle = 'Eixo de Transmissão',
        brakes = 'Calços',
        clutch = 'Embraiagem',
        fuel = 'Tanque de combustível',
        sign_in = 'Logar',
        sign_off = 'Desconectar',
        o_stash = '[E] Abrir Cofre',
        h_vehicle = '[E] Esconder Veículo',
        g_vehicle = '[E] Entrar no Veículo',
        o_menu = '[E] Abrir Menu',
        work_v = '[E] Trabalhar no veículo',
        progress_bar = 'A reparar...',
        veh_status = 'Estado do Veículo:',
        job_blip = 'Oficina Mecânica',
    },

    lift_menu = {
        header_menu = 'Opções Veículo',
        header_vehdc = 'Desconectar Veículo',
        desc_vehdc = 'Desacopla Veículo no Elevador',
        header_stats = 'Verificar Estado',
        desc_stats = 'Verifica o Estado do Veículo',
        header_parts = 'Peças',
        desc_parts = 'Reparar peças',
        c_menu = '⬅ Fechar Menu'
    },

    parts_menu = {
        status = 'Estado: ',
        menu_header = 'Menu Peças',
        repair_op = 'Reparar:',
        b_menu = '⬅ Voltar Menu',
        d_menu = 'Voltar para Menu Peças',
        c_menu = '⬅ Fechar Menu'
    },

    nodamage_menu = {
        header = 'Sem Dano',
        bh_menu = 'Voltar',
        bd_menu = 'Peças não danificada!',
        c_menu = '⬅ Fechar Menu'
    },

    notifications = {
        not_enough = 'Não tem suficiente',
        not_have = 'Não possui',
        not_materials = 'Não existem materiais suficientes no cofre',
        rep_canceled = 'Reparação cancelada',
        repaired = 'foi reparado(a)!',
        uknown = 'Estado desconhecido',
        not_valid = 'Veículo não válido',
        not_close = 'Não se encontra perto do veículo!',
        veh_first = 'Precisa de estar dentro do veículo!',
        outside = 'Precisa de estar fora do veículo!',
        wrong_seat = 'Não é o condutor ou encontra-se numa bicicleta!',
        not_vehicle = 'Não se encontra num veículo!',
        progress_bar = 'A reparar..',
        process_canceled = 'Proccesso cancelado',
        not_part = 'Peça inválida!',
        partrep =' %{value} reparado(a)!',
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
