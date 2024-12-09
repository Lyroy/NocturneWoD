/datum/discipline/dementation
	name = "Dementation"
	desc = "Makes all humans in radius mentally ill for a moment, supressing their defending ability."
	icon_state = "dementation"
	clan_restricted = TRUE

/datum/discipline/dementation/New(level)
	. = ..()
	all_powers = subtypesof(/datum/discipline_power/dementation)

/datum/discipline_power/dementation
	name = "Dementation power name"
	desc = "Dementation power description"

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	vitae_cost = 2
	target_type = TARGET_LIVING

	activate_sound = 'code/modules/wod13/sounds/insanity.ogg'

	multi_activation = TRUE
	cooldown = 10 SECONDS
	duration_length = 0

/datum/discipline_power/dementation/activate(mob/living/carbon/human/target)
	. = ..()
	if (!.)
		return .
	var/mob/living/carbon/human/H = target
	H.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	H.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	H.apply_overlay(MUTATIONS_LAYER)

/datum/discipline_power/dementation/deactivate(mob/living/carbon/human/target)
	. = ..()
	if (!.)
		return .
	target.remove_overlay(MUTATIONS_LAYER)

/datum/discipline_power/dementation/can_activate(mob/living/target, alert = FALSE)
	. = ..()
	if (!.)
		return .
	if(target.spell_immunity)
		return FALSE
	var/mypower = owner.social + owner.additional_social
	var/theirpower = target.mentality + target.additional_mentality
	if(theirpower >= mypower)
		if (alert)
			to_chat(owner, "<span class='warning'>[target]'s mind is too powerful to corrupt!</span>")
		return FALSE
	if(!ishuman(target))
		if (alert)
			to_chat(owner, "<span class='warning'>[target] doesn't have enough mind to get affected by this discipline!</span>")
		return FALSE
	return TRUE

//PASSION
/datum/discipline_power/dementation/passion
	name = "Passion"
	desc = "Stir the deepest parts of your target to manipulate their psyche."

	level = 1

/datum/discipline_power/dementation/passion/activate(mob/living/carbon/human/target)
	. = ..()
	if (!.)
		return .
	target.Stun(0.5 SECONDS)
	target.emote("laugh")
	to_chat(target, "<span class='userdanger'><b>HAHAHAHAHAHAHAHAHAHAHAHA!!</b></span>")
	owner.playsound_local(get_turf(H), pick('sound/items/SitcomLaugh1.ogg', 'sound/items/SitcomLaugh2.ogg', 'sound/items/SitcomLaugh3.ogg'), 100, FALSE)
	if(target.body_position == STANDING_UP)
		target.toggle_resting()

//THE HAUNTING
/datum/discipline_power/dementation/the_haunting
	name = "The Haunting"
	desc = "Manipulate your target's senses, making them perceive what isn't there."

	level = 2

/datum/discipline_power/dementation/the_haunting/activate(mob/living/carbon/human/target)
	. = ..()
	if (!.)
		return .
	target.hallucination += 50
	new /datum/hallucination/oh_yeah(target, TRUE)

//EYES OF CHAOS
/datum/discipline_power/dementation/eyes_of_chaos
	name = "Eyes of Chaos"
	desc = "See the hidden patterns in the world and uncover people's true selves."

	level = 3

/datum/discipline_power/dementation/eyes_of_chaos/activate(mob/living/carbon/human/target)
	. = ..()
	if (!.)
		return .
	target.Immobilize(2 SECONDS)
	if(!HAS_TRAIT(target, TRAIT_KNOCKEDOUT) && !HAS_TRAIT(target, TRAIT_IMMOBILIZED) && !HAS_TRAIT(target, TRAIT_RESTRAINED))
		if(prob(50))
			dancefirst(target)
		else
			dancesecond(target)

//VOICE OF MADNESS
/datum/discipline_power/dementation/voice_of_madness
	name = "Voice of Madness"
	desc = "Your voice becomes a source of utter insanity, affecting you and all those around you."

	level = 4

/datum/discipline_power/dementation/voice_of_madness/activate(mob/living/carbon/human/target)
	. = ..()
	if (!.)
		return
	new /datum/hallucination/death(target, TRUE)

//TOTAL INSANITY
/datum/discipline_power/dementation/total_insanity
	name = "Total Insanity"
	desc = "Bring out the darkest parts of a person's psyche, bringing them to utter insanity."

	level = 5

/datum/discipline_power/dementation/total_insanity/activate(mob/living/carbon/human/target)
	. = ..()
	if (!.)
		return
	var/datum/cb = CALLBACK(target, /mob/living/carbon/human/proc/attack_myself_command)
	for(var/i in 1 to 20)
		addtimer(cb, (i - 1) * 1.5 SECONDS)
