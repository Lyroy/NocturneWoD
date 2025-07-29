/datum/sprite_accessory/frills
	icon = 'icons/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_ADJ_LAYER)
	mutant_part_string = "frills"

/datum/sprite_accessory/frills/is_not_visible(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["frills"] || H.dna.features["frills"] == "None" || H.head && (H.head.flags_inv & HIDEEARS) || !HD || HD.status == BODYPART_ROBOTIC)

/datum/sprite_accessory/frills/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/frills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/frills/mam_frills
	icon = 'icons/mob/sprite_accessories/frills/frills.dmi'
	relevant_layers = list(BODY_ADJ_LAYER)
	color_src = MATRIXED

/datum/sprite_accessory/frills/mam_frills/is_not_visible(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["mam_frills"] || H.dna.features["mam_frills"] == "None" || H.head && (H.head.flags_inv & HIDEEARS) || !HD || HD.status == BODYPART_ROBOTIC)

/datum/sprite_accessory/frills/mam_frills/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/frills/mam_frills/aqua
	name = "Aquatic"
	icon_state = "aqua"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/big
	name = "Big"
	icon_state = "big"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/cobrahood
	name = "Cobra"
	icon_state = "cobrahood"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/frills/mam_frills/cobraears
	name = "Cobra (Ears)"
	icon_state = "cobraears"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/frills/mam_frills/divinity
	name = "Divinity"
	icon_state = "divinity"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/earlike
	name = "Earlike"
	icon_state = "earlike"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/frills/mam_frills/earlike_angled
	name = "Earlike (Angled)"
	icon_state = "earlike_angled"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/earlike_thick
	name = "Earlike (Thick)"
	icon_state = "earlike_thick"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/horns
	name = "Horns"
	icon_state = "horns"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/hornsdouble
	name = "Horns (Double)"
	icon_state = "hornsdouble"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/short
	name = "Short"
	icon_state = "short"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/simple
	name = "Simple"
	icon_state = "simple"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/split
	name = "Split"
	icon_state = "split"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/split_big
	name = "Split (Big)"
	icon_state = "split_big"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/frills/mam_frills/split_slim
	name = "Split (Slim)"
	icon_state = "split_slim"
	matrixed_sections = MATRIX_RED
