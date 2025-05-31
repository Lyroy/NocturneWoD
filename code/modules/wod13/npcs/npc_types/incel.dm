/mob/living/carbon/human/npc/incel
	staying = TRUE

/mob/living/carbon/human/npc/incel/Initialize()
	. = ..()

	if (prob(50))
		set_body_model(FAT_BODY_MODEL)

	AssignSocialRole(/datum/socialrole/usualmale)
