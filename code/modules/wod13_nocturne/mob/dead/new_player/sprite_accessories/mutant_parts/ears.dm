/datum/sprite_accessory/ears
	icon = 'icons/mob/mutant_bodyparts.dmi'
	mutant_part_string = "ears"
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/ears/is_not_visible(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["ears"] || H.dna.features["ears"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)

// legacy tg ears

/datum/sprite_accessory/ears/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/ears/cat
	name = "Cat"
	icon_state = "cat"
	hasinner = 1
	color_src = HAIR

// nocturne ears

/datum/sprite_accessory/ears/mam_ears
	icon = 'icons/mob/sprite_accessories/ears/mam_ears.dmi'
	color_src = MATRIXED
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/ears/mam_ears/is_not_visible(mob/living/carbon/human/H)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	return (!H.dna.features["mam_ears"] || H.dna.features["mam_ears"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)

/datum/sprite_accessory/ears/mam_ears/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/ears/mam_ears/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/bat
	name = "Bat"
	icon_state = "bat"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/bear
	name = "Bear"
	icon_state = "bear"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/bigwolf
	name = "Big Wolf"
	icon_state = "bigwolf"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/bunny
	name = "Bunny"
	icon_state = "bunny"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/bunnyalt
	name = "Bunny (Alt)"
	icon_state = "bunnyalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/catbig
	name = "Cat"
	icon_state = "catbig"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/cow
	name = "Cow"
	icon_state = "cow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/deer
	name = "Deer"
	icon_state = "deer"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/dog
	name = "Dog"
	icon_state = "lab"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/eevee
	name = "Eevee"
	icon_state = "eevee"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/eeveealt
	name = "Eevee (Alt)"
	icon_state = "eeveealt"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/eeveetorn
	name = "Eeeve Torn"
	icon_state = "eeveetorn"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/elf
	name = "Elf"
	icon_state = "elf"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/elephant
	name = "Elephant"
	icon_state = "elephant"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/fennec
	name = "Fennec"
	icon_state = "fennec"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/fennec2
	name = "Fennec (Alt)"
	icon_state = "fennec2"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/fish
	name = "Fish"
	icon_state = "fish"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/fox
	name = "Fox"
	icon_state = "fox"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/husky
	name = "Husky"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/jellyfish
	name = "Jellyfish"
	icon_state = "jellyfish"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/ears/mam_ears/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/murid
	name = "Murid"
	icon_state = "murid"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/otie
	name = "Otusian"
	icon_state = "otie"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/rabbitalt
	name = "Rabbit (Alt)"
	icon_state = "rabbitalt"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/ears/mam_ears/pede
	name = "Scolipede"
	icon_state = "pede"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/sergal
	name = "Sergal"
	icon_state = "sergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/skunk
	name = "Skunk"
	icon_state = "skunk"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/ears/mam_ears/wolf
	name = "Wolf"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/ears/mam_ears/zorgoia
	name = "Zorgoia"
	icon_state = "zorgoia"
	matrixed_sections = MATRIX_RED
