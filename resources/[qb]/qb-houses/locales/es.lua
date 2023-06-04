local Translations = {
    error = {
	["no_keys"] = "No tienes las llaves de la casa...",
        ["not_in_house"] = "¡No estás en una casa!",
        ["out_range"] = "Te has salido del rango",
        ["no_key_holders"] = "No se encontraron poseedores de llaves...",
        ["invalid_tier"] = "Nivel de casa no válido",
        ["no_house"] = "No hay ninguna casa cerca de ti",
        ["no_door"] = "No estás lo suficientemente cerca de la puerta...",
        ["locked"] = "¡La casa está cerrada!",
        ["no_one_near"] = "¡No hay nadie alrededor!",
        ["not_owner"] = "No eres dueño de esta casa.",
        ["no_police"] = "No hay policía presente...",
        ["already_open"] = "Esta casa ya está abierta..",
        ["failed_invasion"] = "Intento fallido, prueba de nuevo.",
        ["inprogress_invasion"] = "Alguien ya está trabajando en la puerta..",
        ["no_invasion"] = "Esta puerta no está abierta...",
        ["realestate_only"] = "Solo bienes raíces puede vender casas",
        ["emergency_services"] = "¡Esto solo es posible para los servicios de emergencia!",
        ["already_owned"] = "¡Esta casa ya pertenece a alguien!",
        ["not_enough_money"] = "No tienes suficiente dinero..",
        ["remove_key_from"] = "Se han eliminado las llaves de %{firstname} %{lastname}",
        ["already_keys"] = "¡Esta persona ya tiene las llaves de la casa!",
        ["something_wrong"] = "¡Algo salió mal, inténtalo de nuevo!",
    },
    success = {
	["unlocked"] = "¡La casa está desbloqueada!",
        ["home_invasion"] = "La puerta ahora está abierta.",
        ["lock_invasion"] = "Cerraste la casa otra vez...",
        ["recieved_key"] = "¡Has recibido las llaves de %{value}!"
    },
    info = {
	["door_ringing"] = "¡Alguien está tocando la puerta!",
        ["speed"] = "La velocidad es %{valor}",
        ["added_house"] = "Has agregado una casa: %{value}",
        ["added_garage"] = "Has agregado un garaje: %{value}",
        ["exit_camera"] = "Salir",
        ["house_for_sale"] = "Casa A La Venta",
        ["decorate_interior"] = "Decorar Interior",
        ["create_house"] = "Crear Casa (Solo Bienes Raíces)",
        ["price_of_house"] = "Precio de la casa",
        ["tier_number"] = "Nivel de la casa",
        ["add_garage"] = "Agregar Garaje (Solo Bienes Raíces)",
        ["ring_doorbell"] = "Tocar el timbre"
    },
    menu = {
	["house_options"] = "Opciones de casa",
        ["enter_house"] = "Entra en tu casa",
        ["give_house_key"] = "Dar llave de casa",
        ["exit_property"] = "Salir de la propiedad",
        ["front_camera"] = "Cámara frontal",
        ["back"] = "Atrás",
        ["remove_key"] = "Quitar llave",
        ["open_door"] = "Abrir puerta",
        ["view_house"] = "Ver Casa",
        ["ring_door"] = "Tocar timbre",
        ["exit_door"] = "Salir de la propiedad",
        ["open_stash"] = "Abrir Escondite",
        ["stash"] = "Escondite",
        ["change_outfit"] = "Cambiar atuendo",
        ["outfits"] = "Atuendos",
        ["change_character"] = "Cambiar personaje",
        ["characters"] = "Personajes",
	["enter_unlocked_house"] = "Entrar a la casa.",
        ["lock_door_police"] = "Puerta cerrada."
    },
    target = {
        ["open_stash"] = "[E] Abrir Stash",
        ["outfits"] = "[E] Cambiar de traje",
        ["change_character"] = "[E] Cambiar de personaje",
    },
    log = {
        ["house_created"] = "Casa Creada:",
        ["house_address"] = "**Dirección**: %{label}\n\n**Precio**: %{price}\n\n**Nivel**: %{tier}\n\n**Agente**: %{agent}",
        ["house_purchased"] = "Casa Comprada:",
        ["house_purchased_by"] = "**Dirección**: %{house}\n\n**Precio De Compra**: %{price}\n\n**Comprador**: %{firstname} %{lastname}"
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
