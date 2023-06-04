local Translations = {
    error = {
        process_canceled = "Annulé",
        plant_has_died = "La plante est morte. Appuyez sur ~r~ E ~w~ pour la retirer.",
        cant_place_here = "Impossible de placer ici",
        not_safe_here = "Ce n'est pas sûr ici, essayez dans votre maison.",
        not_need_nutrition = "Cette plante n'a pas besoin d'engrais",
        this_plant_no_longer_exists = "Cette plante n'existe plus?",
        house_not_found = "Maison introuvable",
        you_dont_have_enough_resealable_bags = "Vous n'avez pas assez de sacs plastiques",
    },
    text = {
        sort = 'Type:',
        harvest_plant = 'Appuyez sur ~g~ E ~w~ pour recolter la plante.',
        nutrition = "Engrais:",
        health = "État:",
        harvesting_plant = "Récolte la plante..",
        planting = "Plante..",
        feeding_plant = "Donne de l'engrais",
        the_plant_has_been_harvested = "La plante à été récoltée",
        removing_the_plant = "Retire la plante..",
    },
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
