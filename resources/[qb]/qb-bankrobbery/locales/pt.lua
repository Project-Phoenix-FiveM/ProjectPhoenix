local Translations = {
    success = {
        success_message = "Sucesso",
        fuses_are_blown = "Os fusiveis foram queimados.",
        door_has_opened = "A porta abriu"
    },
    error = {
        cancel_message = "Cancelado",
        safe_too_strong = "Parece que a fechadura do cofre é muito forte",
        missing_item = "Precisa de um item...",
        bank_already_open = "O banco já se encontra aberto...",
        minimum_police_required = "Minimo de %{police} policia necessário",
        security_lock_active = "A trava de segurança está ativa, não é possível abrir a porta no momento",
        wrong_type = "%{receiver} did not receive the right type for argument '%{argument}'\nreceived type: %{receivedType}\nreceived value: %{receivedValue}\n expected type: %{expected}",
        fuses_already_blown = "The fuses are already blown...",
        event_trigger_wrong = "%{event}%{extraInfo} was triggered when some conditions weren't met, source: %{source}",
        missing_ignition_source = "Precisa de uma fonte de ignição"
    },
    general = {
        breaking_open_safe = "A arrombar o cofre...",
        connecting_hacking_device = "A ligar ao dispositivo de hacking...",
        fleeca_robbery_alert = "Tentativa de assalto ao banco Fleeca",
        paleto_robbery_alert = "Tentativa de assalto ao banco em Paleto",
        pacific_robbery_alert = "Tentativa de assalto ao Banco Principal",
        break_safe_open_option_target = "[E]Abrir o cofre",
        break_safe_open_option_drawtext = "[E] Arrombar o cofre",
        validating_bankcard = "A validar o cartão...",
        thermite_detonating_in_seconds = "A termite vai explodir em %{time} segundo(s)",
        bank_robbery_police_call = "10-90: Assalto ao banco"
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
