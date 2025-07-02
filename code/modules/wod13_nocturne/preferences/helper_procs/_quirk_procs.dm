/datum/preferences/proc/get_quirk_balance()
	var/bal = 0
	bal = 3
	for(var/V in all_quirks)
		var/datum/quirk/T = SSquirks.quirks[V]
		bal -= initial(T.value)
	return bal

/datum/preferences/proc/get_positive_quirk_count()
	. = 0
	for(var/q in all_quirks)
		if(SSquirks.quirk_points[q] > 0)
			.++

/datum/preferences/proc/validate_quirks()
	if(get_quirk_balance() < 0)
		all_quirks = list()
