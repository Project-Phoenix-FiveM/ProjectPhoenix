local Translations = {
    store = {
        barber = "Barbershop",
        surgeon = "Plastic Surgeon",
        clothing = "Clothing store",
        outfitchanger = "Outfit Changer"
    },

    outfits = {
        roomOutfits = "Presets",
        myOutfits = "My Outfits",
        character = "Clothing",
        accessoires = "Accessories"
    },

    menu = {
        hair = "Hair",
        character = "Clothing",
        accessoires = "Accessories",
        features = "Features"
    },

    ui = {
        select = "Select",
        delete = "Delete",
        select_outfit = "Selecionar Outfit",
        player_model = "Player Model",
        model = "Model",
        mother = "Mother",
        father = "Father",
        texture = "Texture",
        type = "Type",
        item = "Item",
        skin_color = "Skin Color",
        parent_mixer = "Parent Mixer",
        shape_mix = "Shape Mix",
        skin_mix = "Skin Mix",
        arms = "Arms",
        undershirt = "Undershirt/Belts",
        color = "Color",
        jacket = "Jackets/Tops",
        vests = "Vests",
        decals = "Decals",
        acessory = "Neck Accessories",
        bags = "Bags",
        pants = "Pants",
        shoes = "Shoes",
        eye_color = "Eye Color",
        moles = "Moles/Freckles",
        opacity = "Opacity",
        nose_width = "Nose Width",
        width = "Width",
        nose_peak_height = "Nose Peak Height",
        height = "Height",
        nose_peak_length = "Nose Peak Length",
        length = "Length",
        nose_bone_height = "Nose Bone Height",
        nose_peak_lowering = "Nose Peak Lowering",
        lowering = "Lowering",
        nose_bone_twist = "Nose Bone Twist",
        twist = "Twist",
        eyebrow_height = "Eyebrow Height",
        eyebrow_depth = "Eyebrow Depth",
        depth = "Depth",
        cheeks_height = "Cheeks Height",
        cheeks_width = "Cheeks Width",
        cheeks_depth = "Cheeks Depth",
        eyes_opening = "Eyes Opening",
        opening = "Opening",
        lips_thickness = "Lips Thickness",
        thickness = "Thickness",
        jaw_bone_width = "Jaw Bone Width",
        jaw_bone_length = "Jaw Bone Length",
        chin_height = "Chin Bone Height",
        chin_width = "Chin Bone Width",
        butt_chin  ="Butt Chin",
        size = "Size",
        neck_thickness = "Neck Thickness",
        ageing = "Ageing",
        hair = "Hair",
        eyebrow = "Eyebrows",
        facial_hair = "Facial Hair",
        lipstick = "Lipstick",
        blush = "Blush",
        makeup = "Makeup",
        mask = "Masks",
        hat = "Hats",
        glasses = "Glasses",
        ear_accessories = "Ear Accessories",
        watch = "Watches",
        bracelet = "Bracelets",
        btn_confirm = "Confirm",
        btn_cancel = "Cancel",
        btn_saveOutfit = "Save Outfit",
        outfit_name = "Outfit Name"
    },

    notify = {
        error_bracelet = "You can't remove your ankle bracelet ...",
        info_deleteOutfit = "You have deleted your %{outfit} outfit!"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})