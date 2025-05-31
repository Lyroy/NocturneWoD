/mob/living/carbon/human/npc/bubway
	staying = TRUE

/mob/living/carbon/human/npc/bubway/Initialize()
	. = ..()

	if (prob(66))
		set_body_model(FAT_BODY_MODEL)

	AssignSocialRole(/datum/socialrole/shop/bubway)
