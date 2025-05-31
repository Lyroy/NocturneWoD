/area/vtm
	name = "San Francisco"
	icon = 'code/modules/wod13/tiles.dmi'
	icon_state = "sewer"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	wall_rating = VERY_HIGH_WALL_RATING
	var/music
	var/upper = TRUE
	var/zone_type = "masquerade"

/area/vtm/powered(chan)
	if (!requires_power)
		return TRUE
	return FALSE

/area/vtm/proc/break_elysium()
	if (zone_type != "masquerade")
		return

	zone_type = "battle"
	addtimer(CALLBACK(src, PROC_REF(restore_elysium)), 3 MINUTES)

/area/vtm/proc/restore_elysium()
	if (zone_type != "battle")
		return

	zone_type = "masquerade"
