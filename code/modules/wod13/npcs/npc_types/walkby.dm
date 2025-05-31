/mob/living/carbon/human/npc/walkby

/mob/living/carbon/human/npc/walkby/Initialize()
	. = ..()

	if (prob(50))
		set_body_model(pick(SLIM_BODY_MODEL, FAT_BODY_MODEL))

	var/datum/socialrole/assign_role = pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale)
	AssignSocialRole(assign_role)
