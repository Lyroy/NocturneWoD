/mob/living/carbon/human/npc/police
	fights_anyway = TRUE
	max_stat = 4
	my_backup_weapon_type = /obj/item/melee/classic_baton/vampire

/mob/living/carbon/human/npc/police/Initialize()
	. = ..()

	if (prob(66))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/police)

/mob/living/carbon/human/npc/police/Life()
	. = ..()

	if (stat >= SOFT_CRIT)
		return
	if (!prob(10))
		return

	for (var/mob/living/carbon/human/H in oviewers(4, src))
		if (!H.warrant)
			continue

		Aggro(H, FALSE)
