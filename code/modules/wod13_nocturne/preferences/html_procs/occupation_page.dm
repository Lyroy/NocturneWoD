/datum/preferences/proc/occupation_page(mob/user, list/dat)
	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.

	var/limit = 9
	var/widthPerColumn = 295

	var/width = widthPerColumn

	dat += "<center>"
	if(!SSjob || SSjob.occupations.len <= 0)
		dat += "The job SSticker is not yet finished creating jobs, please try again later"
	else
		dat += "<b>Choose occupation chances</b><br>"
		dat += "<div align='center'>Left-click to raise an occupation preference, right-click to lower it.<br></div>"
		dat += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		dat += "<table width='100%' cellpadding='1' cellspacing='0' border='1px solid white' border-collapse='collapse'><tr><td width='20%' valign='top'>" // Table within a table for alignment, also allows you to easily add more colomns.
		dat += "<table width='100%' cellpadding='1' cellspacing='0'><tr>"
		var/index = -1

		var/bypass = FALSE
		/*
		if (check_rights_for(user.client, R_ADMIN))
			bypass = TRUE
		*/
		for(var/datum/job/job in sortList(SSjob.occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))
			index += 1
			if((index >= limit))
				width += widthPerColumn
				dat += "</table></td><td width='20%' valign='top'><table width='100%' cellpadding='1' cellspacing='0'><tr>"
				index = 0

			dat += "<tr bgcolor='[job.selection_color]'><td width='25%' align='center'>"
			var/rank = job.title

			var/displayed_rank = rank
			if(length(job.alt_titles) && (rank in alt_titles_preferences))
				displayed_rank = alt_titles_preferences[rank]

			if(is_banned_from(user.ckey, rank))
				dat += "<font color=red><b>[rank]</b></font></td><td width='75%' align='center'><a href='byond://?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
				continue

			var/required_playtime_remaining = job.required_playtime_remaining(user.client)
			if(required_playtime_remaining && !bypass)
				dat += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \]</font></b></td></tr>"
				continue

			if(!job.player_old_enough(user.client) && !bypass)
				var/available_in_days = job.available_in_days(user.client)
				dat += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[IN [(available_in_days)] DAYS\]</font></b></td></tr>"
				continue

			if((generation > job.minimal_generation) && !bypass)
				dat += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[FROM [job.minimal_generation] GENERATION AND OLDER\]</font></b></td></tr>"
				continue

			if((masquerade < job.minimal_masquerade) && !bypass)
				dat += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[job.minimal_masquerade] MASQUERADE REQUIRED\]</font></b></td></tr>"
				continue

			if(!job.allowed_species.Find(pref_species.name) && !bypass)
				dat += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[pref_species.name] RESTRICTED\]</font></b></td></tr>"
				continue

			if(pref_species.name == "Vampire")
				var/alloww = FALSE
				for(var/i in job.allowed_bloodlines)
					if(i == clan.name)
						alloww = TRUE
				if(!alloww && !bypass)
					dat += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[clan.name] RESTRICTED\]</font></b></td></tr>"
					continue

			if((job_preferences[SSjob.overflow_role] == JP_LOW) && (rank != SSjob.overflow_role) && !is_banned_from(user.ckey, SSjob.overflow_role))
				dat += "<font color=orange><b>[rank]</b></font></td><td width='75%' align='center'></td></tr>"
				continue

			// TFN EDIT START: alt job titles
			var/rank_title_line = "[displayed_rank]"
			if(length(job.alt_titles) && (rank in GLOB.leader_positions))//Bold head jobs
				rank_title_line = "<b><a href='byond://?_src_=prefs;preference=job;task=alt_title;job_title=[job.title]'>[rank_title_line]</a></b>"
			else if(length(job.alt_titles))
				rank_title_line = "<a href='byond://?_src_=prefs;preference=job;task=alt_title;job_title=[job.title]'>[rank_title_line]</a>"
			else
				rank_title_line = "<span class='dark'><b>[rank]</b></span>"
			dat += rank_title_line
			// TFN EDIT END

			dat += "</td><td width='75%' align='center'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences[job.title])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			dat += "<a class='white' href='byond://?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"

			if(rank == SSjob.overflow_role)//Overflow is special
				if(job_preferences[SSjob.overflow_role] == JP_LOW)
					dat += "<font color=green>Yes</font>"
				else
					dat += "<font color=red>No</font>"
				dat += "</a></td></tr>"
				continue

			dat += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			dat += "</a></td></tr>"
		dat += "</td'></tr></table>"
		dat += "</center></table>"

		var/message = "Be an [SSjob.overflow_role] if preferences unavailable"
		if(joblessrole == BERANDOMJOB)
			message = "Get random job if preferences unavailable"
		else if(joblessrole == RETURNTOLOBBY)
			message = "Return to lobby if preferences unavailable"
		dat += "<center><br><a href='byond://?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		dat += "<center><a href='byond://?_src_=prefs;preference=job;task=reset'>Reset Preferences</a></center>"
