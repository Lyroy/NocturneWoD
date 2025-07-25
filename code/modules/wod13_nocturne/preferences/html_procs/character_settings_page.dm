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

			// clans
			dat += "<h2>[make_font_cool("CLAN")]</h2>"

			dat += "<b>Clan/Bloodline:</b> "
			dat += make_lockable_button(clan.name, "byond://?_src_=prefs;preference=clan;task=input", slotlocked)
			dat += "<b>Description:</b> [clan.desc]<br>"
			dat += "<b>Curse:</b> [clan.curse]<br>"

			// clan accessories
			if (length(clan.accessories))
				dat += "<b>Marks:</b> <a href='byond://?_src_=prefs;preference=clan_acc;task=input'>[clan_accessory ? clan_accessory : "none"]</a><br>"

			dat += "<h2>[make_font_cool("NOTORIETY")]</h2>"
			dat += "<b>Fame:</b> <a href ='byond://?_src_=prefs;preference=info_choose;task=input'>[info_known]</a>"

		if("Werewolf")

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

	// appearance shit
	dat += "</td></tr></table>"
	dat += "<table width='100%'><tr>"

	var/use_skintones = pref_species.use_skintones
	var/appearance_column_skin = FALSE

	if(use_skintones)

		dat += "<td valign='top' width='25%'>"
		appearance_column_skin = TRUE

		dat += "<h3>[make_font_cool("SKIN")]</h3>"

		dat += "<span style='border: 1px solid #161616; background-color: #[skin_tone];'>&nbsp;&nbsp;&nbsp;</span> "
		dat += make_lockable_button("Change", "byond://?_src_=prefs;preference=s_tone;task=input", slotlocked, br=FALSE)
		dat += "&nbsp;"
		dat += make_lockable_button("Use Preset", "byond://?_src_=prefs;preference=s_tone_preset;task=input", slotlocked)

	var/mutant_colors
	if((MUTCOLORS in pref_species.species_traits) || (MUTCOLORS_PARTSONLY in pref_species.species_traits))

		if(!appearance_column_skin)
			dat += "<td valign='top' width='25%'>"
			appearance_column_skin = TRUE

		dat += "<h3>[make_font_cool("MUTANT COLOR")]</h3>"

		dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> "
		dat += make_lockable_button("Change", "byond://?_src_=prefs;preference=mutant_color;task=input", slotlocked)

		mutant_colors = TRUE

	if(istype(pref_species, /datum/species/ethereal)) //not the best thing to do tbf but I dont know whats better.

		if(!appearance_column_skin)
			dat += "<td valign='top' width='25%'>"
			appearance_column_skin = TRUE

		dat += "<h3>[make_font_cool("ETHEREAL COLOR")]</h3>"

		dat += "<span style='border: 1px solid #161616; background-color: #[features["ethcolor"]];'>&nbsp;&nbsp;&nbsp;</span> "
		dat += make_lockable_button("Change", "byond://?_src_=prefs;preference=color_ethereal;task=input", slotlocked)

	if((EYECOLOR in pref_species.species_traits) && !(NOEYESPRITES in pref_species.species_traits))

		if(!appearance_column_skin)
			dat += "<td valign='top' width='25%'>"
			appearance_column_skin = TRUE

		dat += "<h3>[make_font_cool("EYES")]</h3>"

		dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> "
		dat += make_lockable_button("Change", "byond://?_src_=prefs;preference=eyes;task=input", slotlocked)

	if(appearance_column_skin)
		dat += "</td>"

	if(HAIR in pref_species.species_traits)

		dat += "<td valign='top' width='25%'>"

		dat += "<h3>[make_font_cool("HAIR")]</h3>"

		// hair style
		dat += make_lockable_button(hairstyle, "byond://?_src_=prefs;preference=hairstyle;task=input", slotlocked, br=FALSE)
		dat += make_lockable_button("&lt;", "byond://?_src_=prefs;preference=previous_hairstyle;task=input", slotlocked, br=FALSE)
		dat += " "
		dat += make_lockable_button("&gt;", "byond://?_src_=prefs;preference=next_hairstyle;task=input", slotlocked)

		// hair color
		dat += "<span style='border: 1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> "
		dat += make_lockable_button("Change", "byond://?_src_=prefs;preference=hair;task=input", slotlocked)

		// add hair gradient shit here

		dat += "<h3>[make_font_cool("FACIAL HAIR")]</h3>"

		// facial hair style
		dat += make_lockable_button(facial_hairstyle, "byond://?_src_=prefs;preference=facial_hairstyle;task=input", slotlocked, br=FALSE)
		dat += make_lockable_button("&lt;", "byond://?_src_=prefs;preference=previous_facehairstyle;task=input", slotlocked, br=FALSE)
		dat += " "
		dat += make_lockable_button("&gt;", "byond://?_src_=prefs;preference=next_facehairstyle;task=input", slotlocked)

		// facial hair color
		dat += "<span style='border: 1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> "
		dat += make_lockable_button("Change", "byond://?_src_=prefs;preference=facial;task=input", slotlocked)

		dat += "</td>"

	// underwear
	dat += "<td width ='20%' valign='top'>"
	dat += "<h2>[make_font_cool("UNDERWEAR")]</h2>"

	dat += "<b>Underwear:</b><br>"
	dat += "<a href ='byond://?_src_=prefs;preference=underwear;task=input'>[underwear]</a><br>"

	dat += "<b>Underwear Color:</b><br>"
	dat += "<span style='border: 1px solid #161616; background-color: #[underwear_color];'>&nbsp;&nbsp;&nbsp;</span>"
	dat += "<a href='byond://?_src_=prefs;preference=underwear_color;task=input'>Change</a><br>"

	dat += "<b>Undershirt:</b><br>"
	dat += "<a href ='byond://?_src_=prefs;preference=undershirt;task=input'>[undershirt]</a><br>"

	dat += "<b>Socks:</b><br>"
	dat += "<a href ='byond://?_src_=prefs;preference=socks;task=input'>[socks]</a><br>"

	dat += "<b>Backpack:</b><br>"
	dat += "<a href ='byond://?_src_=prefs;preference=bag;task=input'>[backpack]</a><br>"

	dat += "</td>"

	// flavor text/generation shit
	dat += "<td width ='30%' valign='top'>"

	dat += "<h2>[make_font_cool("DESCRIPTION")]</h2>"

	// flavor text
	dat += "<b>Flavor Text: </b><a href='byond://?_src_=prefs;preference=flavor_text;task=input'>Change</a><br>"
	if(length(flavor_text) == 0) // looks like shit if the flavor text is empty otherwise
		dat += "<br>"
	else if(length(flavor_text) <= 110)
		dat += "<i>[flavor_text]</i><br><br>"
	else
		dat += "<i>[copytext_char(flavor_text, 1, 110)]...</i> <a href='byond://?_src_=prefs;preference=view_flavortext;task=input'>Show More</a><br><br>"

	// headshot
	dat += "<b>Headshot(1:1):</b> <a href='byond://?_src_=prefs;preference=headshot;task=input'>Change</a>"
	if(headshot_link != null)
		dat += " <a href='byond://?_src_=prefs;preference=view_headshot;task=input'>View</a><br>"
	else
		dat += "<br>"

	// ooc notes
	dat += "<b>OOC Notes:</b> [ooc_notes] <a href='byond://?_src_=prefs;preference=ooc_notes;task=input'>Change</a><br>"

	// appearance/generation shit
	if(slotlocked || generation_bonus)
		dat += "<h2>[make_font_cool("EVOLUTION")]</h2>" // no idea what else to call this

	if(slotlocked)
		dat += make_lockable_button("Change Appearance (3)", "byond://?_src_=prefs;preference=change_appearance;task=input", true_experience < 3)

	if(generation_bonus)
		dat += "<a href='byond://?_src_=prefs;preference=reset_with_bonus;task=input'>Create new character with generation bonus ([generation]-[generation_bonus])</a><br>"

	dat += "</td></tr></table>"

	// REMOVE THIS WHEN THE MENU IS ACTUALLY FUCKING FINISHED
	dat += "<center><h2>[make_font_cool("WORK IN PROGRESS")]</h2></center>"
