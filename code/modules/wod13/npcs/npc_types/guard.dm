/mob/living/carbon/human/npc/guard
	staying = TRUE
	fights_anyway = TRUE
	max_stat = 4
	my_weapon_type = /obj/item/gun/ballistic/automatic/vampire/m1911
	my_backup_weapon_type = /obj/item/melee/classic_baton/vampire

/mob/living/carbon/human/npc/guard/Initialize()
	. = ..()

	if (prob(66))
		set_body_model(FAT_BODY_MODEL)

	AssignSocialRole(/datum/socialrole/guard)
