/datum/action/blood_power
	name = "Blood Power"
	desc = "Use vitae to gain supernatural abilities."
	button_icon_state = "bloodpower"
	button_icon = 'code/modules/wod13/UI/actions.dmi'
	background_icon_state = "discipline"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE

/datum/action/blood_power/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	if (owner?.client?.prefs?.old_discipline)
		button_icon = 'code/modules/wod13/disciplines.dmi'
		icon_icon = 'code/modules/wod13/disciplines.dmi'
	else
		button_icon = 'code/modules/wod13/UI/actions.dmi'
		icon_icon = 'code/modules/wod13/UI/actions.dmi'

	. = ..()

/datum/action/blood_power/Trigger(trigger_flags)
	if (!istype(owner, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/BD = usr

	if (HAS_TRAIT(owner, TRAIT_TORPOR))
		return

	if(world.time < BD.last_bloodpower_use+110)
		return

	var/plus = 0
	if(HAS_TRAIT(BD, TRAIT_HUNGRY))
		plus = 1

	if (BD.bloodpool < 2 + plus)
		SEND_SOUND(BD, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
		to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to become more powerful.</span>")
		return

	playsound(usr, 'code/modules/wod13/sounds/bloodhealing.ogg', 50, FALSE)
	button.color = "#970000"
	animate(button, color = "#ffffff", time = 20, loop = 1)
	BD.last_bloodpower_use = world.time
	BD.bloodpool = max(0, BD.bloodpool-(2+plus))
	to_chat(BD, "<span class='notice'>You use blood to become more powerful.</span>")
	BD.dna.species.punchdamagehigh = BD.dna.species.punchdamagehigh+5
	BD.physiology.armor.melee = BD.physiology.armor.melee+15
	BD.physiology.armor.bullet = BD.physiology.armor.bullet+15
	BD.dexterity = BD.dexterity+2
	BD.athletics = BD.athletics+2
	BD.lockpicking = BD.lockpicking+2
	if(!HAS_TRAIT(BD, TRAIT_IGNORESLOWDOWN))
		ADD_TRAIT(BD, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
	BD.update_blood_hud()
	spawn(100+BD.discipline_time_plus+BD.bloodpower_time_plus)
		end_bloodpower()

/datum/action/blood_power/proc/end_bloodpower()
	if(owner && ishuman(owner))
		var/mob/living/carbon/human/BD = owner
		to_chat(BD, "<span class='warning'>You feel like your <b>BLOOD</b>-powers slowly decrease.</span>")
		if(BD.dna.species)
			BD.dna.species.punchdamagehigh = BD.dna.species.punchdamagehigh-5
			BD.physiology.armor.melee = BD.physiology.armor.melee-15
			BD.physiology.armor.bullet = BD.physiology.armor.bullet-15
			if(HAS_TRAIT(BD, TRAIT_IGNORESLOWDOWN))
				REMOVE_TRAIT(BD, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
		BD.dexterity = BD.dexterity-2
		BD.athletics = BD.athletics-2
		BD.lockpicking = BD.lockpicking-2
