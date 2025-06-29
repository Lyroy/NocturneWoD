/datum/preferences/proc/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE, is_latejoiner = TRUE)

	hardcore_survival_score = 0 //Set to 0 to prevent you getting points from last another time.

	if((randomise[RANDOM_SPECIES] || randomise[RANDOM_HARDCORE]) && !character_setup)
		random_species()

	if((randomise[RANDOM_BODY] || (randomise[RANDOM_BODY_ANTAG] && antagonist) || randomise[RANDOM_HARDCORE]) && !character_setup)
		slot_randomized = TRUE
		random_character(gender, antagonist)

	if((randomise[RANDOM_NAME] || (randomise[RANDOM_NAME_ANTAG] && antagonist) || randomise[RANDOM_HARDCORE]) && !character_setup)
		slot_randomized = TRUE
		real_name = pref_species.random_name(gender)

	if(randomise[RANDOM_HARDCORE] && parent?.mob.mind && !character_setup)
		if(can_be_random_hardcore())
			hardcore_random_setup(character, antagonist, is_latejoiner)

	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == "human"))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	character.real_name = real_name
	character.true_real_name = real_name
	character.name = character.real_name

	character.flavor_text = sanitize_text(flavor_text)
	character.ooc_notes = sanitize_text(ooc_notes)

	character.age = age
	character.chronological_age = total_age

	character.gender = gender
	if(gender == MALE || gender == FEMALE)
		character.body_type = gender
	else
		character.body_type = body_type

	character.eye_color = eye_color
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = eye_color
		organ_eyes.old_eye_color = eye_color

	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color
	character.hairstyle = hairstyle
	character.facial_hairstyle = facial_hairstyle
	character.underwear = underwear
	character.underwear_color = underwear_color
	character.undershirt = undershirt
	character.socks = socks
	character.backpack = backpack
	character.jumpsuit_style = jumpsuit_style
	character.skin_tone = skin_tone

	var/datum/species/chosen_species
	chosen_species = pref_species.type
	character.dna.features = features.Copy()
	character.set_species(chosen_species, icon_update = FALSE, pref_load = TRUE)
	character.dna.real_name = character.real_name

	character.diablerist = diablerist
	character.headshot_link = headshot_link
	character.info_known = info_known

	character.physique = physique
	character.dexterity = dexterity
	character.social = social
	character.mentality = mentality
	character.blood = blood
	character.lockpicking = lockpicking
	character.athletics = athletics

	var/datum/archetype/A = new archetype()
	character.additional_physique = A.archetype_additional_physique
	character.additional_dexterity = A.archetype_additional_dexterity
	character.additional_social = A.archetype_additional_social
	character.additional_mentality = A.archetype_additional_mentality
	character.additional_blood = A.archetype_additional_blood
	character.additional_lockpicking = A.archetype_additional_lockpicking
	character.additional_athletics = A.archetype_additional_athletics
	A.special_skill(character)

	character.masquerade = masquerade
	if(!character_setup)
		if(character in GLOB.masquerade_breakers_list)
			if(character.masquerade > 2)
				GLOB.masquerade_breakers_list -= character
		else if(character.masquerade < 3)
			GLOB.masquerade_breakers_list += character

	switch (body_model)
		if (SLIM_BODY_MODEL_NUMBER)
			character.set_body_model(SLIM_BODY_MODEL)
		if (NORMAL_BODY_MODEL_NUMBER)
			character.set_body_model(NORMAL_BODY_MODEL)
		if (FAT_BODY_MODEL_NUMBER)
			character.set_body_model(FAT_BODY_MODEL)

	character.maxHealth = round((initial(character.maxHealth)+(initial(character.maxHealth)/4)*(character.physique + character.additional_physique)))
	character.health = character.maxHealth

	if (pref_species.name == "Kuei-Jin")
		character.yang_chi = yang
		character.max_yang_chi = yang
		character.yin_chi = yin
		character.max_yin_chi = yin
		character.max_demon_chi = po
	else
		character.yang_chi = 3
		character.max_yang_chi = 3
		character.yin_chi = 2
		character.max_yin_chi = 2

	if(pref_species.name == "Vampire")
		// character.skin_tone = get_vamp_skin_color(skin_tone)

		character.set_clan(clan, TRUE)

		character.generation = generation
		character.maxbloodpool = 10 + ((13 - generation) * 3)
		character.bloodpool = rand(2, character.maxbloodpool)

		character.max_yin_chi = character.maxbloodpool
		character.yin_chi = character.max_yin_chi

		// Apply Clan accessory
		if (character.clan?.accessories?.Find(clan_accessory))
			var/accessory_layer = character.clan.accessories_layers[clan_accessory]
			character.remove_overlay(accessory_layer)
			var/mutable_appearance/acc_overlay = mutable_appearance('code/modules/wod13/icons.dmi', clan_accessory, -accessory_layer)
			character.overlays_standing[accessory_layer] = acc_overlay
			character.apply_overlay(accessory_layer)

		character.humanity = humanity
	else
		character.set_clan(null)
		character.generation = 13
		character.bloodpool = character.maxbloodpool

	if(pref_species.name == "Werewolf")
		switch(tribe)
			if("Wendigo")
				character.yin_chi = 1
				character.max_yin_chi = 1
				character.yang_chi = 5 + (auspice_level * 2)
				character.max_yang_chi = 5 + (auspice_level * 2)
			if("Glasswalkers")
				character.yin_chi = 1 + auspice_level
				character.max_yin_chi = 1 + auspice_level
				character.yang_chi = 5 + auspice_level
				character.max_yang_chi = 5 + auspice_level
			if("Black Spiral Dancers")
				character.yin_chi = 1 + auspice_level * 2
				character.max_yin_chi = 1 + auspice_level * 2
				character.yang_chi = 5
				character.max_yang_chi = 5

		var/datum/auspice/CLN = new auspice.type()
		character.auspice = CLN
		character.auspice.level = auspice_level
		character.auspice.tribe = tribe
		character.auspice.on_gain(character)
		switch(breed)
			if("Homid")
				character.auspice.gnosis = 1
				character.auspice.start_gnosis = 1
				character.auspice.base_breed = "Homid"
			if("Lupus")
				character.auspice.gnosis = 5
				character.auspice.start_gnosis = 5
				character.auspice.base_breed = "Lupus"
			if("Metis")
				character.auspice.gnosis = 3
				character.auspice.start_gnosis = 3
				character.auspice.base_breed = "Crinos"
		if(character.transformator)
			if(character.transformator.crinos_form && character.transformator.lupus_form)
				character.transformator.crinos_form.sprite_color = werewolf_color
				character.transformator.crinos_form.sprite_scar = werewolf_scar
				character.transformator.crinos_form.sprite_hair = werewolf_hair
				character.transformator.crinos_form.sprite_hair_color = werewolf_hair_color
				character.transformator.crinos_form.sprite_eye_color = werewolf_eye_color
				character.transformator.lupus_form.sprite_color = werewolf_color
				character.transformator.lupus_form.sprite_eye_color = werewolf_eye_color

				if(werewolf_name)
					character.transformator.crinos_form.name = werewolf_name
					character.transformator.lupus_form.name = werewolf_name
				else
					character.transformator.crinos_form.name = real_name
					character.transformator.lupus_form.name = real_name

				character.transformator.crinos_form.physique = physique
				character.transformator.crinos_form.dexterity = dexterity
				character.transformator.crinos_form.mentality = mentality
				character.transformator.crinos_form.social = social
				character.transformator.crinos_form.blood = blood

				character.transformator.lupus_form.physique = physique
				character.transformator.lupus_form.dexterity = dexterity
				character.transformator.lupus_form.mentality = mentality
				character.transformator.lupus_form.social = social
				character.transformator.lupus_form.blood = blood

				character.transformator.lupus_form.maxHealth = round((initial(character.transformator.lupus_form.maxHealth)+(initial(character.maxHealth)/4)*(character.physique + character.additional_physique )))+(character.auspice.level-1)*50
				character.transformator.lupus_form.health = character.transformator.lupus_form.maxHealth
				character.transformator.crinos_form.maxHealth = round((initial(character.transformator.crinos_form.maxHealth)+(initial(character.maxHealth)/4)*(character.physique + character.additional_physique )))+(character.auspice.level-1)*50
				character.transformator.crinos_form.health = character.transformator.crinos_form.maxHealth

	if(pref_species.mutant_bodyparts["tail_lizard"])
		character.dna.species.mutant_bodyparts["tail_lizard"] = pref_species.mutant_bodyparts["tail_lizard"]
	if(pref_species.mutant_bodyparts["spines"])
		character.dna.species.mutant_bodyparts["spines"] = pref_species.mutant_bodyparts["spines"]

	if(icon_updates)
		character.update_body()
		character.update_hair()
		character.update_body_parts()
	if(!character_setup)
		parent << browse(null, "window=preferences_window")
		parent << browse(null, "window=preferences_browser")
