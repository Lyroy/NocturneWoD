/datum/preferences/proc/stat_page(mob/user, list/dat)
	dat += "<table width='100%'><tr><td width='50%' valign='top'>"

	// attributes
	dat += "<h2>[make_font_cool("ATTRIBUTES")]</h2>"

	dat += "<b>Archetype</b> :<BR>"
	var/datum/archetype/A = new archetype()
	dat += "<a href='byond://?_src_=prefs;preference=archetype;task=input'>[A.name]</a> [A.specialization]<BR>"

	//Prices for each ability, can be adjusted, multiplied by current attribute level
	var/physique_price = 4
	var/dexterity_price = 4
	var/social_price = 4
	var/mentality_price = 4
	var/blood_price = 6
	//Lockpicking and Athletics have an initial price of 3
	var/lockpicking_price = !lockpicking ? 3 : 2
	var/athletics_price = !athletics ? 3 : 2

	dat += "<b>Physique:</b> [build_attribute_score(physique, A.archetype_additional_physique, physique_price, "physique")]"
	dat += "<b>Dexterity:</b> [build_attribute_score(dexterity, A.archetype_additional_dexterity, dexterity_price, "dexterity")]"
	dat += "<b>Social:</b> [build_attribute_score(social, A.archetype_additional_social, social_price, "social")]"
	dat += "<b>Mentality:</b> [build_attribute_score(mentality, A.archetype_additional_mentality, mentality_price, "mentality")]"
	dat += "<b>Cruelty:</b> [build_attribute_score(blood, A.archetype_additional_blood, blood_price, "blood")]"
	dat += "<b>Lockpicking:</b> [build_attribute_score(lockpicking, A.archetype_additional_lockpicking, lockpicking_price, "lockpicking")]"
	dat += "<b>Athletics:</b> [build_attribute_score(athletics, A.archetype_additional_athletics, athletics_price, "athletics")]"
	dat += "Experience rewarded: [true_experience]<BR>"
	dat += "</td><td width='50%' valign='top'>"

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
					true_experience < (humanity * 2))

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
						true_experience < 20)

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
					dat += make_lockable_button("Learn ([cost])", "byond://?_src_=prefs;preference=discipline;task=input;upgradediscipline=[i]", true_experience < cost)
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
					dat += make_lockable_button("Learn a new Discipline (10)", "byond://?_src_=prefs;preference=newdiscipline;task=input", true_experience < 10)

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
				dat += make_lockable_button("Learn a new Discipline (10)", "byond://?_src_=prefs;preference=newghouldiscipline;task=input", true_experience < 10)

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
					true_experience < dharma_cost)

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
					dat += make_lockable_button("Learn ([cost])", "byond://?_src_=prefs;preference=discipline;task=input;upgradechidiscipline=[i]", true_experience < cost)
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
				dat += make_lockable_button("Learn a new Discipline (10)", "byond://?_src_=prefs;preference=newghouldiscipline;task=input", true_experience < 10)

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
				dat += make_lockable_button("Increase Power ([10 * auspice_level])", "byond://?_src_=prefs;preference=auspice_level;task=input", true_experience < 10 * auspice_level)

			dat += "<b>Initial Rage:</b> "
			dat += make_dots(auspice.start_rage, 5)

	dat += "</td></tr></table>"
