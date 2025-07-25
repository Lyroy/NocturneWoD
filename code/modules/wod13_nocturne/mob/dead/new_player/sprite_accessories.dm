/datum/sprite_accessory
	var/list/relevant_layers
	var/mutant_part_string
	var/matrixed_sections = MATRIX_NONE // determines how many colors a sprite has if color_src is MATRIXED

/datum/sprite_accessory/proc/is_not_visible(mob/living/carbon/human/H) //return if the accessory shouldn't be shown
	return FALSE
