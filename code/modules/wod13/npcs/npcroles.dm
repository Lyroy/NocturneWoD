/mob/living/simple_animal/pet/rat
	name = "rat"
	desc = "It's a rat."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "rat"
	icon_living = "rat"
	icon_dead = "rat_dead"
	emote_hear = list("squeeks.")
	emote_see = list("shakes its head.", "shivers.")
	speak_chance = 0
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/food/meat/slab = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	can_be_held = TRUE
	density = FALSE
	anchored = FALSE
	footstep_type = FOOTSTEP_MOB_CLAW
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 1
	maxbloodpool = 1
	del_on_death = 1
	maxHealth = 5
	health = 5

/mob/living/simple_animal/pet/rat/Initialize()
	. = ..()
	pixel_w = rand(-8, 8)
	pixel_z = rand(-8, 8)

/mob/living/simple_animal/pet/rat/Life()
	. = ..()
	if(!isturf(loc)) // if rat is, for example, in-hand or inside a crate, won't run this self-deletion code
		return
	if(client)
		return
	var/delete_me = TRUE
	for(var/mob/living/carbon/human/H in viewers(5, src))
		if(H)
			delete_me = FALSE
	if(delete_me)
		death()

/mob/living/simple_animal/pet/rat/will_escape_storage()
	if(prob(10))
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/beastmaster/rat
	name = "rat"
	desc = "It's a rat."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "rat"
	icon_living = "rat"
	icon_dead = "rat_dead"
	emote_hear = list("squeeks.")
	emote_see = list("shakes its head.", "shivers.")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'code/modules/wod13/sounds/rat.ogg'
	speak_chance = 0
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/food/meat/slab = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	can_be_held = TRUE
	density = FALSE
	anchored = FALSE
	footstep_type = FOOTSTEP_MOB_CLAW
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 1
	maxbloodpool = 1
	del_on_death = 1
	maxHealth = 20
	health = 20
	harm_intent_damage = 10
	melee_damage_lower = 5
	melee_damage_upper = 10
	speed = 0
	dodging = TRUE

/mob/living/simple_animal/hostile/beastmaster/rat/Initialize()
	. = ..()
	pixel_w = rand(-8, 8)
	pixel_z = rand(-8, 8)

/mob/living/simple_animal/hostile/beastmaster/rat/flying
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"
	name = "bat"
	desc = "It's a bat."
	is_flying_animal = TRUE
	maxHealth = 10
	health = 10
	speed = -0.8

/mob/living/simple_animal/hostile/beastmaster/rat/flying/UnarmedAttack(atom/A)
	. = ..()
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		if(H.bloodpool)
			if(prob(10))
				H.bloodpool = max(0, H.bloodpool-1)
				beastmaster.bloodpool = min(beastmaster.maxbloodpool, beastmaster.bloodpool+1)
