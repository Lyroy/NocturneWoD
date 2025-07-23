/datum/sprite_accessory/wings
	icon = 'icons/mob/clothing/wings.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings/is_not_visible(mob/living/carbon/human/H)
	return (!H.dna.features["wings"] || H.dna.features["wings"] == "None" || (H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(src, H.wear_suit.species_exception))))

/datum/sprite_accessory/wings_open
	icon = 'icons/mob/clothing/wings.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings_open/is_not_visible(mob/living/carbon/human/H)
	return (H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(src, H.wear_suit.species_exception)))

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE

/datum/sprite_accessory/wings_open/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34

/datum/sprite_accessory/wings/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/wings/gargoyle
	name = "Gargoyle"
	icon = 'code/modules/wod13/64x32.dmi'
	icon_state = "gargoyle"
	dimension_x = 64
	center = TRUE
	dimension_y = 32
	locked = TRUE
	use_static = TRUE
	color_src = 0

/datum/sprite_accessory/wings_open/gargoyle
	name = "Gargoyle"
	icon = 'code/modules/wod13/64x32.dmi'
	icon_state = "gargoyle"
	dimension_x = 64
	center = TRUE
	dimension_y = 32
	use_static = TRUE
	color_src = 0

/datum/sprite_accessory/wings/megamoth
	name = "Megamoth"
	icon_state = "megamoth"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/megamoth
	name = "Megamoth"
	icon_state = "megamoth"
	color_src = 0
	dimension_x = 96
	center = TRUE
	dimension_y = 32
