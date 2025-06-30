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

	// Custom hotkeys
	READ_FILE(S["key_bindings"], key_bindings)
	check_keybindings()
	// hearted
	READ_FILE(S["hearted_until"], hearted_until)
	if(hearted_until > world.realtime)
		hearted = TRUE

	//try to fix any outdated data if necessary
	if(needs_update >= 0)
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		update_preferences(needs_update, S)		//needs_update = savefile_version if we need an update (positive integer)



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
	if(needs_update == -2)		//fatal, can't load any data
		return FALSE

	//Species
	var/species_id
	READ_FILE(S["species"], species_id)
	if(species_id)
		var/newtype = GLOB.species_list[species_id]
		if(newtype)
			pref_species = new newtype

	var/clan_type
	READ_FILE(S["clan"], clan_type)
	if (clan_type)
		clan = GLOB.vampire_clans[clan_type]

	READ_FILE(S["clan_accessory"], clan_accessory)
	if(clan?.accessories)
		clan_accessory = sanitize_inlist(clan_accessory, clan.accessories, null)
	else
		clan_accessory = null

	var/auspice_id
	READ_FILE(S["auspice"], auspice_id)
	if(auspice_id)
		var/newtype = GLOB.auspices_list[auspice_id]
		if(newtype)
			auspice = new newtype

	READ_FILE(S["breed"], breed)
	READ_FILE(S["tribe"], tribe)
	READ_FILE(S["werewolf_color"], werewolf_color)
	READ_FILE(S["werewolf_scar"], werewolf_scar)
	READ_FILE(S["werewolf_hair"], werewolf_hair)
	READ_FILE(S["werewolf_hair_color"], werewolf_hair_color)
	READ_FILE(S["werewolf_eye_color"], werewolf_eye_color)

	//Character
	READ_FILE(S["slotlocked"], slotlocked)
	READ_FILE(S["diablerist"], diablerist)
	READ_FILE(S["auspice_level"], auspice_level)
	READ_FILE(S["humanity"], humanity)
	READ_FILE(S["enlightement"], enlightenment)
	READ_FILE(S["exper"], exper)
	READ_FILE(S["exper_plus"], exper_plus)
	READ_FILE(S["true_experience"], true_experience)
	READ_FILE(S["physique"], physique)
	READ_FILE(S["dexterity"], dexterity)
	READ_FILE(S["social"], social)
	READ_FILE(S["mentality"], mentality)
	READ_FILE(S["lockpicking"], lockpicking)
	READ_FILE(S["athletics"], athletics)
	READ_FILE(S["blood"], blood)
	READ_FILE(S["archetype"], archetype)
	READ_FILE(S["discipline1level"], discipline1level)
	READ_FILE(S["discipline2level"], discipline2level)
	READ_FILE(S["discipline3level"], discipline3level)
	READ_FILE(S["discipline4level"], discipline4level)
	READ_FILE(S["discipline1type"], discipline1type)
	READ_FILE(S["discipline2type"], discipline2type)
	READ_FILE(S["discipline3type"], discipline3type)
	READ_FILE(S["discipline4type"], discipline4type)
	READ_FILE(S["discipline_types"], discipline_types)
	READ_FILE(S["discipline_levels"], discipline_levels)
	READ_FILE(S["info_known"], info_known)
	READ_FILE(S["friend"], friend)
	READ_FILE(S["enemy"], enemy)
	READ_FILE(S["lover"], lover)
	READ_FILE(S["flavor_text"], flavor_text)
	READ_FILE(S["ooc_notes"], ooc_notes)
	READ_FILE(S["friend_text"], friend_text)
	READ_FILE(S["enemy_text"], enemy_text)
	READ_FILE(S["lover_text"], lover_text)
	READ_FILE(S["reason_of_death"], reason_of_death)
	READ_FILE(S["generation"], generation)
	READ_FILE(S["generation_bonus"], generation_bonus)
	READ_FILE(S["masquerade"], masquerade)
	READ_FILE(S["real_name"], real_name)
	READ_FILE(S["werewolf_name"], werewolf_name)
	READ_FILE(S["gender"], gender)
	READ_FILE(S["body_type"], body_type)
	READ_FILE(S["body_model"], body_model)
	READ_FILE(S["age"], age)
	READ_FILE(S["torpor_count"], torpor_count)
	READ_FILE(S["total_age"], total_age)
	READ_FILE(S["hair_color"], hair_color)
	READ_FILE(S["facial_hair_color"], facial_hair_color)
	READ_FILE(S["eye_color"], eye_color)
	READ_FILE(S["skin_tone"], skin_tone)
	READ_FILE(S["hairstyle_name"], hairstyle)
	READ_FILE(S["facial_style_name"], facial_hairstyle)
	READ_FILE(S["underwear"], underwear)
	READ_FILE(S["underwear_color"], underwear_color)
	READ_FILE(S["undershirt"], undershirt)
	READ_FILE(S["socks"], socks)
	READ_FILE(S["backpack"], backpack)
	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	READ_FILE(S["uplink_loc"], uplink_spawn_loc)
	// READ_FILE(S["clan_accessory"], clan_accessory)
	READ_FILE(S["playtime_reward_cloak"], playtime_reward_cloak)
	READ_FILE(S["phobia"], phobia)
	READ_FILE(S["randomise"],  randomise)
	READ_FILE(S["feature_mcolor"], features["mcolor"])
	READ_FILE(S["feature_ethcolor"], features["ethcolor"])
	READ_FILE(S["feature_lizard_tail"], features["tail_lizard"])
	READ_FILE(S["feature_lizard_snout"], features["snout"])
	READ_FILE(S["feature_lizard_horns"], features["horns"])
	READ_FILE(S["feature_lizard_frills"], features["frills"])
	READ_FILE(S["feature_lizard_spines"], features["spines"])
	READ_FILE(S["feature_lizard_body_markings"], features["body_markings"])
	READ_FILE(S["feature_lizard_legs"], features["legs"])
	READ_FILE(S["feature_moth_wings"], features["moth_wings"])
	READ_FILE(S["feature_moth_antennae"], features["moth_antennae"])
	READ_FILE(S["feature_moth_markings"], features["moth_markings"])
	READ_FILE(S["persistent_scars"] , persistent_scars)
	READ_FILE(S["dharma_type"], dharma_type)
	READ_FILE(S["dharma_level"], dharma_level)
	READ_FILE(S["po_type"], po_type)
	READ_FILE(S["po"], po)
	READ_FILE(S["hun"], hun)
	READ_FILE(S["yang"], yang)
	READ_FILE(S["yin"], yin)
	READ_FILE(S["chi_types"], chi_types)
	READ_FILE(S["chi_levels"], chi_levels)
	if(!CONFIG_GET(flag/join_with_mutant_humans))
		features["tail_human"] = "none"
		features["ears"] = "none"
	else
		READ_FILE(S["feature_human_tail"], features["tail_human"])
		READ_FILE(S["feature_human_ears"], features["ears"])

	READ_FILE(S["preferred_ai_core_display"], preferred_ai_core_display)
	READ_FILE(S["prefered_security_department"], prefered_security_department)

	//Jobs
	READ_FILE(S["joblessrole"], joblessrole)
	//Load prefs
	READ_FILE(S["job_preferences"], job_preferences)

	//Quirks
	READ_FILE(S["all_quirks"], all_quirks)

	READ_FILE(S["headshot_link"], headshot_link)

	// TFN EDIT START: alt job titles
	READ_FILE(S["alt_titles_preferences"], alt_titles_preferences)
	alt_titles_preferences = SANITIZE_LIST(alt_titles_preferences)
	if(SSjob)
		for(var/datum/job/job in sortList(SSjob.occupations, /proc/cmp_job_display_asc))
			if(alt_titles_preferences[job.title])
				if(!(alt_titles_preferences[job.title] in job.alt_titles))
					alt_titles_preferences.Remove(job.title)
	// TFN EDIT END

	//try to fix any outdated data if necessary
	//preference updating will handle saving the updated data for us.
	if(needs_update >= 0)
		update_character(needs_update, S)		//needs_update == savefile_version if we need an update (positive integer)

	//Sanitize
	real_name = reject_bad_name(real_name)
	werewolf_name = reject_bad_name(werewolf_name)
	gender = sanitize_gender(gender)
	body_type = sanitize_gender(body_type, FALSE, FALSE, gender)
	body_model = sanitize_integer(body_model, SLIM_BODY_MODEL_NUMBER, FAT_BODY_MODEL_NUMBER, initial(body_model))
	if(!real_name)
		real_name = random_unique_name(gender)

	//Prevent Wighting upon joining a round
	if(humanity <= 0)
		humanity = 1

	if(dharma_level <= 0)
		dharma_level = 1

	if(!features["mcolor"] || features["mcolor"] == "#000")
		features["mcolor"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")

	if(!features["ethcolor"] || features["ethcolor"] == "#000")
		features["ethcolor"] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]

	randomise = SANITIZE_LIST(randomise)

	if(gender == MALE)
		hairstyle			= sanitize_inlist(hairstyle, GLOB.hairstyles_male_list)
		facial_hairstyle			= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_male_list)
		underwear		= sanitize_inlist(underwear, GLOB.underwear_m)
		undershirt 		= sanitize_inlist(undershirt, GLOB.undershirt_m)
	else if(gender == FEMALE)
		hairstyle			= sanitize_inlist(hairstyle, GLOB.hairstyles_female_list)
		facial_hairstyle			= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_female_list)
		underwear		= sanitize_inlist(underwear, GLOB.underwear_f)
		undershirt		= sanitize_inlist(undershirt, GLOB.undershirt_f)
	else
		hairstyle			= sanitize_inlist(hairstyle, GLOB.hairstyles_list)
		facial_hairstyle			= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_list)
		underwear		= sanitize_inlist(underwear, GLOB.underwear_list)
		undershirt 		= sanitize_inlist(undershirt, GLOB.undershirt_list)

	archetype 		= sanitize_inlist(archetype, subtypesof(/datum/archetype))

	breed			= sanitize_inlist(breed, list("Homid", "Lupus", "Metis"))
	tribe			= sanitize_inlist(tribe, list("Wendigo", "Glasswalkers", "Black Spiral Dancers"))
	werewolf_color	= sanitize_inlist(werewolf_color, list("black", "gray", "red", "white", "ginger", "brown"))
	werewolf_scar	= sanitize_integer(werewolf_scar, 0, 7, initial(werewolf_scar))
	werewolf_hair	= sanitize_integer(werewolf_hair, 0, 4, initial(werewolf_hair))
	werewolf_hair_color		= sanitize_ooccolor(werewolf_hair_color, 3, 0)
	werewolf_eye_color		= sanitize_ooccolor(werewolf_eye_color, 3, 0)
	flavor_text	= sanitize_text(flavor_text)
	ooc_notes = sanitize_text(ooc_notes)
	socks			= sanitize_inlist(socks, GLOB.socks_list)
	age				= sanitize_integer(age, AGE_MIN, AGE_MAX, initial(age))
	diablerist				= sanitize_integer(diablerist, 0, 1, initial(diablerist))
	friend_text		= sanitize_text(friend_text)
	enemy_text		= sanitize_text(enemy_text)
	lover_text		= sanitize_text(lover_text)
	reason_of_death	= sanitize_text(reason_of_death)
	torpor_count				= sanitize_integer(torpor_count, 0, 6, initial(torpor_count))
	total_age		= sanitize_integer(total_age, 18, 1120, initial(total_age))
	slotlocked			= sanitize_integer(slotlocked, 0, 1, initial(slotlocked))
	humanity				= sanitize_integer(humanity, 0, 10, initial(humanity))
	enlightenment				= sanitize_integer(enlightenment, 0, 1, initial(enlightenment))
	exper				= sanitize_integer(exper, 0, 99999999, initial(exper))
	exper_plus				= sanitize_integer(exper_plus, 0, 99999999, initial(exper_plus))
	true_experience				= sanitize_integer(true_experience, 0, 99999999, initial(true_experience))
	physique				= sanitize_integer(physique, 1, 10, initial(physique))
	dexterity				= sanitize_integer(dexterity, 1, 10, initial(dexterity))
	social					= sanitize_integer(social, 1, 10, initial(social))
	mentality				= sanitize_integer(mentality, 1, 10, initial(mentality))
	lockpicking				= sanitize_integer(lockpicking, 1, 10, initial(lockpicking))
	athletics				= sanitize_integer(athletics, 1, 10, initial(athletics))
	blood					= sanitize_integer(blood, 1, 10, initial(blood))
	auspice_level			= sanitize_integer(auspice_level, 1, 5, initial(auspice_level))
	discipline1level				= sanitize_integer(discipline1level, 1, 5, initial(discipline1level))
	discipline2level				= sanitize_integer(discipline2level, 1, 5, initial(discipline2level))
	discipline3level				= sanitize_integer(discipline3level, 1, 5, initial(discipline3level))
	discipline4level				= sanitize_integer(discipline4level, 1, 5, initial(discipline4level))
	discipline1type				= sanitize_discipline(discipline1type, subtypesof(/datum/discipline))
	discipline2type				= sanitize_discipline(discipline2type, subtypesof(/datum/discipline))
	discipline3type				= sanitize_discipline(discipline3type, subtypesof(/datum/discipline))
	if(discipline4type)
		discipline4type				= sanitize_discipline(discipline4type, subtypesof(/datum/discipline))
	discipline_types = sanitize_islist(discipline_types, list())
	discipline_levels = sanitize_islist(discipline_levels, list())
	dharma_level = sanitize_integer(dharma_level, 0, 6, initial(dharma_level))
	dharma_type = sanitize_inlist(dharma_type, subtypesof(/datum/dharma))
	po_type = sanitize_inlist(po_type, list("Rebel", "Legalist", "Demon", "Monkey", "Fool"))
	po = sanitize_integer(po, 1, 12, initial(po))
	hun = sanitize_integer(hun, 1, 12, initial(hun))
	yang = sanitize_integer(yang, 1, 12, initial(yang))
	yin = sanitize_integer(yin, 1, 12, initial(yin))
	chi_types = sanitize_islist(chi_types, list())
	chi_levels = sanitize_islist(chi_levels, list())
	//TODO: custom sanitization for discipline_types and discipline_levels
	friend				= sanitize_integer(friend, 0, 1, initial(friend))
	enemy				= sanitize_integer(enemy, 0, 1, initial(enemy))
	lover				= sanitize_integer(lover, 0, 1, initial(lover))
	masquerade				= sanitize_integer(masquerade, 0, 5, initial(masquerade))
	generation				= sanitize_integer(generation, 3, 13, initial(generation))
	generation_bonus				= sanitize_integer(generation_bonus, 0, 6, initial(generation_bonus))
	hair_color			= sanitize_hexcolor(hair_color)
	facial_hair_color			= sanitize_hexcolor(facial_hair_color)
	underwear_color			= sanitize_hexcolor(underwear_color)
	eye_color		= sanitize_hexcolor(eye_color)
	skin_tone		= sanitize_hexcolor(skin_tone)
	backpack			= sanitize_inlist(backpack, GLOB.backpacklist, initial(backpack))
	jumpsuit_style	= sanitize_inlist(jumpsuit_style, GLOB.jumpsuitlist, initial(jumpsuit_style))
	uplink_spawn_loc = sanitize_inlist(uplink_spawn_loc, GLOB.uplink_spawn_loc_list, initial(uplink_spawn_loc))
	if(clan?.accessories)
		clan_accessory = sanitize_inlist(clan_accessory, clan.accessories, null)
	else
		clan_accessory = null
	playtime_reward_cloak = sanitize_integer(playtime_reward_cloak)
	features["mcolor"]	= sanitize_hexcolor(features["mcolor"])
	features["ethcolor"]	= copytext_char(features["ethcolor"], 1, 7)
	features["tail_lizard"]	= sanitize_inlist(features["tail_lizard"], GLOB.tails_list_lizard)
	features["tail_human"] 	= sanitize_inlist(features["tail_human"], GLOB.tails_list_human, "None")
	features["snout"]	= sanitize_inlist(features["snout"], GLOB.snouts_list)
	features["horns"] 	= sanitize_inlist(features["horns"], GLOB.horns_list)
	features["ears"]	= sanitize_inlist(features["ears"], GLOB.ears_list, "None")
	features["frills"] 	= sanitize_inlist(features["frills"], GLOB.frills_list)
	features["spines"] 	= sanitize_inlist(features["spines"], GLOB.spines_list)
	features["body_markings"] 	= sanitize_inlist(features["body_markings"], GLOB.body_markings_list)
	features["feature_lizard_legs"]	= sanitize_inlist(features["legs"], GLOB.legs_list, "Normal Legs")
	features["moth_wings"] 	= sanitize_inlist(features["moth_wings"], GLOB.moth_wings_list, "Plain")
	features["moth_antennae"] 	= sanitize_inlist(features["moth_antennae"], GLOB.moth_antennae_list, "Plain")
	features["moth_markings"] 	= sanitize_inlist(features["moth_markings"], GLOB.moth_markings_list, "None")

	persistent_scars = sanitize_integer(persistent_scars)

	joblessrole	= sanitize_integer(joblessrole, 1, 3, initial(joblessrole))
	//Validate job prefs
	for(var/j in job_preferences)
		if(job_preferences[j] != JP_LOW && job_preferences[j] != JP_MEDIUM && job_preferences[j] != JP_HIGH)
			job_preferences -= j

	// validate quirks
	all_quirks = SANITIZE_LIST(all_quirks)
	validate_quirks()

	// validate headshot link
	if(!valid_headshot_link(null, headshot_link, TRUE))
		headshot_link = null

	//Convert jank old Discipline system to new Discipline system
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

	//repair some damage done by an exploit by resetting
	if ((true_experience > 1000) && !check_rights_for(parent, R_ADMIN))
		message_admins("[ADMIN_LOOKUPFLW(parent)] loaded a character slot with [true_experience] experience. The slot has been reset.")
		log_game("[key_name(parent)] loaded a character slot with [true_experience] experience. The slot has been reset.")
		to_chat(parent, "<span class='userdanger'>You tried to load a character slot with [true_experience] experience. It has been reset.</span>")
		reset_character()

	return TRUE

