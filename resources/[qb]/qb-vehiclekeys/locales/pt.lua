local Translations = {
    notify = {
        ydhk = 'Não tem as chaves deste veículo.',
        nonear = 'Não há ninguém por perto para entregar as chaves',
        vlock = 'Veículo trancado!',
        vunlock = 'Veículo destrancado!',
        vlockpick = 'Conseguiu abrir a fechadura da porta!',
        fvlockpick = 'Não conseguiu encontrar as chaves e agora sente-se frustrado.',
        vgkeys = 'Entregou as chaves',
        vgetkeys = 'Recebeu as chaves do veículo!',
        fpid = 'Preencha o ID do jogador e a matricula',
        cjackfail = 'Falha no roubo do veículo!',
        vehclose = 'Nenhum veículo por perto!',
    },
    progress = {
        takekeys = 'Tirando as chaves do corpo...',
        hskeys = 'Procurando as chaves do veículo...',
        acjack = 'Tentativa de roubo de veículo...',
    },
    info = {
        skeys = '~g~[H]~w~ - Procurar as chaves',
        tlock = 'Trancar/Destrancar Veículo',
        palert = 'Roubo de veículo em andamento. Tipo: ',
        engine = 'Ligar/Desligar Motor',
    },
    addcom = {
        givekeys = 'Entregue as chaves a alguém. Se não houver identificação, entregue à pessoa mais próxima ou a todos no veículo.',
        givekeys_id = 'id',
        givekeys_id_help = 'ID do jogador',
        addkeys = 'Adicionar chaves a um veículo para alguém',
        addkeys_id = 'id',
        addkeys_id_help = 'ID do jogador',
        addkeys_plate = 'Matricula',
        addkeys_plate_help = 'Matricula',
        rkeys = 'Remover as chaves de um veículo para alguém.',
        rkeys_id = 'id',
        rkeys_id_help = 'ID do jogador',
        rkeys_plate = 'Matricula',
        rkeys_plate_help = 'Matricula',
    }

}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
