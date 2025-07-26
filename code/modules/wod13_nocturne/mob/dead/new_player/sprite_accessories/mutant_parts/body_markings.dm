// legacy body markings for lizards

/datum/sprite_accessory/body_markings
	icon = 'icons/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/body_markings/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/body_markings/dtiger
	name = "Dark Tiger Body"
	icon_state = "dtiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/ltiger
	name = "Light Tiger Body"
	icon_state = "ltiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/lbelly
	name = "Light Belly"
	icon_state = "lbelly"
	gender_specific = 1

// REAL body markings

/datum/sprite_accessory/mam_body_markings
	// DO NOT FUCKING CHANGE THIS!!!!!!!!
	// EVERY SINGLE MARKING is matrixed, set per-limb matrix color sources in covered_limbs
	color_src = MATRIXED

	gender_specific = FALSE
	icon = 'icons/mob/sprite_accessories/mam_markings.dmi'
	matrixed_sections = MATRIX_ALL // this value is used if there is no value in covered_limbs, don't rely on it, it's a backup value

	/// associative list of limbs to per-limb matrixed sections (i.e. "Head" = MATRIX_RED, "Chest" = MATRIX_GREEN, etc)
	var/list/covered_limbs = list("Head", "Chest", "Left Leg", "Right Leg", "Left Arm", "Right Arm")

/datum/sprite_accessory/mam_body_markings/plain
	name = "Plain"
	icon_state = "plain"
	icon = 'icons/mob/sprite_accessories/mam_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED, "Chest" = MATRIX_RED, "Left Leg" = MATRIX_RED, "Right Leg" = MATRIX_RED, "Left Arm" = MATRIX_RED, "Right Arm" = MATRIX_RED)
