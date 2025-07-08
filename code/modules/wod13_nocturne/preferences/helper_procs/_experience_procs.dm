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

	dat += make_dots(attribute + bonus_number, 5 + bonus_number, FALSE)

	var/real_price = attribute ? (attribute*price) : price //In case we have an attribute of 0, we don't multiply by 0
	if(attribute < ATTRIBUTE_BASE_LIMIT)
		dat += make_lockable_button("Increase ([real_price])", "byond://?_src_=prefs;preference=[variable_name];task=input", true_experience < real_price)
	return dat
