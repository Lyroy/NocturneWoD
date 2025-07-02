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
			dat += "<h2>[make_font_cool("DISCIPLINES (WORK IN PROGRESS)")]</h2>"


		if("Ghoul")
			dat += "<b>Masquerade:</b> [masquerade]/5<br>"

			// disciplines
			dat += "<h2>[make_font_cool("DISCIPLINES (WORK IN PROGRESS)")]</h2>"

		if("Kuei-Jin")
			// dharma
			var/datum/dharma/D = new dharma_type()
			dat += "<b>Dharma:</b> "
			dat += make_lockable_button(D.name, "byond://?_src_=prefs;preference=dharmatype;task=input", slotlocked, FALSE)
			dat += " [dharma_level]/6<br>"
			dat += "[D.desc]<br>"
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
			dat += "<h2>[make_font_cool("DISCIPLINES (WORK IN PROGRESS)")]</h2>"

		if("Werewolf")
			dat += "<b>Veil:</b> [masquerade]/5<br>"

			// disciplines
			dat += "<h2>[make_font_cool("TRIBE (WORK IN PROGRESS)")]</h2>"

	dat += "</td></tr></table>"

	// REMOVE THIS WHEN THE MENU IS ACTUALLY FUCKING FINISHED
	dat += "<center><h2>[make_font_cool("WORK IN PROGRESS")]</h2></center>"
