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

// legacy lizard tails

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

// legacy human tails

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

// nocturne tails

/datum/sprite_accessory/tails/mam_tails
	color_src = MATRIXED
	icon = 'icons/mob/sprite_accessories/tails/mam_tails.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/tails_animated/mam_tails_animated
	color_src = MATRIXED
	icon = 'icons/mob/sprite_accessories/tails/mam_tails.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/tails_animated/mam_tails_animated/is_not_visible(mob/living/carbon/human/H, tauric)
	return ((H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT)) || H.dna.species.mutant_bodyparts["mam_tail"])

/datum/sprite_accessory/tails/mam_tails/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/tails_animated/mam_tails_animated/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/tails/mam_tails/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/furdragon
	name = "Furred Dragon"
	icon_state = "fluffydragon"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/furdragon
	name = "Furred Dragon"
	icon_state = "fluffydragon"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/batl
	name = "Bat (Long)"
	icon_state = "batl"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/batl
	name = "Bat (Long)"
	icon_state = "batl"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/bats
	name = "Bat (Short)"
	icon_state = "bats"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/bats
	name = "Bat (Short)"
	icon_state = "bats"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/bee
	name = "Bee"
	icon_state = "bee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/bee
	name = "Bee"
	icon_state = "bee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/cat
	name = "Cat"
	icon_state = "cat"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/cat
	name = "Cat"
	icon_state = "cat"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/catbig
	name = "Cat (Big)"
	icon_state = "catbig"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/catbig
	name = "Cat (Big)"
	icon_state = "catbig"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/twocat
	name = "Cat (Double)"
	icon_state = "twocat"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/twocat
	name = "Cat (Double)"
	icon_state = "twocat"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/corvid
	name = "Corvid"
	icon_state = "crow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/corvid
	name = "Corvid"
	icon_state = "crow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/cow
	name = "Cow"
	icon_state = "cow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/cow
	name = "Cow"
	icon_state = "cow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/deathclaw
	name = "Deathclaw"
	icon_state = "deathclaw"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails/deathclaw
	name = "Deathclaw"
	icon_state = "deathclaw"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/deer
	name = "Deer"
	icon_state = "deer"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails/deer
	name = "Deer"
	icon_state = "deer"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/eevee
	name = "Eevee"
	icon_state = "eevee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/eevee
	name = "Eevee"
	icon_state = "eevee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/fennec
	name = "Fennec"
	icon_state = "fennec"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/fennec
	name = "Fennec"
	icon_state = "fennec"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/fennecdown
	name = "Fennec (Downward)"
	icon_state = "downwardfennec"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/human/fish
	name = "Fish"
	icon_state = "fish"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/human/fish
	name = "Fish"
	icon_state = "fish"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/flareon
	name = "Flareon"
	icon_state = "flareon"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/fox
	name = "Fox"
	icon_state = "fox"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/fox
	name = "Fox"
	icon_state = "fox"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/hawk
	name = "Hawk"
	icon_state = "hawk"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/hawk
	name = "Hawk"
	icon_state = "hawk"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/horse
	name = "Horse"
	icon_state = "horse"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/horse
	name = "Horse"
	icon_state = "horse"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/husky
	name = "Husky"
	icon_state = "husky"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/husky
	name = "Husky"
	icon_state = "husky"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/insect
	name = "Insect"
	icon_state = "insect"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/insect
	name = "Insect"
	icon_state = "insect"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/jackal
	name = "Jackal"
	icon_state = "jackal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/jackal
	name = "Jackal"
	icon_state = "jackal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"
	matrixed_sections = MATRIX_RED

// anybody using kitsune tails needs to get their characters thrown into a trash can bruh

/datum/sprite_accessory/tails/mam_tails/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/kitsune_three
	name = "Kitsune (Three)"
	icon_state = "3sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/kitsune_three
	name = "Kitsune (Three)"
	icon_state = "3sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/kitsune_seven
	name = "Kitsune (Seven)"
	icon_state = "7sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/kitsune_seven
	name = "Kitsune (Seven)"
	icon_state = "7sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/kitsune_nine
	name = "Kitsune (Nine)"
	icon_state = "9sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/kitsune_nine
	name = "Kitsune (Nine)"
	icon_state = "9sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/lab
	name = "Lab"
	icon_state = "lab"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/lab
	name = "Lab"
	icon_state = "lab"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/leopard
	name = "Leopard"
	icon_state = "leopard"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/leopard
	name = "Leopard"
	icon_state = "leopard"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/dtiger
	name = "Lizard (Tiger, Dark)"
	icon_state = "dtiger"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/dtiger
	name = "Lizard (Tiger, Dark)"
	icon_state = "dtiger"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/ltiger
	name = "Lizard (Tiger, Light)"
	icon_state = "ltiger"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/ltiger
	name = "Lizard (Tiger, Light)"
	icon_state = "ltiger"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/smooth
	name = "Lizard (Smooth)"
	icon_state = "smooth"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/smooth
	name = "Lizard (Smooth)"
	icon_state = "smooth"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/spikes
	name = "Lizard (Spikes)"
	icon_state = "spikes"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/spikes
	name = "Lizard (Spikes)"
	icon_state = "spikes"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/murid
	name = "Murid"
	icon_state = "murid"
	matrixed_sections = MATRIX_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/murid
	name = "Murid"
	icon_state = "murid"
	matrixed_sections = MATRIX_GREEN

/datum/sprite_accessory/tails/mam_tails/nightstalker
	name = "Nightstalker"
	icon_state = "nightstalker"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/nightstalker
	name = "Nightstalker"
	icon_state = "nightstalker"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/orca
	name = "Orca"
	icon_state = "orca"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/orca
	name = "Orca"
	icon_state = "orca"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/otie
	name = "Otusian"
	icon_state = "otie"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/otie
	name = "Otusian"
	icon_state = "otie"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/pony
	name = "Pony"
	icon_state = "pony"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/poss
	name = "Possum"
	icon_state = "posstail"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/porkupine
	name = "Porcupine"
	icon_state = "porkupine"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/tails/mam_tails/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/raccoon
	name = "Raccoon"
	icon_state = "raccoonalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/pede
	name = "Scolipede"
	icon_state = "pede"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/pede
	name = "Scolipede"
	icon_state = "pede"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/sergal
	name = "Sergal"
	icon_state = "sergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails_animated/mam_tails_animated/sergal
	name = "Sergal"
	icon_state = "sergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/seviper
	name = "Seviper"
	icon_state = "seviper"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/tails/mam_tails/shark
	name = "Shark"
	icon_state = "shark"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/shark
	name = "Shark"
	icon_state = "shark"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/shepherd
	name = "Shepherd"
	icon_state = "shepherd"
	matrixed_sections = MATRIX_GREEN_BLUE

/datum/sprite_accessory/tails_animated/mam_tails_animated/shepherd
	name = "Shepherd"
	icon_state = "shepherd"
	matrixed_sections = MATRIX_GREEN_BLUE

/datum/sprite_accessory/tails/mam_tails/snaketail
	name = "Snake"
	icon_state = "snaketail"

	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/skunk
	name = "Skunk"
	icon_state = "skunk"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/tails_animated/mam_tails_animated/skunk
	name = "Skunk"
	icon_state = "skunk"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/tails/mam_tails/skunkalt
	name = "Skunk (Alt)"
	icon_state = "skunkalt"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/tails/mam_tails/spade
	name = "Spade"
	icon_state = "spade"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/spade
	name = "Spade"
	icon_state = "spade"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/straighttail
	name = "Straight Tail"
	icon_state = "straighttail"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/straighttail
	name = "Straight Tail"
	icon_state = "straighttail"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/tiger
	name = "Tiger"
	icon_state = "tiger"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/tails_animated/mam_tails_animated/tiger
	name = "Tiger"
	icon_state = "tiger"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/tails/mam_tails/wolf
	name = "Wolf"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails_animated/mam_tails_animated/wolf
	name = "Wolf"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/tails/mam_tails/zorgia
	name = "Zorgoia"
	icon_state = "zorgoia"
	matrixed_sections = MATRIX_ALL
