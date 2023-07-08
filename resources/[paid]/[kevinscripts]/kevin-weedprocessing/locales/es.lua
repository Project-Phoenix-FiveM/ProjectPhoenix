local Translations = {
    success = {
        dried_ready = 'Plantas secas listas para recolectar',
        watered = 'Planta regada.',
        fertilized = 'Planta fertilizada.',
    },
    blip = {
        dried_blip = 'Plantas de malas hierbas secas',
    },
    progressbar = {
        handing = 'Plantas Colgantes',
        plants_drying = 'Secado de plantas, avisaré cuando esté listo.',
        reaping = 'Cosecha de cosecha',
        cleaning = 'Cleaning Buds',
        planting = 'Bastoncillos de limpieza',
        packing_cone = 'Cono de embalaje',
        removing = 'Eliminando...',
        watering = 'Riego...',
        fertilizing = 'Fertilizando...',
        refilling = 'Recarga',
    },
    warning = {
        insufficentnuggets = 'No tienes suficientes pepitas...',
        no_cones = 'You don\'t have any cones',
        empty_jar = 'No tienes conos',
        empty_bucket = '¿El cubo está de alguna manera vacío?',
        bottle_exceed = 'No puedes embotellar tantos..',
        insufficentamount = 'No tienes tantos',
        unselected = 'No tienes nada para esto..',
        soil_unsuitable = 'El suelo no se ve bien para plantar..',
        no_water = 'No tienes ninguna fuente de agua..',
        no_food = 'No tienes abono..',
        can_empty = 'Lata se ve vacía',
        not_inwater = 'No estas en el agua',
        can_full = 'La lata parece estar llena',
    },
    target = {
        dry_weed = 'Hierba seca',
        collect_bucket = 'Recoger cubo',
        check = 'Controlar',
        harvest = 'Planta de Cosecha',
        water = 'Planta de agua',
        fertilize = 'Fertilizar planta',
        destroy = 'Destruir planta',
        burn = 'Quemar plantagm.lua',
    },
    status = {
        dead = 'Muerto',
        alive = 'Vivo',
    },
    input = {
        select_plant = 'Selecciona la planta a secar',
        select_nugget = 'Seleccionar nugget para embotellar',
        item = 'Artículo',
        dry_amount = 'Cantidad a secar',
        bottle_amount = 'Cantidad a botella',
        max = ' (Máx.: %{maxamount})',
    },
    menu = {
        plant = 'Planta : %{seedname}',
        status = 'Estado de la planta: %{status}',
        stage = 'Etapa de la planta: %{stage} ',
        health = 'Sanidad Vegetal: %{health}',
        food = 'Alimentos de origen vegetal: %{food}',
        water = 'agua de la planta: %{water}',
        progress = 'Progreso de la planta: %{progress}',
    },
    cancel = {
        cancelled = 'Cancelado'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})