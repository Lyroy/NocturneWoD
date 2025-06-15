/mob/living/simple_animal/hostile/werewolf
	name = "Werewolf"
	desc = "AUF."
	icon_state = "werewolf"
	icon_living = "werewolf"
	icon_dead = "werewolf_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	speed = -1
	maxHealth = 1000
	health = 1000
	butcher_results = list(/obj/item/stack/human_flesh = 20)
	harm_intent_damage = 5
	melee_damage_lower = 50
	melee_damage_upper = 50
	attack_verb_continuous = "slashes"
	combat_mode = TRUE
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	pixel_w = -8
