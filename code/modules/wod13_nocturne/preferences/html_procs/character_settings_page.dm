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

			dat += make_lockable_button( \
				"Increase [enlightenment ? "Enlightenment" : "Humanity"] ([humanity * 2])", \
				"byond://?_src_=prefs;preference=path;task=input", \
				(true_experience >= (humanity * 2)) && (humanity < 10))

			if(!slotlocked)
				dat += "<a href='byond://?_src_=prefs;preference=pathof;task=input'>Switch Path</a><br>"

			// generation bonus
			var/generation_allowed = TRUE
			if(clan?.name == "Caitiff")
				generation_allowed = FALSE

			if(generation_allowed)
				if(generation_bonus)
					dat += "<b>Generation Bonus:</b> [generation_bonus]/[min(6, generation-7)]"

				if(true_experience >= 20 && generation_bonus < max(0, generation-7))
					dat += "<a href='byond://?_src_=prefs;preference=generation;task=input'>Claim Generation Bonus (20)</a><br>"
			else
				dat += "<br>"

		/*
		if("Kuei-Jin")
			var/datum/dharma/D = new dharma_type()
			dat += "<b>Dharma:</b> [D.name] [dharma_level]/6 <a href='byond://?_src_=prefs;preference=dharmatype;task=input'>Switch</a><BR>"
			dat += "[D.desc]<BR>"
			if(true_experience >= min((dharma_level * 5), 20) && (dharma_level < 6))
				var/dharma_cost = min((dharma_level * 5), 20)
				dat += " <a href='byond://?_src_=prefs;preference=dharmarise;task=input'>Raise Dharmic Enlightenment ([dharma_cost])</a><BR>"
			dat += "<b>P'o Personality</b>: [po_type] <a href='byond://?_src_=prefs;preference=potype;task=input'>Switch</a><BR>"
			dat += "<b>Awareness:</b> [masquerade]/5<BR>"
			dat += "<b>Yin/Yang</b>: [yin]/[yang] <a href='byond://?_src_=prefs;preference=chibalance;task=input'>Adjust</a><BR>"
			dat += "<b>Hun/P'o</b>: [hun]/[po] <a href='byond://?_src_=prefs;preference=demonbalance;task=input'>Adjust</a><BR>"
		if("Werewolf")
			dat += "<b>Veil:</b> [masquerade]/5<BR>"
		if("Ghoul")
			dat += "<b>Masquerade:</b> [masquerade]/5<BR>"
		*/
	dat += "</td></tr></table>"
