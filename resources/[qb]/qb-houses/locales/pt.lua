local Translations = {
    error = {
        ["no_keys"] = "Não tens as chaves desta casa..",
        ["not_in_house"] = "Não estás numa casa!",
        ["out_range"] = "Estás muito longe",
        ["no_key_holders"] = "Não foram encontrados porta chaves..",
        ["invalid_tier"] = "Tier da casa inválido",
        ["no_house"] = "Não existem casas ao teu redor..",
        ["no_door"] = "Não existem portas ao teu redor..",
        ["locked"] = "Casa trancada!",
        ["no_one_near"] = "Ninguém perto!",
        ["not_owner"] = "Não és o proprietário desta casa.",
        ["no_police"] = "Agentes da autoridade insuficientes..",
        ["already_open"] = "Esta casa já está aberta..",
        ["failed_invasion"] = "Falha ao forçar a fechadura! Tenta novamente!",
        ["inprogress_invasion"] = "Já existe alguém a forçar a fechadura..",
        ["no_invasion"] = "Esta fechadura não foi forçada..",
        ["realestate_only"] = "Disponível apenas para agentes imobiliários",
        ["emergency_services"] = "Disponível apenas para unidades de emergência!",
        ["already_owned"] = "Esta casa já tem proprietário!",
        ["not_enough_money"] = "Não tens dinheiro suficiente..",
        ["remove_key_from"] = "Chaves removidades de %{firstname} %{lastname}",
        ["already_keys"] = "Esta pessoa já tem as chaves desta casa!",
        ["something_wrong"] = "Algo de errado aconteceu. Tenta novamente!",
    },
    success = {
        ["unlocked"] = "A casa está aberta!",
        ["home_invasion"] = "A porta está agora aberta.",
        ["lock_invasion"] = "Trancaste a porta da casa novamente..",
        ["recieved_key"] = "Recebeste as chaves da casa %{value}!"
    },
    info = {
        ["door_ringing"] = "Alguém tocou à campainha!",
        ["speed"] = "Velocidade: %{value}",
        ["added_house"] = "Adicionaste uma casa: %{value}",
        ["added_garage"] = "Adicionaste uma garagem: %{value}",
        ["exit_camera"] = "Sair da câmera",
        ["house_for_sale"] = "Casa à venda",
        ["decorate_interior"] = "Decorar Interior",
        ["create_house"] = "Criar casa (somente imóveis)",
        ["price_of_house"] = "Preço da casa",
        ["tier_number"] = "Número do nível da casa",
        ["add_garage"] = "Adicionar garagem residencial (somente imóveis)",
        ["ring_doorbell"] = "Tocar a campainha"
    },
    menu = {
        ["house_options"] = "Opções Da Casa",
        ["enter_house"] = "Entrar Em Casa",
        ["give_house_key"] = "Dara Chaves Da Casa",
        ["exit_property"] = "Sair De Casa",
        ["front_camera"] = "Câmera Da Frente",
        ["back"] = "Voltar",
        ["remove_key"] = "Remover Chave",
        ["open_door"] = "Abrir Porta",
        ["view_house"] = "Ver Casa",
        ["ring_door"] = "Tocar À Campainha",
        ["exit_door"] = "Sair De Casa",
        ["open_stash"] = "Abrir Baú",
        ["stash"] = "Baú",
        ["change_outfit"] = "Alterar Outfit",
        ["outfits"] = "Outfits",
        ["change_character"] = "Alterar Personagem",
        ["characters"] = "Personagens",
        ["enter_unlocked_house"] = "Entrar Na Casa",
        ["lock_door_police"] = "Trancar Porta"
    },
    log = {
        ["house_created"] = "Casa criada:",
        ["house_address"] = "**Endereço**: %{label}\n\n**Preço de Anúncio**: %{price}\n\n**Nível**: %{tier}\n\n**Agente de Anúncio**: %{agent}",
        ["house_purchased"] = "Casa comprada:",
        ["house_purchased_by"] = "**Endereço**: %{house}\n\n**Preço de compra**: %{price}\n\n**Comprador**: %{firstname} %{lastname}"
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
