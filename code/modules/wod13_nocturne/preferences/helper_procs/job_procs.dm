/datum/preferences/proc/set_job_preference_level(datum/job/job, level)
	if (!job)
		return FALSE

	if (level == JP_HIGH) // to high
		//Set all other high to medium
		for(var/j in job_preferences)
			if(job_preferences[j] == JP_HIGH)
				job_preferences[j] = JP_MEDIUM
				//technically break here

	job_preferences[job.title] = level
	return TRUE

/datum/preferences/proc/update_job_preference(mob/user, role, desiredLvl)
	if(!SSjob || SSjob.occupations.len <= 0)
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		user << browse(null, "window=mob_occupation")
		return

	if (!isnum(desiredLvl))
		to_chat(user, "<span class='danger'>update_job_preference - desired level was not a number. Please notify coders!</span>")
		return

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	if(role == SSjob.overflow_role)
		if(job_preferences[job.title] == JP_LOW)
			jpval = null
		else
			jpval = JP_LOW

	set_job_preference_level(job, jpval)
	return TRUE

/datum/preferences/proc/reset_jobs()
	job_preferences = list()

/datum/preferences/proc/return_job_color(mob/user, datum/job/job, rank)
	var/bypass = FALSE
	if (check_rights_for(user.client, R_ADMIN))
		bypass = TRUE
	if(is_banned_from(user.ckey, rank))
		return "<font color=red>[rank]</font></td><td><a href='byond://?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
	var/required_playtime_remaining = job.required_playtime_remaining(user.client)
	if(required_playtime_remaining && !bypass)
		return "<font color=#290204>[rank]</font></td><td><font color=#290204> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \]</font></td></tr>"
	if(!job.player_old_enough(user.client) && !bypass)
		var/available_in_days = job.available_in_days(user.client)
		return "<font color=#290204>[rank]</font></td><td><font color=#290204> \[IN [(available_in_days)] DAYS\]</font></td></tr>"
	if((generation > job.minimal_generation) && !bypass)
		return "<font color=#290204>[rank]</font></td><td><font color=#290204> \[FROM [job.minimal_generation] GENERATION AND OLDER\]</font></td></tr>"
	if((masquerade < job.minimal_masquerade) && !bypass)
		return "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[job.minimal_masquerade] MASQUERADE POINTS REQUIRED\]</font></td></tr>"
	if(!job.allowed_species.Find(pref_species.name) && !bypass)
		return "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[pref_species.name] RESTRICTED\]</font></td></tr>"
	if(pref_species.name == "Vampire")
		var/alloww = FALSE
		for(var/i in job.allowed_bloodlines)
			if(i == clan.name)
				alloww = TRUE
		if(!alloww && !bypass)
			return "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[clan.name] RESTRICTED\]</font></td></tr>"
	if((job_preferences[SSjob.overflow_role] == JP_LOW) && (rank != SSjob.overflow_role) && !is_banned_from(user.ckey, SSjob.overflow_role))
		return "<font color=orange>[rank]</font></td><td></td></tr>"

	return ""
