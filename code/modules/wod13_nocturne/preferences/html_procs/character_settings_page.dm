/datum/preferences/proc/character_settings_page(mob/user, list/dat)
	if(reason_of_death != "None")
		dat += "<center><b>Last death</b>: [reason_of_death]</center>"
	dat += "<table width='100%'><tr><td width='50%' valign='top'>"
	dat += "<h2>[make_font_cool("IDENTITY")]</h2>"

	if(is_banned_from(user.ckey, "Appearance"))
		dat += "<b>You are banned from using custom names and appearances. You can continue to adjust your characters, but you will be randomised once you join the game.</b><br>"

	// name
	dat += make_lockable_button("Random Name", "byond://?_src_=prefs;preference=name;task=random", slotlocked)
	// dat += "<a href='byond://?_src_=prefs;preference=name;task=random'>Random Name</A> "
	dat += "<b>Name:</b> "
	dat += make_lockable_button(real_name, "byond://?_src_=prefs;preference=name;task=input", slotlocked)
	// dat += "<a href='byond://?_src_=prefs;preference=name;task=input'>[real_name]</a><BR>"

	// gender
	if(!(AGENDER in pref_species.species_traits))
		dat += "<b>Gender:</b> "
		dat += make_lockable_button(gender == MALE ? "Male" : gender == FEMALE ? "Female" : "Other", "byond://?_src_=prefs;preference=gender", slotlocked)

	// body type
	dat += "<b>Body Type:</b> "
	dat += make_lockable_button(body_type == MALE ? "Masculine" : body_type == FEMALE ? "Feminine" : "Other", "byond://?_src_=prefs;preference=body_type", slotlocked)

	// age
	if(pref_species.name != "Human")
		dat += "<b>Biological Age:</b> "
		dat += make_lockable_button(age, "byond://?_src_=prefs;preference=age;task=input", slotlocked)
		dat += "<b>Actual Age:</b> "
		dat += make_lockable_button(total_age, "byond://?_src_=prefs;preference=total_age;task=input", slotlocked)
	else
		dat += "<b>Age:</b> "
		dat += make_lockable_button(age, "byond://?_src_=prefs;preference=age;task=input", slotlocked)

	// body randomization
	dat += make_lockable_button("Random Body", "byond://?_src_=prefs;preference=all;task=random", slotlocked, TRUE)


	dat += "</td><td width='50%' valign='top'>"
	dat += "<h2>[make_font_cool("SPLAT")]</h2>"

	// species
	dat += "<b>Splat:</b> "
	dat += make_lockable_button(pref_species.name, "byond://?_src_=prefs;preference=species;task=input", slotlocked)

	// species stats
	switch(pref_species.name)
		if("Vampire")
			dat += "<b>Masquerade:</b> [masquerade]/5<br>"
			dat += "<b>Generation:</b> [generation]<br>"
			dat += "<b>Path of [enlightenment ? "Enlightenment" : "Humanity"]:</b> [humanity]/10<br>"

			/*
			// if(SSwhitelists.is_whitelisted(parent.ckey, "enlightenment") && !slotlocked)
			if ((true_experience >= (humanity * 2)) && (humanity < 10))
				dat += "<a href='byond://?_src_=prefs;preference=path;task=input'>Increase [enlightenment ? "Enlightenment" : "Humanity"] ([humanity * 2])</a>"
			*/

			if(humanity < 10)
				dat += make_lockable_button( \
					"Increase [enlightenment ? "Enlightenment" : "Humanity"] ([humanity * 2])", \
					"byond://?_src_=prefs;preference=path;task=input", \
					true_experience >= (humanity * 2))

			if(!slotlocked)
				dat += "<a href='byond://?_src_=prefs;preference=pathof;task=input'>Switch Path</a><br>"

			// generation bonus
			var/generation_allowed = TRUE
			if(clan?.name == "Caitiff")
				generation_allowed = FALSE

			if(generation_allowed)
				if(generation_bonus)
					dat += "<b>Generation Bonus:</b> [generation_bonus]/[min(6, generation-7)]<br>"

				if(generation_bonus < max(6, generation-7))
					dat += make_lockable_button( \
						"Claim Generation Bonus (20)", \
						"byond://?_src_=prefs;preference=generation;task=input", \
						true_experience >= 20)

			// clans
			dat += "<h2>[make_font_cool("CLAN")]</h2>"

			dat += "<b>Clan/Bloodline:</b> "
			dat += make_lockable_button(clan.name, "byond://?_src_=prefs;preference=clan;task=input", slotlocked)
			dat += "<b>Description:</b> [clan.desc]<br>"
			dat += "<b>Curse:</b> [clan.curse]<br>"

			// clan accessories
			if (length(clan.accessories))
				dat += "<b>Marks:</b> <a href='byond://?_src_=prefs;preference=clan_acc;task=input'>[clan_accessory ? clan_accessory : "none"]</a><br>"

			// disciplines
			dat += "<h2>[make_font_cool("DISCIPLINES")]</h2>"

			for (var/i in 1 to discipline_types.len)
				var/discipline_type = discipline_types[i]
				var/datum/discipline/discipline = new discipline_type
				var/discipline_level = discipline_levels[i]

				var/cost
				if (discipline_level <= 0)
					cost = 10
				else if (clan.name == "Caitiff")
					cost = discipline_level * 6
				else if (clan.clan_disciplines.Find(discipline_type))
					cost = discipline_level * 5
				else
					cost = discipline_level * 7

				dat += "<b>[discipline.name]</b>: "
				dat += make_dots(discipline_level, 5, FALSE)

				if(discipline_level < 5)
					dat += make_lockable_button("Learn ([cost])", "byond://?_src_=prefs;preference=upgradediscipline;task=input", true_experience >= cost)
				else
					dat += "<br>"

				dat += "<b>Description:</b> [discipline.desc]<br>"

				qdel(discipline)

			if (clan.name == "Caitiff")
				var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types - /datum/discipline/bloodheal
				for (var/discipline_type in possible_new_disciplines)
					var/datum/discipline/discipline = new discipline_type
					if (discipline.clan_restricted)
						possible_new_disciplines -= discipline_type
					qdel(discipline)
				if (possible_new_disciplines.len)
					dat += make_lockable_button("Learn a new Discipline (10)", "byond://?_src_=prefs;preference=newdiscipline;task=input", true_experience >= 10)

		if("Ghoul")
			dat += "<b>Masquerade:</b> [masquerade]/5<br>"

			// disciplines
			dat += "<h2>[make_font_cool("DISCIPLINES")]</h2>"

			for (var/i in 1 to discipline_types.len)
				var/discipline_type = discipline_types[i]
				var/datum/discipline/discipline = new discipline_type
				dat += "<b>[discipline.name]</b>: •<br>"
				dat += "<b>Description:</b> [discipline.desc]<br>"
				qdel(discipline)

			var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types - /datum/discipline/bloodheal
			if (possible_new_disciplines.len)
				dat += make_lockable_button("Learn a new Discipline (10)", "byond://?_src_=prefs;preference=newghouldiscipline;task=input", true_experience >= 10)

		if("Kuei-Jin")
			// dharma
			var/datum/dharma/D = new dharma_type()
			dat += "<b>Dharma:</b> "
			dat += make_lockable_button(D.name, "byond://?_src_=prefs;preference=dharmatype;task=input", slotlocked, FALSE)
			dat += " [dharma_level]/6<br>"
			dat += "<b>Description:</b> [D.desc]<br>"
			if(dharma_level < 6)
				var/dharma_cost = min((dharma_level * 5), 20)
				make_lockable_button( \
					"Raise Dharmic Enlightenment ([dharma_cost])", \
					"byond://?_src_=prefs;preference=dharmarise;task=input", \
					true_experience >= dharma_cost)

			dat += "<b>P'o Personality</b>: "
			dat += make_lockable_button(po_type, "byond://?_src_=prefs;preference=potype;task=input", slotlocked)

			dat += "<b>Awareness:</b> [masquerade]/5<BR>"

			dat += "<b>Yin/Yang</b>: [yin]/[yang] <a href='byond://?_src_=prefs;preference=chibalance;task=input'>Adjust</a><br>"
			dat += "<b>Hun/P'o</b>: [hun]/[po] <a href='byond://?_src_=prefs;preference=demonbalance;task=input'>Adjust</a><br>"

			// disciplines
			dat += "<h2>[make_font_cool("DISCIPLINES")]</h2>"
			for (var/i in 1 to discipline_types.len)
				var/discipline_type = discipline_types[i]
				var/datum/chi_discipline/discipline = new discipline_type
				var/discipline_level = discipline_levels[i]

				var/cost
				if (discipline_level <= 0)
					cost = 10
				else
					cost = discipline_level * 6

				dat += "<b>[discipline.name]</b> ([discipline.discipline_type]): "
				dat += make_dots(discipline_level, 5, FALSE)
				if(discipline_level < 5)
					dat += make_lockable_button("Learn ([cost])", "byond://?_src_=prefs;preference=discipline;task=input;upgradechidiscipline=[i]", true_experience >= cost)
				else
					dat += "<br>"

				dat += "<b>Description:</b> [discipline.desc]<br>"
				dat += "<b>Yin:</b> [discipline.cost_yin]<br>"
				dat += "<b>Yang:</b> [discipline.cost_yang]<br>"
				dat += "<b>Demon:</b> [discipline.cost_demon]<br>"

				qdel(discipline)

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

			if (possible_new_disciplines.len)
				dat += make_lockable_button("Learn a new Discipline (10)", "byond://?_src_=prefs;preference=newghouldiscipline;task=input", true_experience >= 10)

		if("Werewolf")
			dat += "<b>Veil:</b> [masquerade]/5<br>"

			// auspice
			dat += "<h2>[make_font_cool("AUSPICE")]</h2>"

			dat += "<b>Auspice:</b> "
			dat += make_lockable_button(auspice.name, "byond://?_src_=prefs;preference=auspice;task=input", slotlocked)
			dat += "<b>Description:</b> [auspice.desc]<br>"

			// auspice level
			dat += "<b>Power:</b> "
			dat += make_dots(auspice_level, 4)

			if(true_experience >= 10*auspice_level && auspice_level < 4)
				dat += make_lockable_button("Increase Power ([10 * auspice_level])", "byond://?_src_=prefs;preference=auspice_level;task=input", true_experience >= 10 * auspice_level)

			dat += "<b>Initial Rage:</b> "
			dat += make_dots(auspice.start_rage, 5)

			// tribe/breed
			dat += "<h2>[make_font_cool("TRIBE")]</h2>"

			dat += "<b>Tribe:</b> "
			dat += make_lockable_button(tribe, "byond://?_src_=prefs;preference=tribe;task=input", slotlocked)

			// gifts
			var/gifts_text = ""
			var/num_of_gifts = 0
			for(var/i in 1 to auspice_level)
				var/zalupa
				switch (tribe)
					if ("Glasswalkers")
						zalupa = auspice.glasswalker[i]
					if ("Wendigo")
						zalupa = auspice.wendigo[i]
					if ("Black Spiral Dancers")
						zalupa = auspice.spiral[i]
				var/datum/action/T = new zalupa()
				gifts_text += "[T.name], "
			for(var/i in auspice.gifts)
				var/datum/action/ACT = new i()
				num_of_gifts = min(num_of_gifts+1, length(auspice.gifts))
				if(num_of_gifts != length(auspice.gifts))
					gifts_text += "[ACT.name], "
				else
					gifts_text += "[ACT.name].<BR>"
				qdel(ACT)
			dat += "<b>Initial Gifts:</b> [gifts_text]"

			// werewolf body
			dat += "<h2>[make_font_cool("WOLF FORM")]</h2>"

			// icon preview
			// These mobs should be made in nullspace to avoid dumping them onto the map somewhere.
			var/mob/living/carbon/werewolf/crinos/DAWOF = new
			var/mob/living/carbon/werewolf/lupus/DAWOF2 = new

			DAWOF.sprite_color = werewolf_color
			DAWOF2.sprite_color = werewolf_color

			var/obj/effect/overlay/eyes_crinos = new(DAWOF)
			eyes_crinos.icon = 'code/modules/wod13/werewolf.dmi'
			eyes_crinos.icon_state = "eyes"
			eyes_crinos.layer = ABOVE_HUD_LAYER
			eyes_crinos.color = werewolf_eye_color
			DAWOF.overlays |= eyes_crinos

			var/obj/effect/overlay/scar_crinos = new(DAWOF)
			scar_crinos.icon = 'code/modules/wod13/werewolf.dmi'
			scar_crinos.icon_state = "scar[werewolf_scar]"
			scar_crinos.layer = ABOVE_HUD_LAYER
			DAWOF.overlays |= scar_crinos

			var/obj/effect/overlay/hair_crinos = new(DAWOF)
			hair_crinos.icon = 'code/modules/wod13/werewolf.dmi'
			hair_crinos.icon_state = "hair[werewolf_hair]"
			hair_crinos.layer = ABOVE_HUD_LAYER
			hair_crinos.color = werewolf_hair_color
			DAWOF.overlays |= hair_crinos

			var/obj/effect/overlay/eyes_lupus = new(DAWOF2)
			eyes_lupus.icon = 'code/modules/wod13/werewolf_lupus.dmi'
			eyes_lupus.icon_state = "eyes"
			eyes_lupus.layer = ABOVE_HUD_LAYER
			eyes_lupus.color = werewolf_eye_color
			DAWOF2.overlays |= eyes_lupus

			DAWOF.update_icons()
			DAWOF2.update_icons()
			dat += "[icon2html(getFlatIcon(DAWOF), user)][icon2html(getFlatIcon(DAWOF2), user)]<br>"
			qdel(DAWOF)
			qdel(DAWOF2)

			// the actual options
			dat += "<b>Werewolf Name:</b> "
			dat += make_lockable_button(werewolf_name, "byond://?_src_=prefs;preference=werewolf_name;task=input", slotlocked)

			dat += "<b>Breed:</b> "
			dat += make_lockable_button(breed, "byond://?_src_=prefs;preference=breed;task=input", slotlocked)

			dat += "<b>Color:</b> "
			dat += make_lockable_button(werewolf_color, "byond://?_src_=prefs;preference=werewolf_color;task=input", slotlocked)

			dat += "<b>Eyes:</b> "
			dat += make_lockable_button(werewolf_eye_color, "byond://?_src_=prefs;preference=werewolf_eye_color;task=input", slotlocked)

			dat += "<b>Scars:</b> "
			dat += make_lockable_button(werewolf_scar, "byond://?_src_=prefs;preference=werewolf_scar;task=input", slotlocked)

			dat += "<b>Hair:</b> "
			dat += make_lockable_button(werewolf_hair, "byond://?_src_=prefs;preference=werewolf_hair;task=input", slotlocked)

			dat += "<b>Hair Color:</b> "
			dat += make_lockable_button(werewolf_hair_color, "byond://?_src_=prefs;preference=werewolf_hair_color;task=input", slotlocked)


	dat += "</td></tr></table>"

	// REMOVE THIS WHEN THE MENU IS ACTUALLY FUCKING FINISHED
	dat += "<center><h2>[make_font_cool("WORK IN PROGRESS")]</h2></center>"
