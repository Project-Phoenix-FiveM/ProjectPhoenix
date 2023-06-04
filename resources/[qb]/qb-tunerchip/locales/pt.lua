local Translations = {
    success = {
        this_vehicle_has_been_tuned = "Este veículo foi ajustado",
    },
    text = {
        this_is_not_the_idea_is_it = "Esta não é ideia, nao é?",
        connecting_nos = "Carregando o NOS...",
    },
    error = {
        tunerchip_vehicle_tuned = "TunerChip v1.05: Veículo tunado!",
        this_vehicle_has_not_been_tuned = "Este veículo foi tunado",
        no_vehicle_nearby = "Não há nenhum veículo próximo",
        tunerchip_vehicle_has_been_reset = "TunerChip v1.05: O veículo foi resetado!",
        you_are_not_in_a_vehicle = "Você não está em um veículo",
        you_cannot_do_that_from_this_seat = "Você não pode fazer isso deste assento!",
        you_already_have_nos_active = "Você já tem NOS ativo",
        canceled = "Cancelado",
    },
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end
