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
	clan_accessory = null

	true_experience = 50

	random_species()
	random_character()
	save_character()
