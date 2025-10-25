/datum/sprite_accessory/snouts
	icon = 'icons/mob/mutant_bodyparts.dmi'
	mutant_part_string = "snout"
	relevant_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/snouts/is_not_visible(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return ((H.wear_mask && (H.wear_mask.flags_inv & HIDESNOUT)) || (H.head && (H.head.flags_inv & HIDESNOUT)) || !HD || HD.status == BODYPART_ROBOTIC)

// legacy lizard snouts

/datum/sprite_accessory/snouts/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/snouts/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/snouts/sharplight
	name = "Sharp + Light"
	icon_state = "sharplight"

/datum/sprite_accessory/snouts/roundlight
	name = "Round + Light"
	icon_state = "roundlight"

// nocturne snouts

/datum/sprite_accessory/snouts/mam_snouts
	color_src = MATRIXED
	icon = 'icons/mob/sprite_accessories/snouts/mam_snouts.dmi'
	relevant_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/snouts/mam_snouts/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/snouts/mam_snouts/bird
	name = "Beak"
	icon_state = "bird"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/snouts/mam_snouts/bigbeak
	name = "Big Beak"
	icon_state = "bigbeak"
	matrixed_sections = MATRIX_BLUE

/datum/sprite_accessory/snouts/mam_snouts/bug
	name = "Bug"
	icon_state = "bug"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/elephant
	name = "Elephant"
	icon_state = "elephant"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/husky
	name = "Husky"
	icon_state = "husky"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/rhino
	name = "Horn"
	icon_state = "rhino"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/snouts/mam_snouts/rodent
	name = "Rodent"
	icon_state = "rodent"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/lcanid
	name = "Mammal (Long)"
	icon_state = "lcanid"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/lcanidalt
	name = "Mammal (Long, Alt)"
	icon_state = "lcanidalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/scanid
	name = "Mammal (Short)"
	icon_state = "scanid"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/scanidalt
	name = "Mammal (Short, Alt)"
	icon_state = "scanidalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/scanidalt2
	name = "Mammal (Short, Alt 2)"
	icon_state = "scanidalt2"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/wolf
	name = "Mammal (Thick)"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/wolfalt
	name = "Mammal (Thick, Alt)"
	icon_state = "wolfalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/otie
	name = "Otie"
	icon_state = "otie"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/round
	name = "Round"
	icon_state = "round"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/roundlight
	name = "Round (Light)"
	icon_state = "roundlight"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/pede
	name = "Scolipede"
	icon_state = "pede"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/sergal
	name = "Sergal"
	icon_state = "sergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/shark
	name = "Shark"
	icon_state = "shark"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/hshark
	name = "Shark (Alt)"
	icon_state = "hshark"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/sharp
	name = "Sharp"
	icon_state = "sharp"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/sharplight
	name = "Sharp (Light)"
	icon_state = "sharplight"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/shortnosed
	name = "Short-nosed"
	icon_state = "shortnosed"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/skulldog
	name = "Skulldog"
	icon_state = "skulldog"
	matrixed_sections = MATRIX_GREEN_BLUE

/datum/sprite_accessory/snouts/mam_snouts/toucan
	name = "Toucan"
	icon_state = "toucan"
	matrixed_sections = MATRIX_RED_BLUE //one single pixel of red. one.

/datum/sprite_accessory/snouts/mam_snouts/redpanda
	name = "Wah"
	icon_state = "wah"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/snouts/mam_snouts/redpandaalt
	name = "Wah (Alt)"
	icon_state = "wahalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/horse
	name = "Horse"
	icon_state = "hhorse"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/stubby
	name = "Stubby"
	icon_state = "stubby"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/hyena
	name = "Hyena"
	icon_state = "hspots"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/jackal
	name = "Jackal"
	icon_state = "hjackal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/anubis
	name = "Anubis"
	icon_state = "hanubus"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/panda
	name = "Panda"
	icon_state = "hpanda"
	matrixed_sections = MATRIX_RED_GREEN

// sorry jay!
/datum/sprite_accessory/snouts/mam_snouts/tajaran
	name = "Tajaran"
	icon_state = "tajaran"
	matrixed_sections = MATRIX_RED_GREEN

/******************************************
**************** Snouts *******************
*************but higher up*****************/

/datum/sprite_accessory/snouts/mam_snouts/fbird
	name = "Beak (Top)"
	icon_state = "fbird"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/snouts/mam_snouts/fbigbeak
	name = "Big Beak (Top)"
	icon_state = "fbigbeak"
	matrixed_sections = MATRIX_BLUE

/datum/sprite_accessory/snouts/mam_snouts/fbug
	name = "Bug (Top)"
	icon_state = "fbug"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/felephant
	name = "Elephant (Top)"
	icon_state = "felephant"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/frhino
	name = "Horn (Top)"
	icon_state = "frhino"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/snouts/mam_snouts/fhusky
	name = "Husky (Top)"
	icon_state = "fhusky"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/flcanid
	name = "Mammal (Long, Top)"
	icon_state = "flcanid"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/flcanidalt
	name = "Mammal (Long, Alt, Top)"
	icon_state = "flcanidalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/fscanid
	name = "Mammal (Short, Top)"
	icon_state = "fscanid"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/fscanidalt
	name = "Mammal (Short, Alt, Top)"
	icon_state = "fscanidalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/fscanidalt2
	name = "Mammal (Short, Alt 2, Top)"
	icon_state = "fscanidalt2"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/fwolf
	name = "Mammal  (Thick, Top)"
	icon_state = "fwolf"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/fwolfalt
	name = "Mammal (Thick, Alt, Top)"
	icon_state = "fwolfalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/fotie
	name = "Otie (Top)"
	icon_state = "fotie"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/frodent
	name = "Rodent (Top)"
	icon_state = "frodent"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/fround
	name = "Round (Top)"
	icon_state = "fround"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/froundlight
	name = "Round (Light, Top)"
	icon_state = "froundlight"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/fpede
	name = "Scolipede (Top)"
	icon_state = "fpede"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/fsergal
	name = "Sergal (Top)"
	icon_state = "fsergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/snouts/mam_snouts/fshark
	name = "Shark (Top)"
	icon_state = "fshark"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/fsharp
	name = "Sharp (Top)"
	icon_state = "fsharp"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/fsharplight
	name = "Sharp (Light, Top)"
	icon_state = "fsharplight"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/snouts/mam_snouts/ftoucan
	name = "Toucan (Top)"
	icon_state = "ftoucan"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/snouts/mam_snouts/fredpanda
	name = "Wah (Top)"
	icon_state = "fwah"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/snouts/mam_snouts/fredpanda/alt
	name = "Wah (Alt, Top)"
	icon_state = "fwahalt"
	matrixed_sections = MATRIX_RED_GREEN
