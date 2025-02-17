/datum/job/vamp/taxi
	title = "Taxi Driver"
	department_head = list("Justicar")
	faction = "Vampire"
	total_positions = 3
	spawn_positions = 3
	supervisors = " the Traditions"

	outfit = /datum/outfit/job/taxi

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_TAXI
	exp_granted_type = EXP_TYPE_SERVICES

	allowed_species = list("Vampire", "Ghoul", "Human", "Werewolf", "Kuei-Jin")

	v_duty = "Drive people in the city."
	duty = "Drive people in the city."
	minimal_masquerade = 0
	experience_addition = 10
	allowed_bloodlines = list("Daughters of Cacaphony", "Salubri", "Baali", "Brujah", "Tremere", "Ventrue", "Nosferatu", "Gangrel", "Toreador", "Malkavian", "Banu Haqim", "Giovanni", "Ministry", "Tzimisce", "Lasombra", "Caitiff", "Kiasyd", "Cappadocian")

/datum/job/vamp/taxi/after_spawn(mob/living/H, mob/M, latejoin = FALSE)
	..()
	H.taxist = TRUE

/datum/outfit/job/taxi
	name = "Taxi Driver"
	jobtype = /datum/job/vamp/taxi

	id = /obj/item/cockclock
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/taxi
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1, /obj/item/melee/vampirearms/tire=1)

/datum/outfit/job/taxi/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes
	else
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
			uniform = /obj/item/clothing/under/vampire/sport
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
			uniform = /obj/item/clothing/under/vampire/red

/obj/effect/landmark/start/taxi
	name = "Taxi Driver"
