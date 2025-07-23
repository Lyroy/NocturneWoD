/datum/preferences/proc/load_path(ckey,filename="preferences.sav")
	if(!ckey)
		return
	path = "data/player_saves/[ckey[1]]/[ckey]/[filename]"

/datum/preferences/proc/load_preferences()
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE

	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		return FALSE

	//general preferences
	READ_FILE(S["asaycolor"], asaycolor)
	READ_FILE(S["ooccolor"], ooccolor)
	READ_FILE(S["lastchangelog"], lastchangelog)
	READ_FILE(S["UI_style"], UI_style)
	READ_FILE(S["hotkeys"], hotkeys)
	READ_FILE(S["chat_on_map"], chat_on_map)
	READ_FILE(S["max_chat_length"], max_chat_length)
	READ_FILE(S["see_chat_non_mob"] , see_chat_non_mob)
	READ_FILE(S["see_rc_emotes"] , see_rc_emotes)
	READ_FILE(S["broadcast_login_logout"] , broadcast_login_logout)
	READ_FILE(S["tgui_fancy"], tgui_fancy)
	READ_FILE(S["tgui_lock"], tgui_lock)
	READ_FILE(S["buttons_locked"], buttons_locked)
	READ_FILE(S["windowflash"], windowflashing)
	READ_FILE(S["be_special"] , be_special)
	READ_FILE(S["default_slot"], default_slot)
	READ_FILE(S["chat_toggles"], chat_toggles)
	READ_FILE(S["toggles"], toggles)
	READ_FILE(S["ghost_form"], ghost_form)
	READ_FILE(S["ghost_orbit"], ghost_orbit)
	READ_FILE(S["ghost_accs"], ghost_accs)
	READ_FILE(S["ghost_others"], ghost_others)
	READ_FILE(S["preferred_map"], preferred_map)
	READ_FILE(S["ignoring"], ignoring)
	READ_FILE(S["ghost_hud"], ghost_hud)
	READ_FILE(S["inquisitive_ghost"], inquisitive_ghost)
	READ_FILE(S["uses_glasses_colour"], uses_glasses_colour)
	READ_FILE(S["clientfps"], clientfps)
	READ_FILE(S["parallax"], parallax)
	READ_FILE(S["ambientocclusion"], ambientocclusion)
	READ_FILE(S["auto_fit_viewport"], auto_fit_viewport)
	READ_FILE(S["old_discipline"], old_discipline)
	READ_FILE(S["widescreenpref"], widescreenpref)
	READ_FILE(S["pixel_size"], pixel_size)
	READ_FILE(S["scaling_method"], scaling_method)
	READ_FILE(S["menuoptions"], menuoptions)
	READ_FILE(S["enable_tips"], enable_tips)
	READ_FILE(S["tip_delay"], tip_delay)
	READ_FILE(S["pda_style"], pda_style)
	READ_FILE(S["pda_color"], pda_color)

	// custom hotkeys
	READ_FILE(S["key_bindings"], key_bindings)
	check_keybindings()

	// hearted
	READ_FILE(S["hearted_until"], hearted_until)
	if(hearted_until > world.realtime)
		hearted = TRUE

	// try to fix any outdated data if necessary
	if(needs_update >= 0)
		var/bacpath = "[path].updatebac" // todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) // only keep 1 version of backup
		fcopy(S, bacpath) // byond helpfully lets you use a savefile for the first arg.
		update_preferences(needs_update, S)	// needs_update = savefile_version if we need an update (positive integer)

	//Sanitize
	asaycolor		= sanitize_ooccolor(sanitize_hexcolor(asaycolor, 6, 1, initial(asaycolor)))
	ooccolor		= sanitize_ooccolor(sanitize_hexcolor(ooccolor, 6, 1, initial(ooccolor)))
	lastchangelog	= sanitize_text(lastchangelog, initial(lastchangelog))
	UI_style		= sanitize_inlist(UI_style, GLOB.available_ui_styles, GLOB.available_ui_styles[1])
	hotkeys			= sanitize_integer(hotkeys, FALSE, TRUE, initial(hotkeys))
	chat_on_map		= sanitize_integer(chat_on_map, FALSE, TRUE, initial(chat_on_map))
	max_chat_length = sanitize_integer(max_chat_length, 1, CHAT_MESSAGE_MAX_LENGTH, initial(max_chat_length))
	see_chat_non_mob	= sanitize_integer(see_chat_non_mob, FALSE, TRUE, initial(see_chat_non_mob))
	see_rc_emotes	= sanitize_integer(see_rc_emotes, FALSE, TRUE, initial(see_rc_emotes))
	broadcast_login_logout = sanitize_integer(broadcast_login_logout, FALSE, TRUE, initial(broadcast_login_logout))
	tgui_fancy		= sanitize_integer(tgui_fancy, FALSE, TRUE, initial(tgui_fancy))
	tgui_lock		= sanitize_integer(tgui_lock, FALSE, TRUE, initial(tgui_lock))
	buttons_locked	= sanitize_integer(buttons_locked, FALSE, TRUE, initial(buttons_locked))
	windowflashing	= sanitize_integer(windowflashing, FALSE, TRUE, initial(windowflashing))
	default_slot	= sanitize_integer(default_slot, 1, max_save_slots, initial(default_slot))
	toggles			= sanitize_integer(toggles, 0, (2**24)-1, initial(toggles))
	clientfps		= sanitize_integer(clientfps, -1, 1000, 0)
	parallax		= sanitize_integer(parallax, PARALLAX_INSANE, PARALLAX_DISABLE, null)
	ambientocclusion	= sanitize_integer(ambientocclusion, FALSE, TRUE, initial(ambientocclusion))
	auto_fit_viewport	= sanitize_integer(auto_fit_viewport, FALSE, TRUE, initial(auto_fit_viewport))
	old_discipline	= sanitize_integer(old_discipline, FALSE, TRUE, initial(old_discipline))
	widescreenpref  = sanitize_integer(widescreenpref, FALSE, TRUE, initial(widescreenpref))
	pixel_size		= sanitize_float(pixel_size, PIXEL_SCALING_AUTO, PIXEL_SCALING_3X, 0.5, initial(pixel_size))
	scaling_method  = sanitize_text(scaling_method, initial(scaling_method))
	ghost_form		= sanitize_inlist(ghost_form, GLOB.ghost_forms, initial(ghost_form))
	ghost_orbit 	= sanitize_inlist(ghost_orbit, GLOB.ghost_orbits, initial(ghost_orbit))
	ghost_accs		= sanitize_inlist(ghost_accs, GLOB.ghost_accs_options, GHOST_ACCS_DEFAULT_OPTION)
	ghost_others	= sanitize_inlist(ghost_others, GLOB.ghost_others_options, GHOST_OTHERS_DEFAULT_OPTION)
	menuoptions		= SANITIZE_LIST(menuoptions)
	be_special		= SANITIZE_LIST(be_special)
	pda_style		= sanitize_inlist(pda_style, GLOB.pda_styles, initial(pda_style))
	pda_color		= sanitize_hexcolor(pda_color, 6, 1, initial(pda_color))
	key_bindings 	= sanitize_keybindings(key_bindings)

	if(needs_update >= 0) //save the updated version
		var/old_default_slot = default_slot
		var/old_max_save_slots = max_save_slots

		for (var/slot in S.dir) //but first, update all current character slots.
			if (copytext(slot, 1, 10) != "character")
				continue
			var/slotnum = text2num(copytext(slot, 10))
			if (!slotnum)
				continue
			max_save_slots = max(max_save_slots, slotnum) //so we can still update byond member slots after they lose memeber status
			default_slot = slotnum
			if (load_character())
				save_character()
		default_slot = old_default_slot
		max_save_slots = old_max_save_slots
		save_preferences()

	return TRUE

/datum/preferences/proc/load_character(slot)
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"
	if(!slot)
		slot = default_slot
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		WRITE_FILE(S["default_slot"] , slot)

	S.cd = "/character[slot]"
	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2) // fatal, can't load any data
		return FALSE

	READ_FILE(S["slotlocked"], slotlocked)
	slotlocked = sanitize_integer(slotlocked, 0, 1, initial(slotlocked))

	// generic info
	var/species_id
	READ_FILE(S["species"], species_id)
	if(species_id)
		var/newtype = GLOB.species_list[species_id]
		if(newtype)
			pref_species = new newtype

	READ_FILE(S["gender"], gender)
	gender = sanitize_gender(gender)

	READ_FILE(S["real_name"], real_name)
	real_name = reject_bad_name(real_name)
	if(!real_name)
		real_name = random_unique_name(gender)

	READ_FILE(S["body_type"], body_type)
	body_type = sanitize_gender(body_type, FALSE, FALSE, gender)

	READ_FILE(S["age"], age)
	age	= sanitize_integer(age, AGE_MIN, AGE_MAX, initial(age))

	READ_FILE(S["total_age"], total_age)
	total_age = sanitize_integer(total_age, AGE_MIN, TOTAL_AGE_MAX, initial(total_age))

	READ_FILE(S["hair_color"], hair_color)
	hair_color = sanitize_hexcolor(hair_color)

	READ_FILE(S["facial_hair_color"], facial_hair_color)
	facial_hair_color = sanitize_hexcolor(facial_hair_color)

	READ_FILE(S["eye_color"], eye_color)
	eye_color = sanitize_hexcolor(eye_color)

	READ_FILE(S["skin_tone"], skin_tone)
	skin_tone = sanitize_hexcolor(skin_tone)

	READ_FILE(S["hairstyle_name"], hairstyle)
	hairstyle = sanitize_inlist(hairstyle, GLOB.hairstyles_list)

	READ_FILE(S["facial_style_name"], facial_hairstyle)
	facial_hairstyle = sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_list)

	READ_FILE(S["underwear"], underwear)
	underwear = sanitize_inlist(underwear, GLOB.underwear_list)

	READ_FILE(S["underwear_color"], underwear_color)
	underwear_color = sanitize_hexcolor(underwear_color)

	READ_FILE(S["undershirt"], undershirt)
	undershirt = sanitize_inlist(undershirt, GLOB.undershirt_list)

	READ_FILE(S["socks"], socks)
	socks = sanitize_inlist(socks, GLOB.socks_list)

	READ_FILE(S["backpack"], backpack)
	backpack = sanitize_inlist(backpack, GLOB.backpacklist, initial(backpack))


	// jobs
	READ_FILE(S["joblessrole"], joblessrole)
	joblessrole	= sanitize_integer(joblessrole, 1, 3, initial(joblessrole))

	READ_FILE(S["job_preferences"], job_preferences)
	for(var/j in job_preferences)
		if(job_preferences[j] != JP_LOW && job_preferences[j] != JP_MEDIUM && job_preferences[j] != JP_HIGH)
			job_preferences -= j

	READ_FILE(S["alt_titles_preferences"], alt_titles_preferences)
	alt_titles_preferences = SANITIZE_LIST(alt_titles_preferences)
	if(SSjob)
		for(var/datum/job/job in sortList(SSjob.occupations, /proc/cmp_job_display_asc))
			if(alt_titles_preferences[job.title])
				if(!(alt_titles_preferences[job.title] in job.alt_titles))
					alt_titles_preferences.Remove(job.title)


	// quirks
	READ_FILE(S["all_quirks"], all_quirks)
	all_quirks = SANITIZE_LIST(all_quirks)
	validate_quirks()


	// basic character stats
	READ_FILE(S["true_experience"], true_experience)
	true_experience = sanitize_integer(true_experience, 0, 99999999, initial(true_experience))

	READ_FILE(S["archetype"], archetype)
	archetype = sanitize_inlist(archetype, subtypesof(/datum/archetype))

	READ_FILE(S["physique"], physique)
	physique = sanitize_integer(physique, 1, 10, initial(physique))

	READ_FILE(S["dexterity"], dexterity)
	dexterity = sanitize_integer(dexterity, 1, 10, initial(dexterity))

	READ_FILE(S["social"], social)
	social = sanitize_integer(social, 1, 10, initial(social))

	READ_FILE(S["mentality"], mentality)
	mentality = sanitize_integer(mentality, 1, 10, initial(mentality))

	READ_FILE(S["lockpicking"], lockpicking)
	lockpicking = sanitize_integer(lockpicking, 1, 10, initial(lockpicking))

	READ_FILE(S["athletics"], athletics)
	athletics = sanitize_integer(athletics, 1, 10, initial(athletics))

	READ_FILE(S["blood"], blood)
	blood = sanitize_integer(blood, 1, 10, initial(blood))


	// background info
	READ_FILE(S["info_known"], info_known)
	info_known = sanitize_inlist(info_known, list(INFO_KNOWN_UNKNOWN, INFO_KNOWN_CLAN_ONLY, INFO_KNOWN_FACTION, INFO_KNOWN_PUBLIC), INFO_KNOWN_UNKNOWN)

	READ_FILE(S["friend"], friend)
	friend = sanitize_integer(friend, 0, 1, initial(friend))

	READ_FILE(S["enemy"], enemy)
	enemy = sanitize_integer(enemy, 0, 1, initial(enemy))

	READ_FILE(S["lover"], lover)
	lover = sanitize_integer(lover, 0, 1, initial(lover))

	READ_FILE(S["friend_text"], friend_text)
	friend_text = sanitize_text(friend_text)

	READ_FILE(S["enemy_text"], enemy_text)
	enemy_text = sanitize_text(enemy_text)

	READ_FILE(S["lover_text"], lover_text)
	lover_text = sanitize_text(lover_text)

	READ_FILE(S["reason_of_death"], reason_of_death)
	reason_of_death = sanitize_text(reason_of_death)

	READ_FILE(S["flavor_text"], flavor_text)
	flavor_text = sanitize_text(flavor_text)

	READ_FILE(S["flavor_text_nsfw"], flavor_text_nsfw)
	flavor_text_nsfw = sanitize_text(flavor_text_nsfw)

	READ_FILE(S["ooc_notes"], ooc_notes)
	ooc_notes = sanitize_text(ooc_notes)

	READ_FILE(S["headshot_link"], headshot_link)
	if(!valid_headshot_link(null, headshot_link, TRUE))
		headshot_link = null


	// werewolves
	READ_FILE(S["werewolf_name"], werewolf_name)
	werewolf_name = reject_bad_name(werewolf_name)
	if(!werewolf_name)
		werewolf_name = random_unique_name(werewolf_name)

	READ_FILE(S["breed"], breed)
	breed = sanitize_inlist(breed, list("Homid", "Lupus", "Metis"))

	READ_FILE(S["tribe"], tribe)
	tribe = sanitize_inlist(tribe, list("Wendigo", "Glasswalkers", "Black Spiral Dancers"))

	READ_FILE(S["werewolf_hair"], werewolf_hair)
	werewolf_hair = sanitize_integer(werewolf_hair, 0, 4, initial(werewolf_hair))

	READ_FILE(S["werewolf_hair_color"], werewolf_hair_color)
	werewolf_hair_color = sanitize_ooccolor(werewolf_hair_color, 3, 0)

	READ_FILE(S["werewolf_eye_color"], werewolf_eye_color)
	werewolf_eye_color = sanitize_ooccolor(werewolf_eye_color, 3, 0)

	READ_FILE(S["werewolf_color"], werewolf_color)
	werewolf_color = sanitize_inlist(werewolf_color, list("black", "gray", "red", "white", "ginger", "brown"))

	READ_FILE(S["werewolf_scar"], werewolf_scar)
	werewolf_scar = sanitize_integer(werewolf_scar, 0, 7, initial(werewolf_scar))


	// werewolf stats
	var/auspice_id
	READ_FILE(S["auspice"], auspice_id)
	if(auspice_id)
		var/newtype = GLOB.auspices_list[auspice_id]
		if(newtype)
			auspice = new newtype

	READ_FILE(S["auspice_level"], auspice_level)
	auspice_level = sanitize_integer(auspice_level, 1, 5, initial(auspice_level))


	// clans
	var/clan_type
	READ_FILE(S["clan"], clan_type)
	if (clan_type)
		clan = GLOB.vampire_clans[clan_type]

	READ_FILE(S["clan_accessory"], clan_accessory)
	if(clan?.accessories)
		clan_accessory = sanitize_inlist(clan_accessory, clan.accessories)
	else
		clan_accessory = null

	READ_FILE(S["generation"], generation)
	generation = sanitize_integer(generation, 3, 13, initial(generation))

	READ_FILE(S["generation_bonus"], generation_bonus)
	generation_bonus = sanitize_integer(generation_bonus, 0, 6, initial(generation_bonus))

	READ_FILE(S["masquerade"], masquerade)
	masquerade = sanitize_integer(masquerade, 0, 5, initial(masquerade))


	// vampire stats
	READ_FILE(S["diablerist"], diablerist)
	diablerist = sanitize_integer(diablerist, 0, 1, initial(diablerist))

	READ_FILE(S["humanity"], humanity)
	humanity = sanitize_integer(humanity, 0, 10, initial(humanity))
	if(humanity <= 0)
		humanity = 1

	READ_FILE(S["enlightement"], enlightenment)
	enlightenment = sanitize_integer(enlightenment, 0, 1, initial(enlightenment))

	READ_FILE(S["torpor_count"], torpor_count)
	torpor_count = sanitize_integer(torpor_count, 0, 6, initial(torpor_count))


	// disciplines
	READ_FILE(S["discipline_types"], discipline_types)
	discipline_types = sanitize_islist(discipline_types, list())

	READ_FILE(S["discipline_levels"], discipline_levels)
	discipline_levels = sanitize_islist(discipline_levels, list())


	// keui jin
	READ_FILE(S["dharma_type"], dharma_type)
	dharma_type = sanitize_inlist(dharma_type, subtypesof(/datum/dharma))

	READ_FILE(S["dharma_level"], dharma_level)
	dharma_level = sanitize_integer(dharma_level, 0, 6, initial(dharma_level))
	if(dharma_level <= 0)
		dharma_level = 1

	READ_FILE(S["po_type"], po_type)
	po_type = sanitize_inlist(po_type, list("Rebel", "Legalist", "Demon", "Monkey", "Fool"))

	READ_FILE(S["po"], po)
	po = sanitize_integer(po, 1, 12, initial(po))

	READ_FILE(S["hun"], hun)
	hun = sanitize_integer(hun, 1, 12, initial(hun))

	READ_FILE(S["yang"], yang)
	yang = sanitize_integer(yang, 1, 12, initial(yang))

	READ_FILE(S["yin"], yin)
	yin = sanitize_integer(yin, 1, 12, initial(yin))

	READ_FILE(S["chi_types"], chi_types)
	chi_types = sanitize_islist(chi_types, list())

	READ_FILE(S["chi_levels"], chi_levels)
	chi_levels = sanitize_islist(chi_levels, list())


	// misc
	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	jumpsuit_style = sanitize_inlist(jumpsuit_style, GLOB.jumpsuitlist, initial(jumpsuit_style))

	READ_FILE(S["uplink_loc"], uplink_spawn_loc)
	uplink_spawn_loc = sanitize_inlist(uplink_spawn_loc, GLOB.uplink_spawn_loc_list, initial(uplink_spawn_loc))

	READ_FILE(S["playtime_reward_cloak"], playtime_reward_cloak)
	playtime_reward_cloak = sanitize_integer(playtime_reward_cloak)

	READ_FILE(S["randomise"], randomise)
	randomise = SANITIZE_LIST(randomise)

	READ_FILE(S["phobia"], phobia)
	phobia = sanitize_inlist(phobia, SStraumas.phobia_types)

	READ_FILE(S["persistent_scars"] , persistent_scars)
	persistent_scars = sanitize_integer(persistent_scars)

	READ_FILE(S["preferred_ai_core_display"], preferred_ai_core_display)
	preferred_ai_core_display = sanitize_inlist(preferred_ai_core_display, GLOB.ai_core_display_screens)

	READ_FILE(S["prefered_security_department"], prefered_security_department)
	prefered_security_department = sanitize_inlist(prefered_security_department, GLOB.security_depts_prefs)


	// mutant parts
	READ_FILE(S["feature_mcolor"], features["mcolor"])
	features["mcolor"] = sanitize_hexcolor(features["mcolor"])

	READ_FILE(S["feature_ethcolor"], features["ethcolor"])
	features["ethcolor"] = copytext_char(features["ethcolor"], 1, 7)

	READ_FILE(S["feature_lizard_tail"], features["tail_lizard"])
	features["tail_lizard"] = sanitize_inlist(features["tail_lizard"], GLOB.tails_list_lizard)

	READ_FILE(S["feature_lizard_snout"], features["snout"])
	features["snout"] = sanitize_inlist(features["snout"], GLOB.snouts_list)

	READ_FILE(S["feature_lizard_horns"], features["horns"])
	features["horns"] = sanitize_inlist(features["horns"], GLOB.horns_list)

	READ_FILE(S["feature_lizard_frills"], features["frills"])
	features["frills"] = sanitize_inlist(features["frills"], GLOB.frills_list)

	READ_FILE(S["feature_lizard_spines"], features["spines"])
	features["spines"] = sanitize_inlist(features["spines"], GLOB.spines_list)

	READ_FILE(S["feature_lizard_body_markings"], features["body_markings"])
	features["body_markings"] = sanitize_inlist(features["body_markings"], GLOB.body_markings_list)

	READ_FILE(S["feature_lizard_legs"], features["legs"])
	features["feature_lizard_legs"] = sanitize_inlist(features["legs"], GLOB.legs_list, "Normal Legs")

	READ_FILE(S["feature_moth_wings"], features["moth_wings"])
	features["moth_wings"] = sanitize_inlist(features["moth_wings"], GLOB.moth_wings_list, "Plain")

	READ_FILE(S["feature_moth_antennae"], features["moth_antennae"])
	features["moth_antennae"] = sanitize_inlist(features["moth_antennae"], GLOB.moth_antennae_list, "Plain")

	READ_FILE(S["feature_moth_markings"], features["moth_markings"])
	features["moth_markings"] = sanitize_inlist(features["moth_markings"], GLOB.moth_markings_list, "None")

	if(!CONFIG_GET(flag/join_with_mutant_humans))
		features["tail_human"] = "none"
		features["ears"] = "none"
	else
		READ_FILE(S["feature_human_tail"], features["tail_human"])
		features["tail_human"] = sanitize_inlist(features["tail_human"], GLOB.tails_list_human, "None")

		READ_FILE(S["feature_human_ears"], features["ears"])
		features["ears"] = sanitize_inlist(features["ears"], GLOB.ears_list, "None")


	//try to fix any outdated data if necessary
	//preference updating will handle saving the updated data for us.
	if(needs_update >= 0)
		update_character(needs_update, S)		//needs_update == savefile_version if we need an update (positive integer)

	/*
	//Convert jank old Discipline system to new Discipline system
	// keeping this here for reference in case something breaks
	if ((istype(pref_species, /datum/species/kindred) || istype(pref_species, /datum/species/ghoul)) && !discipline_types.len)
		if (discipline1type && discipline1level)
			discipline_types += discipline1type
			discipline_levels += discipline1level
			discipline1type = null
			discipline1level = null
		if (discipline2type && discipline2level)
			discipline_types += discipline2type
			discipline_levels += discipline2level
			discipline2type = null
			discipline2level = null
		if (discipline3type && discipline3level)
			discipline_types += discipline3type
			discipline_levels += discipline3level
			discipline3type = null
			discipline3level = null
		if (discipline4type && discipline4level)
			discipline_types += discipline4type
			discipline_levels += discipline4level
			discipline4type = null
			discipline4level = null
	*/

	//repair some damage done by an exploit by resetting
	if ((true_experience > 1000) && !check_rights_for(parent, R_ADMIN))
		message_admins("[ADMIN_LOOKUPFLW(parent)] loaded a character slot with [true_experience] experience. The slot has been reset.")
		log_game("[key_name(parent)] loaded a character slot with [true_experience] experience. The slot has been reset.")
		to_chat(parent, "<span class='userdanger'>You tried to load a character slot with [true_experience] experience. It has been reset.</span>")
		reset_character()

	return TRUE

