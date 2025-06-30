/datum/preferences/proc/add_experience(amount)
	true_experience = clamp(true_experience + amount, 0, 1000)

// returns whether or not a character can upgrade their stats
/datum/preferences/proc/handle_upgrade(var/number, var/cost)
	if ((true_experience < cost) || (number >= ATTRIBUTE_BASE_LIMIT))
		return FALSE
	true_experience -= cost
	return TRUE

// a proc that creates the score circles based on attribute and the additional bonus for the attribute
/datum/preferences/proc/build_attribute_score(var/attribute, var/bonus_number, var/price, var/variable_name)
	var/dat
	for(var/a in 1 to attribute)
		dat += "•"
	for(var/b in 1 to bonus_number)
		dat += "•"
	var/leftover_circles = 5 - attribute //5 is the default number of blank circles
	for(var/c in 1 to leftover_circles)
		dat += "o"
	var/real_price = attribute ? (attribute*price) : price //In case we have an attribute of 0, we don't multiply by 0
	if((true_experience >= real_price) && (attribute < ATTRIBUTE_BASE_LIMIT))
		dat += "<a href='byond://?_src_=prefs;preference=[variable_name];task=input'>Increase ([real_price])</a>"
	dat += "<br>"
	return dat
