/datum/preferences/proc/connections_page(mob/user, list/dat)
	dat += "<h2>[make_font_cool("CONNECTIONS")]</h2>"

	// we should really port requiems whole connection thing over at some point
	dat += "Have a Friend: <a href='byond://?_src_=prefs;preference=friend'>[friend == TRUE ? "Enabled" : "Disabled"]</A><BR>"
	dat += "What a Friend knows about me: [friend_text] <a href='byond://?_src_=prefs;preference=friend_text;task=input'>Change</a><BR>"
	dat += "<BR>"
	dat += "Have an Enemy: <a href='byond://?_src_=prefs;preference=enemy'>[enemy == TRUE ? "Enabled" : "Disabled"]</A><BR>"
	dat += "What an Enemy knows about me: [enemy_text] <a href='byond://?_src_=prefs;preference=enemy_text;task=input'>Change</a><BR>"
	dat += "<BR>"
	dat += "Have a Lover: <a href='byond://?_src_=prefs;preference=lover'>[lover == TRUE ? "Enabled" : "Disabled"]</A><BR>"
	dat += "What a Lover knows about me: [lover_text] <a href='byond://?_src_=prefs;preference=lover_text;task=input'>Change</a><BR>"

