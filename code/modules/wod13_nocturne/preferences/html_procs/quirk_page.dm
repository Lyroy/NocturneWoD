/datum/preferences/proc/quirk_page(mob/user, list/dat)
	dat += "<center>"

	if(!SSquirks)
		dat += "The quirk subsystem hasn't finished initializing, please hold..."
	else
		dat += "<b>Choose quirk setup</b><br>"
		dat += "<div align='center'>Left-click to add or remove quirks. You need negative quirks to have positive ones.<br>"
		dat += "Quirks are applied at roundstart and cannot normally be removed.</div>"

		dat += "<hr>"
		dat += "<b>Current quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]<br>"

		dat += "[get_positive_quirk_count()] / [MAX_QUIRKS] max positive quirks<br>"
		dat += "<b>Quirk balance remaining:</b> [get_quirk_balance()]<br>"

		for(var/V in SSquirks.quirks)
			var/datum/quirk/T = SSquirks.quirks[V]
			var/quirk_name = initial(T.name)
			var/has_quirk
			var/quirk_cost = initial(T.value) * -1
			var/lock_reason = "This trait is unavailable."
			var/quirk_conflict = FALSE
			for(var/_V in all_quirks)
				if(_V == quirk_name)
					has_quirk = TRUE
			if(initial(T.mood_quirk) && CONFIG_GET(flag/disable_human_mood))
				lock_reason = "Mood is disabled."
				quirk_conflict = TRUE
			if(has_quirk)
				if(quirk_conflict)
					all_quirks -= quirk_name
					has_quirk = FALSE
				else
					quirk_cost *= -1 //invert it back, since we'd be regaining this amount
			if(quirk_cost > 0)
				quirk_cost = "+[quirk_cost]"
			var/font_color = "#AAAAFF"
			if(initial(T.value) != 0)
				font_color = initial(T.value) > 0 ? "#AAFFAA" : "#FFAAAA"

			if(!initial(T.mood_quirk))
				var/datum/quirk/Q = new T()

				if(length(Q.allowed_species))
					var/species_restricted = TRUE
					for(var/i in Q.allowed_species)
						if(i == pref_species.name)
							species_restricted = FALSE
					if(species_restricted)
						lock_reason = "[pref_species.name] restricted."
						quirk_conflict = TRUE
				qdel(Q)

			if(quirk_conflict && lock_reason != "Mood is disabled.")
				dat += "<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)] \
				<font color='red'><b>LOCKED: [lock_reason]</b></font><br>"
			else if(lock_reason != "Mood is disabled.")
				dat += make_lockable_button("[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)", "byond://?_src_=prefs;preference=trait;task=update;trait=[quirk_name]", slotlocked, FALSE)
				if(has_quirk)
					dat += "<b><font color='[font_color]'>[quirk_name]</font></b> - [initial(T.desc)]<br>"
				else
					dat += "<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)]<br>"

		dat += "<br>"
		dat += make_lockable_button("Reset Quirks", "byond://?_src_=prefs;preference=trait;task=reset", slotlocked, FALSE)

	dat += "</center>"
