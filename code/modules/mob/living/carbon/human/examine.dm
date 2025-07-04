/mob/living/carbon/human/examine(mob/user)
//this is very slightly better than it was because you can use it more places. still can't do \his[src] though.
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()
	var/t_es = p_es()
	var/obscure_name

	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE

	var/my_shape = "average"
	var/my_gender = "male"
	if(gender == MALE)
		switch(age)
			if(1 to 16)
				my_gender = "boy"
			if(16 to 24)
				my_gender = "guy"
			if(24 to INFINITY)
				my_gender = "man"
	if(gender == FEMALE)
		my_gender = "female"
		switch(age)
			if(1 to 16)
				my_gender = "girl"
			if(16 to 24)
				my_gender = "lady"
			if(24 to INFINITY)
				my_gender = "woman"
	if(gender == PLURAL || gender == NEUTER)
		my_gender = "person"
	if(my_shape == "s")
		my_shape = "slim"
	if(my_shape == "f")
		my_shape = "fat"

	. = list("<span class='info'>*---------*\nThis is <EM>[!obscure_name ? name : "Unknown"]</EM>, [age2agedescription(age)] [my_shape] [my_gender]!")

	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))

	//faction, job, etc
	if(iskindred(user) && iskindred(src) && is_face_visible())
		var/mob/living/carbon/human/vampire = user
		var/same_clan = vampire.clan == clan
		switch(info_known)
			if(INFO_KNOWN_PUBLIC)
				. += "<b>You know [p_them()] as a [job] of the [clan] bloodline.</b>"
			if(INFO_KNOWN_CLAN_ONLY)
				if(same_clan)
					. += "<b>You know [p_them()] as a [job]. You are of the same bloodline.</b>"

	//uniform
	if(w_uniform && !(obscured & ITEM_SLOT_ICLOTHING) && !(w_uniform.item_flags & EXAMINE_SKIP))
		//accessory
		var/accessory_msg
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.attached_accessory)
				accessory_msg += " with [icon2html(U.attached_accessory, user)] \a [U.attached_accessory]"

		. += "[t_He] [t_is] wearing [w_uniform.get_examine_string(user)][accessory_msg]."
	//head
	if(head && !(obscured & ITEM_SLOT_HEAD) && !(head.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head."
	//suit/armor
	if(wear_suit && !(wear_suit.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing [wear_suit.get_examine_string(user)]."
		//suit/armor storage
		if(s_store && !(obscured & ITEM_SLOT_SUITSTORE) && !(s_store.item_flags & EXAMINE_SKIP))
			. += "[t_He] [t_is] carrying [s_store.get_examine_string(user)] on [t_his] [wear_suit.name]."
	//back
	if(back && !(back.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."

	//Hands
	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT) && !(I.item_flags & EXAMINE_SKIP))
			. += "[t_He] [t_is] holding [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	var/datum/component/forensics/FR = GetComponent(/datum/component/forensics)
	//gloves
	if(gloves && !(obscured & ITEM_SLOT_GLOVES) && !(gloves.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] [gloves.get_examine_string(user)] on [t_his] hands."
	else if(FR && length(FR.blood_DNA))
		if(num_hands)
			. += "<span class='warning'>[t_He] [t_has] [num_hands > 1 ? "" : "a"] blood-stained hand[num_hands > 1 ? "s" : ""]!</span>"

	//handcuffed?

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/restraints/handcuffs/cable))
			. += "<span class='warning'>[t_He] [t_is] [icon2html(handcuffed, user)] restrained with cable!</span>"
		else
			. += "<span class='warning'>[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!</span>"

	//belt
	if(belt && !(belt.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] [belt.get_examine_string(user)] about [t_his] waist."

	//shoes
	if(shoes && !(obscured & ITEM_SLOT_FEET)  && !(shoes.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing [shoes.get_examine_string(user)] on [t_his] feet."

	//mask
	if(wear_mask && !(obscured & ITEM_SLOT_MASK)  && !(wear_mask.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] [wear_mask.get_examine_string(user)] on [t_his] face."

	if(wear_neck && !(obscured & ITEM_SLOT_NECK)  && !(wear_neck.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)] around [t_his] neck."

	//eyes
	if(!(obscured & ITEM_SLOT_EYES) )
		if(glasses  && !(glasses.item_flags & EXAMINE_SKIP))
			. += "[t_He] [t_has] [glasses.get_examine_string(user)] covering [t_his] eyes."
		else if(eye_color == BLOODCULT_EYE && iscultist(src) && HAS_TRAIT(src, CULT_EYES))
			. += "<span class='warning'><B>[t_His] eyes are glowing an unnatural red!</B></span>"

	//ears
	if(ears && !(obscured & ITEM_SLOT_EARS) && !(ears.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] [ears.get_examine_string(user)] on [t_his] ears."

	//ID
	if(wear_id && !(wear_id.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing [wear_id.get_examine_string(user)]."

//	if(ishuman(user))
//		var/mob/living/carbon/human/US = user
//		if(US.dna.species.id == "kindred" && dna.species.id == "kindred")
//			. += "[t_He] [t_is] at least from <b>[client.prefs.generation]</b> generation."

	//Status effects
	var/list/status_examines = status_effect_examines()
	if (length(status_examines))
		. += status_examines

	//Jitters
	switch(jitteriness)
		if(300 to INFINITY)
			. += "<span class='warning'><B>[t_He] [t_is] convulsing violently!</B></span>"
		if(200 to 300)
			. += "<span class='warning'>[t_He] [t_is] extremely jittery.</span>"
		if(100 to 200)
			. += "<span class='warning'>[t_He] [t_is] twitching ever so slightly.</span>"

	var/appears_dead = FALSE
	var/just_sleeping = FALSE

	if(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH)))
		appears_dead = TRUE

		var/obj/item/clothing/glasses/G = get_item_by_slot(ITEM_SLOT_EYES)
		var/are_we_in_weekend_at_bernies = G?.tint && buckled && istype(buckled, /obj/vehicle/ridden/wheelchair)

		if(isliving(user) && (HAS_TRAIT(user, TRAIT_NAIVE) || are_we_in_weekend_at_bernies))
			just_sleeping = TRUE

		if(!just_sleeping)
			if(suiciding)
				. += "<span class='warning'>[t_He] appear[p_s()] to have committed suicide... there is no hope of recovery.</span>"

			. += generate_death_examine_text()

	if(get_bodypart(BODY_ZONE_HEAD) && !getorgan(/obj/item/organ/brain) && surgeries.len)
		. += "<span class='deadsay'>It appears that [t_his] brain is missing...</span>"

	var/temp = getBruteLoss() //no need to calculate each of these twice

	var/list/msg = list()

	var/list/missing = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/list/disabled = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/body_part = X
		if(body_part.bodypart_disabled)
			disabled += body_part
		missing -= body_part.body_zone
		for(var/obj/item/I in body_part.embedded_objects)
			if(I.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] [icon2html(I, user)] \a [I] stuck to [t_his] [body_part.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] [icon2html(I, user)] \a [I] embedded in [t_his] [body_part.name]!</B>\n"

		for(var/i in body_part.wounds)
			var/datum/wound/iter_wound = i
			msg += "[iter_wound.get_examine_description(user)]\n"

	for(var/X in disabled)
		var/obj/item/bodypart/body_part = X
		var/damage_text
		if(HAS_TRAIT(body_part, TRAIT_DISABLED_BY_WOUND))
			continue // skip if it's disabled by a wound (cuz we'll be able to see the bone sticking out!)
		if(!(body_part.get_damage(include_stamina = FALSE) >= body_part.max_damage)) //we don't care if it's stamcritted
			damage_text = "limp and lifeless"
		else
			damage_text = (body_part.brute_dam >= body_part.burn_dam) ? body_part.heavy_brute_msg : body_part.heavy_burn_msg
		msg += "<B>[capitalize(t_his)] [body_part.name] is [damage_text]!</B>\n"

	//stores missing limbs
	var/l_limbs_missing = 0
	var/r_limbs_missing = 0
	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			msg += "<span class='deadsay'><B>[t_His] [parse_zone(t)] is missing!</B><span class='warning'>\n"
			continue
		if(t == BODY_ZONE_L_ARM || t == BODY_ZONE_L_LEG)
			l_limbs_missing++
		else if(t == BODY_ZONE_R_ARM || t == BODY_ZONE_R_LEG)
			r_limbs_missing++

		msg += "<B>[capitalize(t_his)] [parse_zone(t)] is missing!</B>\n"

	if(l_limbs_missing >= 2 && r_limbs_missing == 0)
		msg += "[t_He] look[p_s()] all right now.\n"
	else if(l_limbs_missing == 0 && r_limbs_missing >= 2)
		msg += "[t_He] really keeps to the left.\n"
	else if(l_limbs_missing >= 2 && r_limbs_missing >= 2)
		msg += "[t_He] [p_do()]n't seem all there.\n"

	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor cellular damage.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> cellular damage!\n"
			else
				msg += "<b>[t_He] [t_has] severe cellular damage!</b>\n"


	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable.\n"
	if(fire_stacks < 0)
		msg += "[t_He] look[p_s()] a little soaked.\n"


	if(pulledby?.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] [t_is] severely malnourished.\n"
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "[t_He] [t_is] plump and delicious looking - Like a fat little piggy. A tasty piggy.\n"
		else
			msg += "[t_He] [t_is] quite chubby.\n"
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			msg += "[t_He] look[p_s()] a bit grossed out.\n"
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			msg += "[t_He] look[p_s()] really grossed out.\n"
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			msg += "[t_He] look[p_s()] extremely disgusted.\n"

	var/apparent_blood_volume = bloodpool
	if((apparent_blood_volume >= round(maxbloodpool * 0.5)) && (apparent_blood_volume < maxbloodpool))
		msg += "[t_He] [t_has] pale skin.\n"
	else if((apparent_blood_volume >= 1) && (apparent_blood_volume < round(maxbloodpool/2)))
		msg += "[t_He] look[p_s()] like pale death.\n"
	else if(bloodpool <= 0)
		msg += "<span class='deadsay'><b>[t_He] resemble[p_s()] a crushed, empty juice pouch.</b></span>\n"

	if(is_bleeding())
		var/list/obj/item/bodypart/bleeding_limbs = list()
		var/list/obj/item/bodypart/grasped_limbs = list()

		for(var/i in bodyparts)
			var/obj/item/bodypart/body_part = i
			if(body_part.get_bleed_rate())
				bleeding_limbs += body_part
			if(body_part.grasped_by)
				grasped_limbs += body_part

		var/num_bleeds = LAZYLEN(bleeding_limbs)

		var/list/bleed_text
		if(appears_dead)
			bleed_text = list("<span class='deadsay'><B>Blood is visible in [t_his] open")
		else
			bleed_text = list("<B>[t_He] [t_is] bleeding from [t_his]")

		switch(num_bleeds)
			if(1 to 2)
				bleed_text += " [bleeding_limbs[1].name][num_bleeds == 2 ? " and [bleeding_limbs[2].name]" : ""]"
			if(3 to INFINITY)
				for(var/i in 1 to (num_bleeds - 1))
					var/obj/item/bodypart/body_part = bleeding_limbs[i]
					bleed_text += " [body_part.name],"
				bleed_text += " and [bleeding_limbs[num_bleeds].name]"

		if(appears_dead)
			bleed_text += ", but it has pooled and is not flowing.</span></B>\n"
		else
			if(reagents.has_reagent(/datum/reagent/toxin/heparin, needs_metabolizing = TRUE))
				bleed_text += " incredibly quickly"

			bleed_text += "!</B>\n"

		for(var/i in grasped_limbs)
			var/obj/item/bodypart/grasped_part = i
			bleed_text += "[t_He] [t_is] holding [t_his] [grasped_part.name] to slow the bleeding!\n"

		msg += bleed_text.Join()

	if(reagents.has_reagent(/datum/reagent/teslium, needs_metabolizing = TRUE))
		msg += "[t_He] [t_is] emitting a gentle blue glow!\n"

	if(islist(stun_absorption))
		for(var/i in stun_absorption)
			if(stun_absorption[i]["end_time"] > world.time && stun_absorption[i]["examine_message"])
				msg += "[t_He] [t_is][stun_absorption[i]["examine_message"]]\n"

	if(just_sleeping)
		msg += "[t_He] [t_is]n't responding to anything around [t_him] and seem[p_s()] to be asleep.\n"

	if(!appears_dead)
		if(drunkenness && !skipface) //Drunkenness
			switch(drunkenness)
				if(11 to 21)
					msg += "[t_He] [t_is] slightly flushed.\n"
				if(21.01 to 41) //.01s are used in case drunkenness ends up to be a small decimal
					msg += "[t_He] [t_is] flushed.\n"
				if(41.01 to 51)
					msg += "[t_He] [t_is] quite flushed and [t_his] breath smells of alcohol.\n"
				if(51.01 to 61)
					msg += "[t_He] [t_is] very flushed and [t_his] movements jerky, with breath reeking of alcohol.\n"
				if(61.01 to 91)
					msg += "[t_He] look[p_s()] like a drunken mess.\n"
				if(91.01 to INFINITY)
					msg += "[t_He] [t_is] a shitfaced, slobbering wreck.\n"

		if(src != user)
			if(HAS_TRAIT(user, TRAIT_EMPATH))
				if (a_intent != INTENT_HELP)
					msg += "[t_He] seem[p_s()] to be on guard.\n"
				if (getOxyLoss() >= 10)
					msg += "[t_He] seem[p_s()] winded.\n"
				if (getToxLoss() >= 10)
					msg += "[t_He] seem[p_s()] sickly.\n"
				var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
				if(mood.sanity <= SANITY_DISTURBED)
					msg += "[t_He] seem[p_s()] distressed.\n"
					SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empath", /datum/mood_event/sad_empath, src)
				if (is_blind())
					msg += "[t_He] appear[p_s()] to be staring off into space.\n"
				if (HAS_TRAIT(src, TRAIT_DEAF))
					msg += "[t_He] appear[p_s()] to not be responding to noises.\n"
				if (bodytemperature > dna.species.bodytemp_heat_damage_limit)
					msg += "[t_He] [t_is] flushed and wheezing.\n"
				if (bodytemperature < dna.species.bodytemp_cold_damage_limit)
					msg += "[t_He] [t_is] shivering.\n"

			msg += "</span>"

			if(HAS_TRAIT(user, TRAIT_SPIRITUAL) && mind?.holy_role)
				msg += "[t_He] [t_has] a holy aura about [t_him].\n"
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "religious_comfort", /datum/mood_event/religiously_comforted)

		switch(stat)
			if(UNCONSCIOUS, HARD_CRIT)
				msg += "[t_He] [t_is]n't responding to anything around [t_him] and seem[p_s()] to be asleep.\n"
			if(SOFT_CRIT)
				msg += "[t_He] [t_is] barely conscious.\n"
			if(CONSCIOUS)
				if(HAS_TRAIT(src, TRAIT_DUMB))
					msg += "[t_He] [t_has] a stupid expression on [t_his] face.\n"

		//examine text for unusual appearances
		if (iskindred(src) && is_face_visible())
			switch (GET_BODY_SPRITE(src))
				if ("nosferatu")
					msg += "<span class='danger'><b>[p_they(TRUE)] look[p_s()] utterly deformed and inhuman!</b></span><br>"
				if ("gargoyle")
					msg += "<span class='danger'><b>[p_they(TRUE)] seem[p_s()] to be made out of stone!</b></span><br>"
				if ("kiasyd")
					if (!is_eyes_covered())
						msg += "<span class='danger'><b>[p_they(TRUE)] [p_have()] no whites in [p_their()] eyes!<b></span><br>"
				if ("rotten1")
					msg += "[p_they(TRUE)] seem[p_s()] oddly gaunt.<br>"
				if ("rotten2")
					msg += "[p_they(TRUE)] [p_have()] a corpselike complexion.<br>"
				if ("rotten3")
					msg += "<span class='danger'><b>[p_they(TRUE)] [p_are()] a decayed corpse!</b></span><br>"
				if ("rotten4")
					msg += "<span class='danger'><b>[p_they(TRUE)] [p_are()] a skeletonised corpse!</b></span><br>"

		if(getorgan(/obj/item/organ/brain))
			if(ai_controller?.ai_status == AI_STATUS_ON)
				msg += "<span class='deadsay'>[t_He] do[t_es]n't appear to be [t_him]self.</span>\n"
			if(!key && !istype(src, /mob/living/carbon/human/npc) && (src.soul_state != SOUL_PROJECTING))
				msg += "<span class='deadsay'>[t_He] [t_is] totally catatonic. The stresses of life must have been too much for [t_him]. Any recovery is unlikely.</span>\n"
			else if(!client && !istype(src, /mob/living/carbon/human/npc) && (src.soul_state != SOUL_PROJECTING))
				msg += "[t_He] [t_has] a blank, absent-minded stare and appears completely unresponsive to anything. [t_He] may snap out of it soon.\n"
			if(src.soul_state == SOUL_PROJECTING)
				msg += "<span class='deadsay'>[t_He] [t_is] staring blanky into space, [t_his] eyes are slightly grayed out.</span>\n"

	//examine text for garou detecting Triatic influences on others
	if (isgarou(user) || iswerewolf(user))
		if (get_dist(user, src) <= 2)
			var/wyrm_taint = NONE
			var/weaver_taint = NONE
			var/wyld_taint = NONE

			if(iscathayan(src))
				if(!check_kuei_jin_alive())
					wyrm_taint++

			if (iskindred(src))
				var/mob/living/carbon/human/vampire = src
				weaver_taint++

				if ((humanity < 7) || client?.prefs?.enlightenment)
					wyrm_taint++

				if ((vampire.clan?.name == "Baali") || ( (client?.prefs?.enlightenment && (humanity > 7)) || (!client?.prefs?.enlightenment && (humanity < 4)) ))
					wyrm_taint++

			if (isgarou(src) || iswerewolf(src)) //werewolves have the taint of whatever Triat member they venerate most
				var/mob/living/carbon/wolf = src

				switch(wolf.auspice.tribe)
					if ("Wendigo")
						wyld_taint++
					if ("Glasswalkers")
						weaver_taint++
					if ("Black Spiral Dancers")
						wyrm_taint = VERY_TAINTED

			if (wyrm_taint == TAINTED)
				msg += "<span class='purple'><i>[p_they(TRUE)] smell[p_s()] of corruption...</i></span>\n"
			else if (wyrm_taint == VERY_TAINTED)
				msg += "<span class='purple'><i>[p_they(TRUE)] REEK[uppertext(p_s())] of the Wyrm and its defilement.</i></span>\n"

			if (weaver_taint == TAINTED)
				msg += "<span class='purple'><i>[p_they(TRUE)] emanate[p_s()] stasis and order...</i></span>\n"
			else if (weaver_taint == VERY_TAINTED)
				msg += "<span class='purple'><i>[p_they(TRUE)] exude[p_s()] the Weaver's choking stasis and control.</i></span>\n"

			if (wyld_taint == TAINTED)
				msg += "<span class='purple'><i>[p_they(TRUE)] radiate[p_s()] chaos and creation...</i></span>\n"
			else if (wyld_taint == VERY_TAINTED)
				msg += "<span class='purple'><i>[p_they(TRUE)] [p_are()] infused with the Wyld's primal energies of creation.</i></span>\n"

			if (!wyrm_taint && !weaver_taint && !wyld_taint)
				msg += "<span class='purple'><i>You aren't sensing any supernatural taint on [p_them()]...</i></span>\n"
		else
			msg += "<span class='purple'><i>[p_they(TRUE)] [p_are()] too far away to sense any taint...</i></span>\n"

	var/scar_severity = 0
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(S.is_visible(user))
			scar_severity += S.severity

	switch(scar_severity)
		if(1 to 4)
			msg += "<span class='tinynoticeital'>[t_He] [t_has] visible scarring, you can look again to take a closer look...</span>\n"
		if(5 to 8)
			msg += "<span class='smallnoticeital'>[t_He] [t_has] several bad scars, you can look again to take a closer look...</span>\n"
		if(9 to 11)
			msg += "<span class='notice'><i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i></span>\n"
		if(12 to INFINITY)
			msg += "<span class='notice'><b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b></span>\n"

	if (length(msg))
		. += "<span class='warning'>[msg.Join("")]</span>"

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	if(ishuman(user))
		. += "<a href='byond://?src=[REF(src)];masquerade=1'>Spot a Masquerade violation</a>"

	var/flavor_text_link
	var/desc_output
	if(flavor_text) desc_output = "[flavor_text]"
	// What examine_tgui.dm uses to determine if flavor text appears as "Obscured".
	var/face_obscured = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	. += "*---------*"
	if (!(face_obscured))
		if(ooc_notes) flavor_text_link = span_notice("<br><a href='byond://?src=[REF(src)];view_flavortext=1'>\[OOC Information\]</a>")
	else
		flavor_text_link = span_notice("<a href='byond://?src=[REF(src)];view_flavortext=1'>\[Examine closely...\]</a>")
	if (flavor_text_link)
		desc_output += "[flavor_text_link]"
	if(desc_output)
		. += desc_output

	var/perpname = get_face_name(get_id_name(""))
	if(perpname && (HAS_TRAIT(user, TRAIT_SECURITY_HUD) || HAS_TRAIT(user, TRAIT_MEDICAL_HUD)))
		var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
		if(R)
			. += "<span class='deptradio'>Rank:</span> [R.fields["rank"]]\n<a href='byond://?src=[REF(src)];hud=1;photo_front=1'>\[Front photo\]</a><a href='byond://?src=[REF(src)];hud=1;photo_side=1'>\[Side photo\]</a>"
		if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD))
			var/cyberimp_detect
			for(var/obj/item/organ/cyberimp/CI in internal_organs)
				if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
					cyberimp_detect += "[!cyberimp_detect ? "[CI.get_examine_string(user)]" : ", [CI.get_examine_string(user)]"]"
			if(cyberimp_detect)
				. += "<span class='notice ml-1'>Detected cybernetic modifications:</span>"
				. += "<span class='notice ml-2'>[cyberimp_detect]</span>"
			if(R)
				var/health_r = R.fields["p_stat"]
				. += "<a href='byond://?src=[REF(src)];hud=m;p_stat=1'>\[[health_r]\]</a>"
				health_r = R.fields["m_stat"]
				. += "<a href='byond://?src=[REF(src)];hud=m;m_stat=1'>\[[health_r]\]</a>"
			R = find_record("name", perpname, GLOB.data_core.medical)
			if(R)
				. += "<a href='byond://?src=[REF(src)];hud=m;evaluation=1'>\[Medical evaluation\]</a><br>"
			. += "<a href='byond://?src=[REF(src)];hud=m;quirk=1'>\[See quirks\]</a>"

		if(HAS_TRAIT(user, TRAIT_SECURITY_HUD))
			if(!user.stat && user != src)
			//|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
				var/criminal = "None"

				R = find_record("name", perpname, GLOB.data_core.security)
				if(R)
					criminal = R.fields["criminal"]

				. += "<span class='deptradio'>Criminal status:</span> <a href='byond://?src=[REF(src)];hud=s;status=1'>\[[criminal]\]</a>"
				. += jointext(list("<span class='deptradio'>Security record:</span> <a href='byond://?src=[REF(src)];hud=s;view=1'>\[View\]</a>",
					"<a href='byond://?src=[REF(src)];hud=s;add_citation=1'>\[Add citation\]</a>",
					"<a href='byond://?src=[REF(src)];hud=s;add_crime=1'>\[Add crime\]</a>",
					"<a href='byond://?src=[REF(src)];hud=s;view_comment=1'>\[View comment log\]</a>",
					"<a href='byond://?src=[REF(src)];hud=s;add_comment=1'>\[Add comment\]</a>"), "")
	else if(isobserver(user))
		. += "<span class='info'><b>Traits:</b> [get_quirk_string(FALSE, CAT_QUIRK_ALL)]</span>"
	. += "*---------*</span>"

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .)

/mob/living/proc/status_effect_examines(pronoun_replacement) //You can include this in any mob's examine() to show the examine texts of status effects!
	var/list/dat = list()
	if(!pronoun_replacement)
		pronoun_replacement = p_they(TRUE)
	for(var/V in status_effects)
		var/datum/status_effect/E = V
		if(E.examine_text)
			var/new_text = replacetext(E.examine_text, "SUBJECTPRONOUN", pronoun_replacement)
			new_text = replacetext(new_text, "[pronoun_replacement] is", "[pronoun_replacement] [p_are()]") //To make sure something become "They are" or "She is", not "They are" and "She are"
			dat += "[new_text]\n" //dat.Join("\n") doesn't work here, for some reason
	if(dat.len)
		return dat.Join()
