/datum/preferences/proc/process_input_task_links(mob/user, list/href_list)
	if(href_list["task"] != "input")
		CRASH("process_inpute_task_links called on topic that was not an input task!")

	switch(href_list["preference"])
		// preferences page
		if("ghostform")
			if(unlock_content)
				var/new_form = tgui_input_list(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",GLOB.ghost_forms)
				if(new_form)
					ghost_form = new_form
		if("ghostorbit")
			if(unlock_content)
				var/new_orbit = tgui_input_list(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND",GLOB.ghost_orbits)
				if(new_orbit)
					ghost_orbit = new_orbit
		if("ghostaccs")
			var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
			switch(new_ghost_accs)
				if(GHOST_ACCS_FULL_NAME)
					ghost_accs = GHOST_ACCS_FULL
				if(GHOST_ACCS_DIR_NAME)
					ghost_accs = GHOST_ACCS_DIR
				if(GHOST_ACCS_NONE_NAME)
					ghost_accs = GHOST_ACCS_NONE
		if("ghostothers")
			var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
			switch(new_ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING_NAME)
					ghost_others = GHOST_OTHERS_THEIR_SETTING
				if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
					ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
				if(GHOST_OTHERS_SIMPLE_NAME)
					ghost_others = GHOST_OTHERS_SIMPLE

		if("werewolf_name")
			if(slotlocked || (!pref_species.id == "garou"))
				return

			var/new_name = tgui_input_text(user, "Choose your character's werewolf name:", "Character Preference", max_length = MAX_NAME_LEN)
			if(new_name)
				new_name = reject_bad_name(new_name)
				if(new_name)
					werewolf_name = new_name
				else
					to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and . It must not contain any words restricted by IC chat and name filters.</font>")
		if("name")
			if(slotlocked)
				return

			var/new_name = tgui_input_text(user, "Choose your character's name:", "Character Preference", max_length = MAX_NAME_LEN)
			if(new_name)
				new_name = reject_bad_name(new_name)
				if(new_name)
					real_name = new_name
				else
					to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and . It must not contain any words restricted by IC chat and name filters.</font>")

		if("age")
			if(slotlocked)
				return

			var/new_age = tgui_input_number(user, "Choose your character's biological age:\n([AGE_MIN]-[AGE_MAX])", "Character Preference", age, AGE_MAX, AGE_MIN, round_value = TRUE)
			if(new_age)
				age = clamp(new_age, AGE_MIN, AGE_MAX)
				if (age > total_age)
					total_age = age
				update_preview_icon()

		if("total_age")
			if(slotlocked)
				return

			var/new_age = tgui_input_number(user, "Choose your character's actual age:\n([age]-[age+1000])", "Character Preference", total_age, age+1000, age, round_value = TRUE)
			if(new_age)
				total_age = clamp(new_age, age, age+1000)
				if (total_age < age)
					age = total_age
				update_preview_icon()

		if("info_choose")
			var/new_info_known = tgui_input_list(user, "Choose who knows your character:", "Fame", list(INFO_KNOWN_UNKNOWN, INFO_KNOWN_CLAN_ONLY, INFO_KNOWN_FACTION, INFO_KNOWN_PUBLIC))
			if(new_info_known)
				info_known = new_info_known

		if("hair")
			if(slotlocked)
				return

			var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference","#"+hair_color) as color|null
			if(new_hair)
				hair_color = sanitize_hexcolor(new_hair)

		if("hairstyle")
			if(slotlocked)
				return

			if(clan.no_hair)
				hairstyle = "Bald"
			else
				var/new_hairstyle
				new_hairstyle = tgui_input_list(user, "Choose your character's hairstyle:", "Character Preference", GLOB.hairstyles_list)
				if(new_hairstyle)
					hairstyle = new_hairstyle

		if("next_hairstyle")
			if(slotlocked)
				return

			if(clan.no_hair)
				hairstyle = "Bald"
			else
				hairstyle = next_list_item(hairstyle, GLOB.hairstyles_list)

		if("previous_hairstyle")
			if(slotlocked)
				return

			if(clan.no_hair)
				hairstyle = "Bald"
			else
				hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_list)

		if("facial")
			if(slotlocked)
				return

			var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference","#"+facial_hair_color) as color|null
			if(new_facial)
				facial_hair_color = sanitize_hexcolor(new_facial)

		if("facial_hairstyle")
			if(slotlocked)
				return

			if(clan.no_facial)
				facial_hairstyle = "Shaved"
			else
				var/new_facial_hairstyle
				new_facial_hairstyle = tgui_input_list(user, "Choose your character's facial-hairstyle:", "Character Preference", GLOB.facial_hairstyles_list)
				if(new_facial_hairstyle)
					facial_hairstyle = new_facial_hairstyle

		if("next_facehairstyle")
			if(slotlocked)
				return

			if(clan.no_facial)
				facial_hairstyle = "Shaved"
			else
				facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

		if("previous_facehairstyle")
			if(slotlocked)
				return

			if(clan.no_facial)
				facial_hairstyle = "Shaved"
			else
				facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

		if("underwear")
			var/new_underwear
			new_underwear = tgui_input_list(user, "Choose your character's underwear:", "Character Preference", GLOB.underwear_list)
			if(new_underwear)
				underwear = new_underwear

		if("underwear_color")
			var/new_underwear_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+underwear_color) as color|null
			if(new_underwear_color)
				underwear_color = sanitize_hexcolor(new_underwear_color)

		if("undershirt")
			var/new_undershirt
			new_undershirt = tgui_input_list(user, "Choose your character's undershirt:", "Character Preference", GLOB.undershirt_list)

			if(new_undershirt)
				undershirt = new_undershirt

		if("socks")
			var/new_socks
			new_socks = tgui_input_list(user, "Choose your character's socks:", "Character Preference", GLOB.socks_list)
			if(new_socks)
				socks = new_socks

		if("eyes")
			if(slotlocked)
				return

			var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference","#"+eye_color) as color|null
			if(new_eyes)
				eye_color = sanitize_hexcolor(new_eyes)

		if("newdiscipline")
			if((true_experience < 10) || !(pref_species.id == "kindred") || !(clan.name == "Caitiff"))
				return

			var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types - /datum/discipline/bloodheal
			for (var/discipline_type in possible_new_disciplines)
				var/datum/discipline/discipline = new discipline_type
				if (discipline.clan_restricted)
					possible_new_disciplines -= discipline_type
				qdel(discipline)
			var/new_discipline = tgui_input_list(user, "Select your new Discipline", "Discipline Selection", sortList(possible_new_disciplines))
			if(new_discipline)
				discipline_types += new_discipline
				discipline_levels += 1
				true_experience -= 10

		if("newghouldiscipline")
			if((true_experience < 10) || !(pref_species.id == "ghoul"))
				return

			var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types - /datum/discipline/bloodheal
			var/new_discipline = tgui_input_list(user, "Select your new Discipline", "Discipline Selection", sortList(possible_new_disciplines))
			if(new_discipline)
				discipline_types += new_discipline
				discipline_levels += 1
				true_experience -= 10

		if("newchidiscipline")
			if((true_experience < 10) || !(pref_species.id == "kuei-jin"))
				return

			var/list/possible_new_disciplines = subtypesof(/datum/chi_discipline) - discipline_types
			var/has_chi_one = FALSE
			var/has_demon_one = FALSE
			var/how_much_usual = 0
			for(var/i in discipline_types)
				if(i)
					var/datum/chi_discipline/C = i
					if(initial(C.discipline_type) == "Shintai")
						how_much_usual += 1
					if(initial(C.discipline_type) == "Demon")
						has_demon_one = TRUE
					if(initial(C.discipline_type) == "Chi")
						has_chi_one = TRUE
			for(var/i in possible_new_disciplines)
				if(i)
					var/datum/chi_discipline/C = i
					if(initial(C.discipline_type) == "Shintai")
						if(how_much_usual >= 3)
							possible_new_disciplines -= i
					if(initial(C.discipline_type) == "Demon")
						if(has_demon_one)
							possible_new_disciplines -= i
					if(initial(C.discipline_type) == "Chi")
						if(has_chi_one)
							possible_new_disciplines -= i
			var/new_discipline = tgui_input_list(user, "Select your new Discipline", "Discipline Selection", sortList(possible_new_disciplines))
			if(new_discipline)
				discipline_types += new_discipline
				discipline_levels += 1
				true_experience -= 10

		if("werewolf_color")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			var/list/colors = list("black", "gray", "red", "white", "ginger", "brown")
			var/result = tgui_input_list(user, "Select fur color:", "Appearance Selection", sortList(colors))
			if(result)
				werewolf_color = result

		if("werewolf_scar")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			if(tribe == "Glasswalkers")
				if(werewolf_scar == 9)
					werewolf_scar = 0
				else
					werewolf_scar = min(9, werewolf_scar+1)
			else
				if(werewolf_scar == 7)
					werewolf_scar = 0
				else
					werewolf_scar = min(7, werewolf_scar+1)

		if("werewolf_hair")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			if(werewolf_hair == 4)
				werewolf_hair = 0
			else
				werewolf_hair = min(4, werewolf_hair+1)

		if("werewolf_hair_color")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			var/new_hair = input(user, "Select hair color:", "Appearance Selection",werewolf_hair_color) as color|null
			if(new_hair)
				werewolf_hair_color = sanitize_ooccolor(new_hair)

		if("werewolf_eye_color")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			var/new_eye = input(user, "Select eye color:", "Appearance Selection",werewolf_eye_color) as color|null
			if(new_eye)
				werewolf_eye_color = sanitize_ooccolor(new_eye)

		if("auspice")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			var/list/auspice_choices = list()
			for(var/i in GLOB.auspices_list)
				var/a = GLOB.auspices_list[i]
				var/datum/auspice/V = new a
				auspice_choices[V.name] += GLOB.auspices_list[i]
				qdel(V)
			var/result = tgui_input_list(user, "Select an Auspice", "Auspice Selection", auspice_choices)
			if(result)
				var/newtype = GLOB.auspices_list[result]
				var/datum/auspice/Auspic = new newtype()
				auspice = Auspic

		if("clan_acc")
			if(pref_species.id != "kindred")	//Due to a lot of people being locked to furries
				return

			if(!length(clan.accessories))
				clan_accessory = null
				return
			var/result = tgui_input_list(user, "Select a mark", "Marks", clan.accessories)
			if(result)
				clan_accessory = result

		if("clan")
			if(slotlocked || !(pref_species.id == "kindred"))
				return

			if (tgui_alert(user, "Are you sure you want to change your Clan? This will reset your Disciplines.", "Confirmation", list("Yes", "No")) != "Yes")
				return

			// Create a list of Clans that can be played by anyone or this user has a whitelist for
			var/list/available_clans = list()
			for (var/adding_clan in GLOB.vampire_clans)
				var/datum/vampire_clan/checking_clan = GLOB.vampire_clans[adding_clan]
				if (checking_clan.whitelisted && !SSwhitelists.is_whitelisted(user.ckey, checking_clan.name))
					continue
				available_clans += checking_clan

			var/result = tgui_input_list(user, "Select a Clan", "Clan Selection", sortList(available_clans))
			if (!result)
				return
			clan = result

			discipline_types = list()
			discipline_levels = list()

			if (result == GLOB.vampire_clans[/datum/vampire_clan/caitiff])
				generation = 13
				for (var/i in 1 to 3)
					if (slotlocked)
						break

					var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types - /datum/discipline/bloodheal
					for (var/discipline_type in possible_new_disciplines)
						var/datum/discipline/discipline = new discipline_type
						if (discipline.clan_restricted)
							possible_new_disciplines -= discipline_type
						qdel(discipline)
					var/new_discipline = tgui_input_list(user, "Select a Discipline", "Discipline Selection", sortList(possible_new_disciplines))
					if (new_discipline)
						discipline_types += new_discipline
						discipline_levels += 1

			for (var/i in 1 to length(clan.clan_disciplines))
				discipline_types += clan.clan_disciplines[i]
				discipline_levels += 1

			humanity = clan.start_humanity
			enlightenment = clan.enlightenment

			if(clan.no_hair)
				hairstyle = "Bald"
			if(clan.no_facial)
				facial_hairstyle = "Shaved"
			if(length(clan.accessories))
				if("none" in clan.accessories)
					clan_accessory = null
				else
					clan_accessory = pick(clan.accessories)

		if("auspice_level")
			var/cost = max(10, auspice_level * 10)
			if ((true_experience < cost) || (auspice_level >= 3))
				return

			true_experience -= cost
			auspice_level = max(1, auspice_level + 1)

		if("physique")
			if(handle_upgrade(physique, physique * 4))
				physique++

		if("dexterity")
			if(handle_upgrade(dexterity, dexterity * 4))
				dexterity++

		if("social")
			if(handle_upgrade(social, social * 4))
				social++

		if("mentality")
			if(handle_upgrade(mentality, mentality * 4))
				mentality++

		if("blood")
			if(handle_upgrade(blood, blood * 6))
				blood++

		if("lockpicking")
			if(handle_upgrade(lockpicking, lockpicking ? lockpicking*2 : 3))
				lockpicking++

		if("athletics")
			if(handle_upgrade(athletics, athletics ? athletics*2 : 3))
				athletics++

		if("tribe")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			var/new_tribe = tgui_input_list(user, "Choose your Tribe:", "Tribe", sortList(list("Wendigo", "Glasswalkers", "Black Spiral Dancers")))
			if (new_tribe)
				tribe = new_tribe

		if("breed")
			if(slotlocked || !(pref_species.id == "garou"))
				return

			var/new_breed = tgui_input_list(user, "Choose your Breed:", "Breed", sortList(list("Homid", "Metis", "Lupus")))
			if (new_breed)
				breed = new_breed

		if("archetype")
			if(slotlocked)
				return

			if (tgui_alert(user, "Are you sure you want to change Archetype? This will reset your attributes.", "Confirmation", list("Yes", "No")) != "Yes")
				return

			var/list/archetypes = list()
			for(var/i in subtypesof(/datum/archetype))
				var/datum/archetype/the_archetype = i
				archetypes[initial(the_archetype.name)] = i
			var/result = tgui_input_list(user, "Select an archetype", "Attributes Selection", sortList(archetypes))
			if(result)
				archetype = archetypes[result]
				var/datum/archetype/archetip = new archetype()
				physique = archetip.start_physique
				dexterity = archetip.start_dexterity
				mentality = archetip.start_mentality
				social = archetip.start_social
				blood = archetip.start_blood
				lockpicking = archetip.start_lockpicking
				athletics = archetip.start_athletics

		if("discipline")
			if(pref_species.id == "kindred")
				var/i = text2num(href_list["upgradediscipline"])

				var/discipline_level = discipline_levels[i]
				var/cost = discipline_level * 7
				if (discipline_level <= 0)
					cost = 10
				else if (clan.name == "Caitiff")
					cost = discipline_level * 6
				else if (clan.clan_disciplines.Find(discipline_types[i]))
					cost = discipline_level * 5

				if ((true_experience < cost) || (discipline_level >= 5))
					return

				true_experience -= cost
				discipline_levels[i] = min(5, max(1, discipline_levels[i] + 1))

			if(pref_species.id == "kuei-jin")
				var/a = text2num(href_list["upgradechidiscipline"])

				var/discipline_level = discipline_levels[a]
				var/cost = discipline_level * 6
				if (discipline_level <= 0)
					cost = 10

				if ((true_experience < cost) || (discipline_level >= 5))
					return

				true_experience -= cost
				discipline_levels[a] = min(5, max(1, discipline_levels[a] + 1))

		if("path")
			var/cost = max(2, humanity * 2)
			if ((true_experience < cost) || (humanity >= 10) || !(pref_species.id == "kindred"))
				return

			true_experience -= cost
			humanity = max(1, humanity + 1)

		if("pathof")
			if (slotlocked || !(pref_species.id == "kindred"))
				return

			enlightenment = !enlightenment

		if("dharmarise")
			if ((true_experience < min((dharma_level * 5), 20)) || (dharma_level >= 6) || !(pref_species.id == "kuei-jin"))
				return

			true_experience -= min((dharma_level * 5), 20)
			dharma_level = clamp(dharma_level + 1, 1, 6)

			if (dharma_level >= 6)
				hun += 1
				po += 1
				yin += 1
				yang += 1

		/*
		if("torpor_restore")
			if(torpor_count != 0 && true_experience >= 3*(14-generation))
				torpor_count = 0
				true_experience = true_experience-(3*(14-generation))
		*/


		if("dharmatype")
			if(slotlocked)
				return
			if (tgui_alert(user, "Are you sure you want to change Dharma? This will reset path-specific stats.", "Confirmation", list("Yes", "No")) != "Yes")
				return
			var/list/dharmas = list()
			for(var/i in subtypesof(/datum/dharma))
				var/datum/dharma/dharma = i
				dharmas += initial(dharma.name)
			var/result = tgui_input_list(user, "Select Dharma", "Dharma", sortList(dharmas))
			if(result)
				for(var/i in subtypesof(/datum/dharma))
					var/datum/dharma/dharma = i
					if(initial(dharma.name) == result)
						dharma_type = i
						dharma_level = initial(dharma_level)
						hun = initial(hun)
						po = initial(po)
						yin = initial(yin)
						yang = initial(yang)

		if("potype")
			if(slotlocked)
				return
			var/list/pos = list("Rebel", "Legalist", "Demon", "Monkey", "Fool")
			var/result = tgui_input_list(user, "Select P'o", "P'o", sortList(pos))
			if(result)
				po_type = result

		if("chibalance")
			var/max_limit = max(10, dharma_level * 2)
			var/sett = tgui_input_number(user, "Enter the maximum of Yin your character has:", "Yin/Yang")
			if(sett)
				sett = max(1, min(sett, max_limit-1))
				yin = sett
				yang = max_limit-sett

		if("demonbalance")
			var/max_limit = max(10, dharma_level * 2)
			var/sett = tgui_input_number(user, "Enter the maximum of Hun your character has:", "Hun/P'o")
			if(sett)
				sett = max(1, min(sett, max_limit-1))
				hun = sett
				po = max_limit-sett

		if("generation")
			if((clan?.name == "Caitiff") || (true_experience < 20))
				return

			true_experience -= 20
			generation_bonus = min(generation_bonus + 1, max(0, generation-7))

		if("friend_text")
			var/new_text = tgui_input_text(user, "What a Friend knows about me:", "Character Preference", max_length = 512)
			if(new_text)
				friend_text = new_text
		if("enemy_text")
			var/new_text = tgui_input_text(user, "What an Enemy knows about me:", "Character Preference", max_length = 512)
			if(new_text)
				enemy_text = new_text
		if("lover_text")
			var/new_text = tgui_input_text(user, "What a Lover knows about me:", "Character Preference", max_length = 512)
			if(new_text)
				lover_text = new_text
		if("ooc_notes")
			var/new_ooc_notes = tgui_input_text(user, "Choose your character's OOC notes:", "Character Preference", ooc_notes, MAX_MESSAGE_LEN, multiline = TRUE)
			if(!length(new_ooc_notes))
				return
			ooc_notes = new_ooc_notes

		if("flavor_text")
			var/new_flavor = tgui_input_text(user, "Choose your character's flavor text:", "Character Preference", flavor_text, MAX_FLAVOR_LEN, multiline = TRUE)
			if(!length(new_flavor))
				return
			flavor_text = new_flavor

		if("view_flavortext")
			var/datum/browser/popup = new(user, "[real_name]_flavortext", real_name, 500, 200)
			popup.set_content(replacetext(flavor_text, "\n", "<BR>"))
			popup.open(FALSE)
			return

		if("headshot")
			to_chat(user, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Lastly, ["<b>do not use a real life photo or use any image that is less than serious.</b>"]"))
			to_chat(user, span_notice("If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser."))
			to_chat(user, span_notice("Resolution: 250x250 pixels."))
			var/new_headshot_link = tgui_input_text(user, "Input the headshot link (https, hosts: gyazo, discord, lensdump, imgbox, catbox):", "Headshot", headshot_link, encode = FALSE)
			if(isnull(new_headshot_link))
				return
			if(!length(new_headshot_link))
				headshot_link = null
				ShowChoices(user)
				return
			if(!valid_headshot_link(user, new_headshot_link))
				headshot_link = null
				ShowChoices(user)
				return
			headshot_link = new_headshot_link
			to_chat(user, span_notice("Successfully updated headshot picture!"))
			log_game("[user] has set their Headshot image to '[headshot_link]'.")

		if("view_headshot")
			var/list/dat = list("<table width='100%' height='100%'><td align='center' valign='middle'><img src='[headshot_link]' width='250px' height='250px'></td></table>")
			var/datum/browser/popup = new(user, "[real_name]'s Headshot", "<div align='center'>Headshot</div>", 310, 330)
			popup.set_content(dat.Join())
			popup.open(FALSE)
			return

		if("change_appearance")
			if(!slotlocked)
				return

			slotlocked = FALSE

		if("reset_with_bonus")
			if((clan?.name == "Caitiff") || !generation_bonus)
				return

			var/bonus = generation-generation_bonus
			slotlocked = FALSE
			torpor_count = 0
			masquerade = initial(masquerade)
			generation = bonus
			generation_bonus = 0
			save_character()

		if("species")
			if(slotlocked)
				return

			if (tgui_alert(user, "Are you sure you want to change species? This will reset species-specific stats.", "Confirmation", list("Yes", "No")) != "Yes")
				return

			var/list/choose_species = list()
			for (var/key in GLOB.selectable_races)
				var/newtype = GLOB.species_list[key]
				var/datum/species/selecting_species = new newtype
				if (!selecting_species.selectable)
					qdel(selecting_species)
					continue
				if (selecting_species.whitelisted)
					if (parent && !SSwhitelists.is_whitelisted(parent.ckey, key))
						qdel(selecting_species)
						continue
				choose_species += key
				qdel(selecting_species)

			var/result = tgui_input_list(user, "Select a species", "Species Selection", sortList(choose_species))
			if(result)
				all_quirks.Cut()
				var/newtype = GLOB.species_list[result]
				pref_species = new newtype()
				switch(pref_species.id)
					if("ghoul","human","kuei-jin")
						discipline_types.Cut()
						discipline_levels.Cut()
					if("kindred")
						clan = GLOB.vampire_clans[/datum/vampire_clan/brujah]
						discipline_types.Cut()
						discipline_levels.Cut()
						for (var/i in 1 to length(clan.clan_disciplines))
							discipline_types += clan.clan_disciplines[i]
							discipline_levels += 1
				//Now that we changed our species, we must verify that the mutant colour is still allowed.
				var/temp_hsv = RGBtoHSV(features["mcolor"])
				if(features["mcolor"] == "#000" || (!(MUTCOLORS_PARTSONLY in pref_species.species_traits) && ReadHSV(temp_hsv)[3] < ReadHSV("#7F7F7F")[3]))
					features["mcolor"] = pref_species.default_color
				if(randomise[RANDOM_NAME])
					real_name = pref_species.random_name(gender)

		if("mutant_color")
			if(slotlocked)
				return

			var/new_mutantcolor = input(user, "Choose your character's alien/mutant color:", "Character Preference","#"+features["mcolor"]) as color|null
			if(new_mutantcolor)
				var/temp_hsv = RGBtoHSV(new_mutantcolor)
				if(new_mutantcolor == "#000000")
					features["mcolor"] = pref_species.default_color
				else if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV("#7F7F7F")[3]) // mutantcolors must be bright, but only if they affect the skin
					features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
				else
					to_chat(user, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")

		if("color_ethereal")
			var/new_etherealcolor = input(user, "Choose your ethereal color", "Character Preference") as null|anything in GLOB.color_list_ethereal
			if(new_etherealcolor)
				features["ethcolor"] = GLOB.color_list_ethereal[new_etherealcolor]


		if("tail_lizard")
			var/new_tail
			new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_lizard
			if(new_tail)
				features["tail_lizard"] = new_tail

		if("tail_human")
			var/new_tail
			new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_human
			if(new_tail)
				features["tail_human"] = new_tail

		if("snout")
			var/new_snout
			new_snout = input(user, "Choose your character's snout:", "Character Preference") as null|anything in GLOB.snouts_list
			if(new_snout)
				features["snout"] = new_snout

		if("horns")
			var/new_horns
			new_horns = input(user, "Choose your character's horns:", "Character Preference") as null|anything in GLOB.horns_list
			if(new_horns)
				features["horns"] = new_horns

		if("ears")
			var/new_ears
			new_ears = input(user, "Choose your character's ears:", "Character Preference") as null|anything in GLOB.ears_list
			if(new_ears)
				features["ears"] = new_ears

		if("wings")
			var/new_wings
			new_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.r_wings_list
			if(new_wings)
				features["wings"] = new_wings

		if("frills")
			var/new_frills
			new_frills = input(user, "Choose your character's frills:", "Character Preference") as null|anything in GLOB.frills_list
			if(new_frills)
				features["frills"] = new_frills

		if("spines")
			var/new_spines
			new_spines = input(user, "Choose your character's spines:", "Character Preference") as null|anything in GLOB.spines_list
			if(new_spines)
				features["spines"] = new_spines

		if("body_markings")
			var/new_body_markings
			new_body_markings = input(user, "Choose your character's body markings:", "Character Preference") as null|anything in GLOB.body_markings_list
			if(new_body_markings)
				features["body_markings"] = new_body_markings

		if("legs")
			var/new_legs
			new_legs = input(user, "Choose your character's legs:", "Character Preference") as null|anything in GLOB.legs_list
			if(new_legs)
				features["legs"] = new_legs

		if("moth_wings")
			var/new_moth_wings
			new_moth_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.moth_wings_list
			if(new_moth_wings)
				features["moth_wings"] = new_moth_wings

		if("moth_antennae")
			var/new_moth_antennae
			new_moth_antennae = input(user, "Choose your character's antennae:", "Character Preference") as null|anything in GLOB.moth_antennae_list
			if(new_moth_antennae)
				features["moth_antennae"] = new_moth_antennae

		if("moth_markings")
			var/new_moth_markings
			new_moth_markings = input(user, "Choose your character's markings:", "Character Preference") as null|anything in GLOB.moth_markings_list
			if(new_moth_markings)
				features["moth_markings"] = new_moth_markings

		if("s_tone")
			if(slotlocked)
				return

			var/new_s_tone = input(user, "Choose your character's skin-tone:", "Character Preference","#"+skin_tone) as color|null
			if(new_s_tone)
				skin_tone = sanitize_hexcolor(new_s_tone)

		if("s_tone_preset")
			if(slotlocked)
				return
			var/s_tone_choice = input(user, "Choose your character's skin-tone:", "Character Preference")  as null|anything in skin_tone_presets
			var/new_s_tone_preset = skin_tone_presets[s_tone_choice]
			if(s_tone_choice)
				skin_tone = sanitize_hexcolor(new_s_tone_preset)

		if("ooccolor")
			var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference",ooccolor) as color|null
			if(new_ooccolor)
				ooccolor = sanitize_ooccolor(new_ooccolor)

		if("asaycolor")
			var/new_asaycolor = input(user, "Choose your ASAY color:", "Game Preference",asaycolor) as color|null
			if(new_asaycolor)
				asaycolor = sanitize_ooccolor(new_asaycolor)

		if("bag")
			var/new_backpack = tgui_input_list(user, "Choose your character's style of bag:", "Character Preference", GLOB.backpacklist)
			if(new_backpack)
				backpack = new_backpack

		if("suit")
			if(jumpsuit_style == PREF_SUIT)
				jumpsuit_style = PREF_SKIRT
			else
				jumpsuit_style = PREF_SUIT

		if("uplink_loc")
			var/new_loc = input(user, "Choose your character's traitor uplink spawn location:", "Character Preference") as null|anything in GLOB.uplink_spawn_loc_list
			if(new_loc)
				uplink_spawn_loc = new_loc

		if("playtime_reward_cloak")
			if (user.client.get_exp_living(TRUE) >= PLAYTIME_VETERAN)
				playtime_reward_cloak = !playtime_reward_cloak

		if("ai_core_icon")
			var/ai_core_icon = input(user, "Choose your preferred AI core display screen:", "AI Core Display Screen Selection") as null|anything in GLOB.ai_core_display_screens - "Portrait"
			if(ai_core_icon)
				preferred_ai_core_display = ai_core_icon

		if("sec_dept")
			var/department = input(user, "Choose your preferred security department:", "Security Departments") as null|anything in GLOB.security_depts_prefs
			if(department)
				prefered_security_department = department

		if ("preferred_map")
			var/maplist = list()
			var/default = "Default"
			if (config.defaultmap)
				default += " ([config.defaultmap.map_name])"
			for (var/M in config.maplist)
				var/datum/map_config/VM = config.maplist[M]
				if(!VM.votable)
					continue
				var/friendlyname = "[VM.map_name] "
				if (VM.voteweight <= 0)
					friendlyname += " (disabled)"
				maplist[friendlyname] = VM.map_name
			maplist[default] = null
			var/pickedmap = input(user, "Choose your preferred map. This will be used to help weight random map selection.", "Character Preference")  as null|anything in sortList(maplist)
			if (pickedmap)
				preferred_map = maplist[pickedmap]

		if ("clientfps")
			var/desiredfps = input(user, "Choose your desired fps.\n-1 means recommended value (currently:[RECOMMENDED_FPS])\n0 means world fps (currently:[world.fps])", "Character Preference", clientfps)  as null|num
			if (!isnull(desiredfps))
				clientfps = sanitize_integer(desiredfps, -1, 1000, clientfps)
				if(parent)
					parent.fps = (clientfps < 0) ? RECOMMENDED_FPS : clientfps
		if("ui")
			var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
			if(pickedui)
				UI_style = pickedui
				if (parent?.mob.hud_used)
					parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
		if("pda_style")
			var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
			if(pickedPDAStyle)
				pda_style = pickedPDAStyle
		if("pda_color")
			var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference", pda_color) as color|null
			if(pickedPDAColor)
				pda_color = pickedPDAColor

		if("phobia")
			var/phobiaType = input(user, "What are you scared of?", "Character Preference", phobia) as null|anything in SStraumas.phobia_types
			if(phobiaType)
				phobia = phobiaType

		if ("max_chat_length")
			var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
			if (!isnull(desiredlength))
				max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)

	return TRUE
