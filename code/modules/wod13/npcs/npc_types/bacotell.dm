/mob/living/carbon/human/npc/bacotell
	staying = TRUE

/mob/living/carbon/human/npc/bacotell/Initialize()
	. = ..()
	if(prob(66))
		set_body_model(FAT_BODY_MODEL)
	AssignSocialRole(/datum/socialrole/shop/bacotell)
