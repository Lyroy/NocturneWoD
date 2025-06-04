/mob/living/carbon/human/npc/bubway
	staying = TRUE

/mob/living/carbon/human/npc/bubway/Initialize()
	. = ..()

	if (prob(66))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/shop/bubway)
