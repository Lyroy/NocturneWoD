/mob/living/carbon/human/npc/gummaguts
	staying = TRUE

/mob/living/carbon/human/npc/gummaguts/Initialize()
	. = ..()

	if (prob(66))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/shop/gummaguts)
