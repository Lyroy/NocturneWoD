/datum/preferences/proc/save_preferences()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	WRITE_FILE(S["version"] , SAVEFILE_VERSION_MAX)		//updates (or failing that the sanity checks) will ensure data is not invalid at load. Assume up-to-date

	//general preferences
	WRITE_FILE(S["asaycolor"], asaycolor)
	WRITE_FILE(S["ooccolor"], ooccolor)
	WRITE_FILE(S["lastchangelog"], lastchangelog)
	WRITE_FILE(S["UI_style"], UI_style)
	WRITE_FILE(S["hotkeys"], hotkeys)
	WRITE_FILE(S["chat_on_map"], chat_on_map)
	WRITE_FILE(S["max_chat_length"], max_chat_length)
	WRITE_FILE(S["see_chat_non_mob"], see_chat_non_mob)
	WRITE_FILE(S["see_rc_emotes"], see_rc_emotes)
	WRITE_FILE(S["broadcast_login_logout"], broadcast_login_logout)
	WRITE_FILE(S["tgui_fancy"], tgui_fancy)
	WRITE_FILE(S["tgui_lock"], tgui_lock)
	WRITE_FILE(S["buttons_locked"], buttons_locked)
	WRITE_FILE(S["windowflash"], windowflashing)
	WRITE_FILE(S["be_special"], be_special)
	WRITE_FILE(S["default_slot"], default_slot)
	WRITE_FILE(S["toggles"], toggles)
	WRITE_FILE(S["chat_toggles"], chat_toggles)
	WRITE_FILE(S["ghost_form"], ghost_form)
	WRITE_FILE(S["ghost_orbit"], ghost_orbit)
	WRITE_FILE(S["ghost_accs"], ghost_accs)
	WRITE_FILE(S["ghost_others"], ghost_others)
	WRITE_FILE(S["preferred_map"], preferred_map)
	WRITE_FILE(S["ignoring"], ignoring)
	WRITE_FILE(S["ghost_hud"], ghost_hud)
	WRITE_FILE(S["inquisitive_ghost"], inquisitive_ghost)
	WRITE_FILE(S["uses_glasses_colour"], uses_glasses_colour)
	WRITE_FILE(S["clientfps"], clientfps)
	WRITE_FILE(S["parallax"], parallax)
	WRITE_FILE(S["ambientocclusion"], ambientocclusion)
	WRITE_FILE(S["auto_fit_viewport"], auto_fit_viewport)
	WRITE_FILE(S["old_discipline"], old_discipline)
	WRITE_FILE(S["widescreenpref"], widescreenpref)
	WRITE_FILE(S["pixel_size"], pixel_size)
	WRITE_FILE(S["scaling_method"], scaling_method)
	WRITE_FILE(S["menuoptions"], menuoptions)
	WRITE_FILE(S["enable_tips"], enable_tips)
	WRITE_FILE(S["tip_delay"], tip_delay)
	WRITE_FILE(S["pda_style"], pda_style)
	WRITE_FILE(S["pda_color"], pda_color)
	WRITE_FILE(S["key_bindings"], key_bindings)
	WRITE_FILE(S["hearted_until"], (hearted_until > world.realtime ? hearted_until : null))
	return TRUE

/datum/preferences/proc/save_character()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/character[default_slot]"

	WRITE_FILE(S["version"], SAVEFILE_VERSION_MAX)	//load_character will sanitize any bad data, so assume up-to-date.)

	WRITE_FILE(S["slotlocked"], slotlocked)

	// generic info
	WRITE_FILE(S["species"], pref_species.id)
	WRITE_FILE(S["gender"], gender)
	WRITE_FILE(S["real_name"], real_name)
	WRITE_FILE(S["body_type"], body_type)
	WRITE_FILE(S["age"], age)
	WRITE_FILE(S["total_age"], total_age)
	WRITE_FILE(S["hair_color"], hair_color)
	WRITE_FILE(S["facial_hair_color"], facial_hair_color)
	WRITE_FILE(S["eye_color"], eye_color)
	WRITE_FILE(S["skin_tone"], skin_tone)
	WRITE_FILE(S["hairstyle_name"], hairstyle)
	WRITE_FILE(S["facial_style_name"], facial_hairstyle)
	WRITE_FILE(S["underwear"], underwear)
	WRITE_FILE(S["underwear_color"], underwear_color)
	WRITE_FILE(S["undershirt"], undershirt)
	WRITE_FILE(S["socks"], socks)
	WRITE_FILE(S["backpack"], backpack)

	// jobs
	WRITE_FILE(S["joblessrole"], joblessrole)
	WRITE_FILE(S["job_preferences"], job_preferences)
	WRITE_FILE(S["alt_titles_preferences"], alt_titles_preferences)

	// quirks
	WRITE_FILE(S["all_quirks"], all_quirks)

	// basic character stats
	WRITE_FILE(S["true_experience"], true_experience)
	WRITE_FILE(S["archetype"], archetype)
	WRITE_FILE(S["physique"], physique)
	WRITE_FILE(S["dexterity"], dexterity)
	WRITE_FILE(S["social"], social)
	WRITE_FILE(S["mentality"], mentality)
	WRITE_FILE(S["lockpicking"], lockpicking)
	WRITE_FILE(S["athletics"], athletics)
	WRITE_FILE(S["blood"], blood)

	// background info
	WRITE_FILE(S["info_known"], info_known)
	WRITE_FILE(S["friend"], friend)
	WRITE_FILE(S["enemy"], enemy)
	WRITE_FILE(S["lover"], lover)
	WRITE_FILE(S["friend_text"], friend_text)
	WRITE_FILE(S["enemy_text"], enemy_text)
	WRITE_FILE(S["lover_text"], lover_text)
	WRITE_FILE(S["reason_of_death"], reason_of_death)

	// flavor text
	WRITE_FILE(S["flavor_text"], flavor_text)
	WRITE_FILE(S["flavor_text_nsfw"], flavor_text_nsfw)
	WRITE_FILE(S["ooc_notes"], ooc_notes)
	WRITE_FILE(S["headshot_link"], headshot_link)

	// werewolves
	WRITE_FILE(S["werewolf_name"], werewolf_name)
	WRITE_FILE(S["breed"], breed)
	WRITE_FILE(S["tribe"], tribe)
	WRITE_FILE(S["werewolf_hair"], werewolf_hair)
	WRITE_FILE(S["werewolf_hair_color"], werewolf_hair_color)
	WRITE_FILE(S["werewolf_eye_color"], werewolf_eye_color)
	WRITE_FILE(S["werewolf_color"], werewolf_color)
	WRITE_FILE(S["werewolf_scar"], werewolf_scar)

	// werewolf stats
	WRITE_FILE(S["auspice"], auspice.name)
	WRITE_FILE(S["auspice_level"], auspice_level)

	// clans
	WRITE_FILE(S["clan"], clan?.type)
	WRITE_FILE(S["clan_accessory"], clan_accessory)
	WRITE_FILE(S["generation"], generation)
	WRITE_FILE(S["generation_bonus"], generation_bonus)
	WRITE_FILE(S["masquerade"], masquerade)

	// vampire stats
	WRITE_FILE(S["diablerist"], diablerist)
	WRITE_FILE(S["humanity"], humanity)
	WRITE_FILE(S["enlightement"], enlightenment)
	WRITE_FILE(S["torpor_count"], torpor_count)

	// disciplines
	WRITE_FILE(S["discipline_types"], discipline_types)
	WRITE_FILE(S["discipline_levels"], discipline_levels)

	/*
	// apparently has been reworked, see _load_procs.dm
	WRITE_FILE(S["discipline1type"], discipline1type)
	WRITE_FILE(S["discipline1level"], discipline1level)

	WRITE_FILE(S["discipline2type"], discipline2type)
	WRITE_FILE(S["discipline2level"], discipline2level)

	WRITE_FILE(S["discipline3type"], discipline3type)
	WRITE_FILE(S["discipline3level"], discipline3level)

	WRITE_FILE(S["discipline4type"], discipline4type)
	WRITE_FILE(S["discipline4level"], discipline4level)
	*/

	// keui jin
	WRITE_FILE(S["dharma_type"], dharma_type)
	WRITE_FILE(S["dharma_level"], dharma_level)
	WRITE_FILE(S["po_type"], po_type)
	WRITE_FILE(S["po"], po)
	WRITE_FILE(S["hun"], hun)
	WRITE_FILE(S["yang"], yang)
	WRITE_FILE(S["yin"], yin)
	WRITE_FILE(S["chi_types"], chi_types)
	WRITE_FILE(S["chi_levels"], chi_levels)

	// misc bullshit that idk what to do with
	WRITE_FILE(S["jumpsuit_style"], jumpsuit_style)
	WRITE_FILE(S["uplink_loc"], uplink_spawn_loc)
	WRITE_FILE(S["playtime_reward_cloak"], playtime_reward_cloak)
	WRITE_FILE(S["randomise"], randomise)
	WRITE_FILE(S["phobia"], phobia)
	WRITE_FILE(S["persistent_scars"], persistent_scars)
	WRITE_FILE(S["preferred_ai_core_display"] ,  preferred_ai_core_display)
	WRITE_FILE(S["prefered_security_department"] , prefered_security_department)

	// mutant stuff
	WRITE_FILE(S["feature_mcolor"], features["mcolor"])
	WRITE_FILE(S["feature_ethcolor"], features["ethcolor"])
	WRITE_FILE(S["feature_lizard_tail"], features["tail_lizard"])
	WRITE_FILE(S["feature_lizard_snout"], features["snout"])
	WRITE_FILE(S["feature_lizard_horns"], features["horns"])
	WRITE_FILE(S["feature_lizard_frills"], features["frills"])
	WRITE_FILE(S["feature_lizard_spines"], features["spines"])
	WRITE_FILE(S["feature_lizard_body_markings"], features["body_markings"])
	WRITE_FILE(S["feature_lizard_legs"], features["legs"])
	WRITE_FILE(S["feature_moth_wings"], features["moth_wings"])
	WRITE_FILE(S["feature_moth_antennae"], features["moth_antennae"])
	WRITE_FILE(S["feature_moth_markings"], features["moth_markings"])
	WRITE_FILE(S["feature_human_tail"], features["tail_human"])
	WRITE_FILE(S["feature_human_ears"], features["ears"])

	// body markings
	WRITE_FILE(S["feature_mam_body_markings"], features["mam_body_markings"])

	// matrixed mutant part colors
	for(var/feature in features)
		var/feature_value = features[feature]
		if(feature_value)
			var/ref_list = GLOB.mutant_reference_list[feature]
			if(ref_list)
				var/datum/sprite_accessory/accessory = ref_list[feature_value]
				if(accessory)
					var/mutant_string = accessory.mutant_part_string

					if(!mutant_string)
						if(istype(accessory, /datum/sprite_accessory/mam_body_markings))
							mutant_string = "mam_body_markings"

					var/primary_string = "[mutant_string]_primary"
					var/secondary_string = "[mutant_string]_secondary"
					var/tertiary_string = "[mutant_string]_tertiary"
					if(accessory.color_src == MATRIXED && !accessory.matrixed_sections && feature_value != "None")
						stack_trace("Sprite Accessory Failure (saving data): Accessory [accessory.type] is a matrixed item without any matrixed sections set!")
						continue
					if(features[primary_string])
						WRITE_FILE(S["feature_[primary_string]"], features[primary_string])
					if(features[secondary_string])
						WRITE_FILE(S["feature_[secondary_string]"], features[secondary_string])
					if(features[tertiary_string])
						WRITE_FILE(S["feature_[tertiary_string]"], features[tertiary_string])

	return TRUE
