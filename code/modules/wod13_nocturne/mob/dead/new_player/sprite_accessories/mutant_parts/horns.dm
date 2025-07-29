/datum/sprite_accessory/horns
	icon = 'icons/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_FRONT_LAYER, BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
	mutant_part_string = "horns"

/datum/sprite_accessory/horns/is_not_visible(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["horns"] || H.dna.features["horns"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)

/datum/sprite_accessory/horns/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/horns/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/horns/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/horns/curled
	name = "Curled"
	icon_state = "curled"

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/angler
	name = "Angeler"
	icon_state = "angler"

/datum/sprite_accessory/horns/mam_horns
	icon = 'icons/mob/sprite_accessories/horns/horns.dmi'
	relevant_layers = list(BODY_FRONT_LAYER, BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
	color_src = MATRIXED

/datum/sprite_accessory/horns/mam_horns/is_not_visible(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["mam_horns"] || H.dna.features["mam_horns"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)

/datum/sprite_accessory/horns/mam_horns/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/horns/mam_horns/angler
	name = "Angler"
	icon_state = "angler"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/antlers
	name = "Antlers"
	icon_state = "antlers"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/smallantlers
	name = "Antlers (Small)"
	icon_state = "smallantlers"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/bigcurly
	name = "Big and Curly"
	icon_state = "bigcurly"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/billberry
	name = "Billberry"
	icon_state = "billberry"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/broken
	name = "Broken"
	icon_state = "broken"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/rbroken
	name = "Broken (Right)"
	icon_state = "rbroken"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/lbroken
	name = "Broken (Left)"
	icon_state = "lbroken"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/bunhorns
	name = "Bun Horns"
	icon_state = "bunhorns"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/curled
	name = "Curled"
	icon_state = "curled"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/doublehorns
	name = "Double"
	icon_state = "doublehorns"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/dragon
	name = "Dragon"
	icon_state = "dragon"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/drake
	name = "Drake"
	icon_state = "drake"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/faceguard
	name = "Faceguard"
	icon_state = "faceguard"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/great
	name = "Great"
	icon_state = "great"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/halo
	name = "Halo"
	icon_state = "halo"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/unihorn
	name = "Horn (Singular)"
	icon_state = "unihorn"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/knight
	name = "Knight"
	icon_state = "knight"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/lifted
	name = "Lifted"
	icon_state = "lifted"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/longhorns
	name = "Longhorns"
	icon_state = "longhorns"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/marauder
	name = "Marauder"
	icon_state = "marauder"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/oni
	name = "Oni"
	icon_state = "oni"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/oni_large
	name = "Oni (Large)"
	icon_state = "oni_large"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/outstretched
	name = "Outstretched"
	icon_state = "outstretched"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/ram
	name = "Ram"
	icon_state = "ram"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/ramalt
	name = "Ram (Alt)"
	icon_state = "ramalt"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/ramcurled
	name = "Ram (Curled)"
	icon_state = "ramcurled"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/ramcurledalt
	name = "Ram (Curled, Alt)"
	icon_state = "ramcurledalt"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/ramcurledsmall
	name = "Ram (Curled, Small)"
	icon_state = "ramcurledsmall"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/ramcurledsmallalt
	name = "Ram (Curled, Small, Alt)"
	icon_state = "ramcurledsmallalt"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/ramcurledsmallalt2
	name = "Ram (Curled, Small, Alt 2)"
	icon_state = "ramcurledsmallalt2"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/sheep
	name = "Sheep"
	icon_state = "sheep"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/short
	name = "Short"
	icon_state = "short"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/sideswept
	name = "Sideswept"
	icon_state = "sideswept"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/simple
	name = "Simple"
	icon_state = "simple"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/stabbers
	name = "Stabbers"
	icon_state = "stabbers"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/tiebhorns
	name = "Tiefling"
	icon_state = "tiebhorns"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/tiebhornsalt
	name = "Tiefling (Alt)"
	icon_state = "tiebhornsalt"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/horns/mam_horns/uni
	name = "Unicorn"
	icon_state = "uni"
	matrixed_sections = MATRIX_RED
