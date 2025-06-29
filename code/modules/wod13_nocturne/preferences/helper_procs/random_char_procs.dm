/datum/preferences/proc/random_species()
	var/random_species_type
	if(GLOB.roundstart_races.len != 0)
		random_species_type = GLOB.species_list[pick(GLOB.roundstart_races)]
	else
		random_species_type = GLOB.species_list["human"]
	pref_species = new random_species_type
	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)
	if(pref_species.id == "ghoul")
		discipline_types = list()
		discipline_levels = list()
	if(pref_species.id == "kindred")
		clan = GLOB.vampire_clans[/datum/vampire_clan/brujah]
		discipline_types = list()
		discipline_levels = list()
		for (var/i in 1 to clan.clan_disciplines.len)
			discipline_types += clan.clan_disciplines[i]
			discipline_levels += 1

//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/random_character(gender_override, antag_override = FALSE)
	if(randomise[RANDOM_SPECIES])
		random_species()
	else if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)
	if(gender_override && !(randomise[RANDOM_GENDER] || randomise[RANDOM_GENDER_ANTAG] && antag_override))
		gender = gender_override
	else
		gender = pick(MALE,FEMALE)
	if(randomise[RANDOM_AGE] || randomise[RANDOM_AGE_ANTAG] && antag_override)
		age = rand(AGE_MIN,AGE_MAX)
	if(randomise[RANDOM_UNDERWEAR])
		underwear = random_underwear(gender)
	if(randomise[RANDOM_UNDERWEAR_COLOR])
		underwear_color = random_short_color()
	if(randomise[RANDOM_UNDERSHIRT])
		undershirt = random_undershirt(gender)
	if(randomise[RANDOM_SOCKS])
		socks = random_socks()
	if(randomise[RANDOM_BACKPACK])
		backpack = random_backpack()
	if(randomise[RANDOM_JUMPSUIT_STYLE])
		jumpsuit_style = pick(GLOB.jumpsuitlist)
	if(randomise[RANDOM_HAIRSTYLE])
		if(clan?.no_hair)
			hairstyle = "Bald"
		else
			hairstyle = random_hairstyle(gender)
	if(randomise[RANDOM_FACIAL_HAIRSTYLE])
		if(clan?.no_facial)
			facial_hairstyle = "Shaved"
		else
			facial_hairstyle = random_facial_hairstyle(gender)
	if(randomise[RANDOM_HAIR_COLOR])
		hair_color = random_short_color()
	if(randomise[RANDOM_FACIAL_HAIR_COLOR])
		facial_hair_color = random_short_color()
	if(randomise[RANDOM_SKIN_TONE])
		skin_tone = random_skin_tone()
	if(randomise[RANDOM_EYE_COLOR])
		eye_color = random_eye_color()
	if(!pref_species)
		var/rando_race = pick(GLOB.roundstart_races)
		pref_species = new rando_race()
	features = random_features()
	if(gender in list(MALE, FEMALE))
		body_type = gender
	else
		body_type = pick(MALE, FEMALE)

/datum/preferences/proc/reset_character()
	real_name = random_unique_name(gender)
	slotlocked = 0

	flavor_text = null
	flavor_text_nsfw = null
	ooc_notes = null
	headshot_link = null

	diablerist = 0
	torpor_count = 0
	generation_bonus = 0

	archetype = pick(subtypesof(/datum/archetype))
	var/datum/archetype/A = new archetype()
	physique = A.start_physique
	dexterity = A.start_dexterity
	social = A.start_social
	mentality = A.start_mentality
	blood = A.start_blood
	lockpicking = A.start_lockpicking
	athletics = A.start_athletics

	info_known = INFO_KNOWN_UNKNOWN

	masquerade = initial(masquerade)
	generation = initial(generation)
	dharma_level = initial(dharma_level)
	hun = initial(hun)
	po = initial(po)
	yin = initial(yin)
	yang = initial(yang)
	chi_types = list()
	chi_levels = list()

	clan = GLOB.vampire_clans[/datum/vampire_clan/brujah]
	discipline_types = list()
	discipline_levels = list()
	for (var/i in 1 to clan.clan_disciplines.len)
		discipline_types += clan.clan_disciplines[i]
		discipline_levels += 1
	humanity = clan.start_humanity
	enlightenment = clan.enlightenment

	true_experience = 50

	random_species()
	random_character()
	save_character()
