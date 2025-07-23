/datum/sprite_accessory/tails
	icon = 'icons/mob/mutant_bodyparts.dmi'
	mutant_part_string = "tail"
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/tails/is_not_visible(mob/living/carbon/human/H)
	return (H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))

/datum/sprite_accessory/tails_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'
	mutant_part_string = "tailwag" //keep this the same, ALWAYS, this is incredibly important for colouring!
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

// lizard tails

/datum/sprite_accessory/tails_animated/lizard/is_not_visible(mob/living/carbon/human/H)
	return ((H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT)) || H.dna.species.mutant_bodyparts["tail_lizard"])

/datum/sprite_accessory/tails/lizard/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/tails_animated/lizard/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/tails/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails_animated/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails_animated/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/tails_animated/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/tails/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/tails_animated/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

// human tails

/datum/sprite_accessory/tails_animated/human/is_not_visible(mob/living/carbon/human/H, tauric)
	return ((H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT)) || H.dna.species.mutant_bodyparts["tail_human"])

/datum/sprite_accessory/tails/human/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/tails_animated/human/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/tails/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/tails_animated/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/tails/monkey/default
	name = "Monkey"
	icon_state = "monkey"
	color_src = FALSE
