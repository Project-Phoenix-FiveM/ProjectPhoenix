local Translations = {
    error = {
        process_canceled = "Proceso cancelado",
        plant_has_died = "La planta a muerto. Presione ~r~ E ~w~ para remover planta.",
        cant_place_here = "No se puede colocar aquí",
        not_safe_here = "No es seguro aquí, prueba en tu casa",
        not_need_nutrition = "La planta no necesita nutrición",
        this_plant_no_longer_exists = "¿Esta planta ya no existe?",
        house_not_found = "Casa no encontrada",
        you_dont_have_enough_resealable_bags = "No tiene suficientes bolsas",
    },
    text = {
        sort = 'Orden:',
        harvest_plant = 'Presione ~g~ E ~w~ para cosechar la planta.',
        nutrition = "Nutrición:",
        health = "Salud:",
        harvesting_plant = "Cosechando planta",
        planting = "Plantando",
        feeding_plant = "Alimentado planta",
        the_plant_has_been_harvested = "La planta ha sido cosechada",
        removing_the_plant = "Quitando planta",
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
