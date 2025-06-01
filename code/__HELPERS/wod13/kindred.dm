/proc/get_vampire_clan(clan_identifier)
	RETURN_TYPE(/datum/vampire_clan)

	if (ispath(clan_identifier))
		return GLOB.vampire_clans[clan_identifier]
	else if (istext(clan_identifier))
		return GLOB.vampire_clans[GLOB.vampire_clan_list[clan_identifier]]
	else
		return clan_identifier
