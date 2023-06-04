local Translations = {
    error = {
        minimum_store_robbery_police = "Pas assez de policiers (%{MinimumStoreRobberyPolice} Requis)",
        not_driver = "Vous n'êtes pas le conducteur",
        process_canceled = "Annulé..",
        you_broke_the_lock_pick = "Vous avez cassé l'outil de crochetage",
    },
    text = {
        the_cash_register_is_empty = "La caisse est vide",
        try_combination = "~g~E~w~ - Essayer la combinaison",
        safe_opened = "Coffre-fort ouvert",
        emptying_the_register= "Vide la caisse..",
        safe_code = "Code du Coffre-fort: "
    },
    email = {
        shop_robbery = "10-31 | Braquage de superette",
        someone_is_trying_to_rob_a_store = "Quelqu'un essaie de braquer un magasin à %{street} (ID Caméra: %{cameraId1})",
        storerobbery_progress = "Braquage de superette en cours"
    },
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
