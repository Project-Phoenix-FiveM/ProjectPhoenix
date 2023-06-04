local Translations = {
    success = {
        success_message = "Sucesso",
        fuses_are_blown = "Os fusíveis foram queimados",
        door_has_opened = "A porta se abriu"
    },
    error = {
        cancel_message = "Cancelado",
        safe_too_strong = "Parece que a fechadura do cofre é muito forte...",
        missing_item = "Está faltando um item...",
        bank_already_open = "O banco já está aberto...",
        minimum_police_required = "Minimo de %{policia} policiais necessário",
        security_lock_active = "A trava de segurança está ativa, não é possível abrir a porta no momento",
        wrong_type = "%{receiver} não recebeu o tipo certo para o argumento '%{argument}'\ntipo recebido: %{receivedType}\nvalor recebido: %{receivedValue}\ntipo esperado: %{expected}",
        fuses_already_blown = "Os fusíveis já estão queimados...",
        event_trigger_wrong = "%{event}%{extraInfo} foi acionado quando algumas condições não foram atendidas, fonte: %{fonte}",
        missing_ignition_source = "Está faltando uma fonte de ignição"
    },
    general = {
        breaking_open_safe = "Abrindo o cofre...",
        connecting_hacking_device = "Conectando o dispositivo de hacking...",
        fleeca_robbery_alert = "Tentativa de assalto a banco Fleeca",
        paleto_robbery_alert = "Tentativa de assalto a banco Blaine County Savings",
        pacific_robbery_alert = "tentativa de assalto ao Pacific Standard Bank",
        break_safe_open_option_target = "Abrir cofre",
        break_safe_open_option_drawtext = "[E] Abre o cofre",
        validating_bankcard = "Validando cartão...",
        thermite_detonating_in_seconds = "Thermite está apagando em %{tempo} segundo(s)",
        bank_robbery_police_call = "10-90: Assalto a banco"
    }
}

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
