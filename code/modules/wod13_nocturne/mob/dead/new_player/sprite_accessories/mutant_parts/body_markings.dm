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
	matrixed_sections = MATRIX_ALL // this value is used if there is no value in covered_limbs, don't rely on it, it's a backup value

	/// associative list of limbs to per-limb matrixed sections (i.e. "Head" = MATRIX_RED, "Chest" = MATRIX_GREEN, etc)
	var/list/covered_limbs = list("Head", "Chest", "Left Leg", "Right Leg", "Left Arm", "Right Arm")

/datum/sprite_accessory/mam_body_markings/plain
	name = "Plain"
	icon_state = "plain"
	icon = 'icons/mob/sprite_accessories/mam_markings/plain_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED, "Chest" = MATRIX_RED, "Left Leg" = MATRIX_RED, "Right Leg" = MATRIX_RED, "Left Arm" = MATRIX_RED, "Right Arm" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/harlequin
	name = "Harlequin"
	icon_state = "harlequin"
	icon = 'icons/mob/sprite_accessories/mam_markings/plain_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED, "Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/harlequin_reversed
	name = "Harlequin (Reversed)"
	icon_state = "harlequin_reversed"
	icon = 'icons/mob/sprite_accessories/mam_markings/plain_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED, "Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/tonage
	name = "Tonage"
	icon_state = "tonage"
	icon = 'icons/mob/sprite_accessories/mam_markings/other_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/eyeliner
	name = "Eyeliner"
	icon_state = "eyeliner"
	icon = 'icons/mob/sprite_accessories/mam_markings/other_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/flushed_cheeks
	name = "Cheeks"
	icon_state = "flushed_cheeks"
	icon = 'icons/mob/sprite_accessories/mam_markings/other_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/nose
	name = "Nose"
	icon_state = "nose"
	icon = 'icons/mob/sprite_accessories/mam_markings/other_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/bangs
	name = "Bangs"
	icon_state = "bangs"
	icon = 'icons/mob/sprite_accessories/mam_markings/other_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/bun
	name = "Bun"
	icon_state = "bun"
	icon = 'icons/mob/sprite_accessories/mam_markings/other_markings.dmi'
	covered_limbs = list("Head" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/backspots
	name = "Backspots"
	icon_state = "backspots"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/belly
	name = "Belly"
	icon_state = "belly"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/bellyslim
	name = "Belly (Slim)"
	icon_state = "bellyslim"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/bellyscale
	name = "Belly (Scaled)"
	icon_state = "bellyscale"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/bellyscaleslim
	name = "Belly (Scaled, Slim)"
	icon_state = "bellyscaleslim"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/bellyscalesmooth
	name = "Belly (Smooth-scaled)"
	icon_state = "bellyscalesmooth"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/bellyscaleslimsmooth
	name = "Belly (Smooth-scaled, Slim)"
	icon_state = "bellyscaleslimsmooth"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/butt
	name = "Butt"
	icon_state = "butt"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/front
	name = "Front"
	icon_state = "front"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/tie
	name = "Tie"
	icon_state = "tie"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/tiesmall
	name = "Tie (Small)"
	icon_state = "tiesmall"
	icon = 'icons/mob/sprite_accessories/mam_markings/chest_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/sock
	name = "Socks"
	icon_state = "sock"
	icon = 'icons/mob/sprite_accessories/mam_markings/sock_markings.dmi'
	covered_limbs = list("Left Leg" = MATRIX_RED, "Right Leg" = MATRIX_RED, "Left Arm" = MATRIX_RED, "Right Arm" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/socklonger
	name = "Socks (Longer)"
	icon_state = "socklonger"
	icon = 'icons/mob/sprite_accessories/mam_markings/sock_markings.dmi'
	covered_limbs = list("Left Leg" = MATRIX_RED, "Right Leg" = MATRIX_RED, "Left Arm" = MATRIX_RED, "Right Arm" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/spotted
	name = "Spotted"
	icon_state = "spotted"
	icon = 'icons/mob/sprite_accessories/mam_markings/spotted_marking.dmi'
	covered_limbs = list("Head" = MATRIX_GREEN, "Chest" = MATRIX_GREEN, "Left Leg" = MATRIX_GREEN, "Right Leg" = MATRIX_GREEN, "Left Arm" = MATRIX_GREEN, "Right Arm" = MATRIX_GREEN)

/datum/sprite_accessory/mam_body_markings/ltiger
	name = "Tiger (Light)"
	icon_state = "ltiger"
	icon = 'icons/mob/sprite_accessories/mam_markings/tiger_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED, "Left Leg" = MATRIX_RED, "Right Leg" = MATRIX_RED, "Left Arm" = MATRIX_RED, "Right Arm" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/dtiger
	name = "Tiger (Dark)"
	icon_state = "dtiger"
	icon = 'icons/mob/sprite_accessories/mam_markings/tiger_markings.dmi'
	covered_limbs = list("Chest" = MATRIX_RED)

/datum/sprite_accessory/mam_body_markings/tips
	name = "Tips"
	icon_state = "tips"
	icon = 'icons/mob/sprite_accessories/mam_markings/tips_markings.dmi'
	covered_limbs = list("Left Leg" = MATRIX_RED, "Right Leg" = MATRIX_RED, "Left Arm" = MATRIX_RED, "Right Arm" = MATRIX_RED)
