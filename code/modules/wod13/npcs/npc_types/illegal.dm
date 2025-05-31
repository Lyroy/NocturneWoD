/mob/living/carbon/human/npc/illegal
	staying = TRUE
	is_talking = TRUE

/mob/living/carbon/human/npc/illegal/Initialize()
	. = ..()

	AssignSocialRole(/datum/socialrole/shop/illegal)
