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
			dat += "<BR><b>Fame:</b><BR><a href ='byond://?_src_=prefs;preference=info_choose;task=input'>[info_known]</a>"

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


	dat += "</td></tr></table>"

	// REMOVE THIS WHEN THE MENU IS ACTUALLY FUCKING FINISHED
	dat += "<center><h2>[make_font_cool("WORK IN PROGRESS")]</h2></center>"
