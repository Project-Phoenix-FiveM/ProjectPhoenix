local Translations = {
    success = {
        this_vehicle_has_been_tuned = "Este vehículo ha sido ajustado",
    },
    text = {
        this_is_not_the_idea_is_it = "Esta no es la idea, ¿verdad?",
        connecting_nos = "Conectando NOS...",
    },
    error = {
        tunerchip_vehicle_tuned = "TunerChip v1.05: ¡Vehículo tuneado!",
        this_vehicle_has_not_been_tuned = "Este vehículo no ha sido afinado",
        no_vehicle_nearby = "No hay vehiculos cerca",
        tunerchip_vehicle_has_been_reset = "TunerChip v1.05: ¡El vehículo ha sido reiniciado!",
        you_are_not_in_a_vehicle = "No estas en un auto",
        you_cannot_do_that_from_this_seat = "¡No puedes hacer eso desde este asiento!",
        you_already_have_nos_active = "Ya tiene el NOS activo",
        canceled = "Cancelado",
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end
