/mob/living/carbon/human/npc/stripper
	staying = TRUE

/mob/living/carbon/human/npc/stripper/Initialize()
	. = ..()

	set_body_weight(SLIM_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/stripfemale)

	underwear = "Nude"
	undershirt = "Nude"
	socks = "Nude"

	update_body()

/mob/living/carbon/human/npc/stripper/Life()
	. = ..()

	if (stat >= UNCONSCIOUS)
		return
	if (!prob(20))
		return

	for (var/obj/structure/pole/pole in range(1, src))
		drop_all_held_items()
		ClickOn(pole)
