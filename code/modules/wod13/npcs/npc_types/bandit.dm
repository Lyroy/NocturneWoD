/mob/living/carbon/human/npc/bandit
	max_stat = 3
	my_backup_weapon_type = /obj/item/melee/vampirearms/knife

/mob/living/carbon/human/npc/bandit/Initialize()
	. = ..()

	if (prob(50))
		set_body_model(FAT_BODY_MODEL)

	AssignSocialRole(/datum/socialrole/bandit)
