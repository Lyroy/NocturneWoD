/mob/living/carbon/human/npc/garden
	staying = TRUE
	is_talking = TRUE

/mob/living/carbon/human/npc/garden/Initialize()
	. = ..()

	if (prob(66))
		set_body_model(FAT_BODY_MODEL)

	AssignSocialRole(/datum/socialrole/shop/garden)
