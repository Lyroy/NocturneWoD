/mob/living/carbon/human/npc/gummaguts
	staying = TRUE

/mob/living/carbon/human/npc/gummaguts/Initialize()
	. = ..()

	if (prob(66))
		set_body_model(FAT_BODY_MODEL)

	AssignSocialRole(/datum/socialrole/shop/gummaguts)
