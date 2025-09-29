// calculate how many available slots the player has for loadout items
/datum/preferences/proc/calculate_loadout_slots(second_attempt = FALSE)
	if(!SSloadout?.initialized)
		return

	loadout_slots_max = LOADOUT_MAX_SLOTS
	loadout_slots = length(equipped_gear)

	if(!equipped_gear || !length(equipped_gear))
		return

	//this can actually happen; in this case we reset the whole thing n try again
	if(loadout_slots > loadout_slots_max && !second_attempt)
		equipped_gear.Cut()
		calculate_loadout_slots(TRUE)
	else if(second_attempt)
		CRASH("Error - More Loadout slots aren't adding up anymore!")
