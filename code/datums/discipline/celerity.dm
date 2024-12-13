/datum/discipline/celerity
	name = "Celerity"
	desc = "Boosts your speed. Violates Masquerade."
	icon_state = "celerity"

/datum/discipline/celerity/New(level)
	all_powers = subtypesof(/datum/discipline_power/celerity)
	..()

/datum/discipline_power/celerity
	name = "Celerity power name"
	desc = "Celerity power description"

	check_flags = DISC_CHECK_LYING|DISC_CHECK_IMMOBILE

	activate_sound = 'code/modules/wod13/sounds/celerity_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/celerity_deactivate.ogg'

	toggled = TRUE
	duration_length = DURATION_TURN_PLUS

/datum/discipline_power/celerity/proc/celerity_visual(datum/discipline_power/celerity/source, atom/newloc, dir)
	if(owner.celerity_visual) //this check and variable should be removed, but some stuff depends on it, so rework that some time
		var/obj/effect/celerity/C = new(owner.loc)
		C.name = owner.name
		C.appearance = owner.appearance
		C.dir = owner.dir
		animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), alpha = 0, time = 0.5 SECONDS)
		if(owner.CheckEyewitness(owner, owner, 7, FALSE))
			owner.AdjustMasquerade(-1)

/datum/discipline_power/celerity/activate()
	. = ..()
	if (owner.temporis_visual || owner.temporis_blur) //sorry guys, no using two time powers at once
		to_chat(owner, "<span class='userdanger'>Your active Temporis causes Celerity to wrench your body's temporal field apart!</span>")
		owner.emote("scream")
		spawn(DURATION_TURN)
			owner.gib()
		return

	owner.celerity_visual = TRUE
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

/datum/discipline_power/celerity/deactivate()
	. = ..()
	owner.celerity_visual = FALSE
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	return .

/obj/effect/celerity
	name = "Damn"
	desc = "..."
	anchored = TRUE

/obj/effect/celerity/Initialize()
	. = ..()
	spawn(0.5 SECONDS)
		qdel(src)

//CELERITY 1
/datum/movespeed_modifier/celerity
	multiplicative_slowdown = -0.5

/datum/discipline_power/celerity/one
	name = "Celerity 1"
	desc = "Enhances your speed to make everything a little bit easier."

	mutually_exclusive = list(
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/one/activate()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity)

/datum/discipline_power/celerity/one/deactivate()
	 . = ..()
	 owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity)

//CELERITY 2
/datum/movespeed_modifier/celerity2
	multiplicative_slowdown = -0.75

/datum/discipline_power/celerity/two
	name = "Celerity 2"
	desc = "Significantly improves your speed and reaction time."

	mutually_exclusive = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/two/activate()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity2)

/datum/discipline_power/celerity/two/deactivate()
	 . = ..()
	 owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity2)

//CELERITY 3
/datum/movespeed_modifier/celerity3
	multiplicative_slowdown = -1

/datum/discipline_power/celerity/three
	name = "Celerity 3"
	desc = "Move faster. React in less time. Your body is under perfect control."

	mutually_exclusive = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/three/activate()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity3)

/datum/discipline_power/celerity/three/deactivate()
	 . = ..()
	 owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity3)

//CELERITY 4
/datum/movespeed_modifier/celerity4
	multiplicative_slowdown = -1.25

/datum/discipline_power/celerity/four
	name = "Celerity 4"
	desc = "Breach the limits of what is humanly possible. Move like a lightning bolt."

	mutually_exclusive = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/four/activate()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity4)

/datum/discipline_power/celerity/four/deactivate()
	 . = ..()
	 owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity4)

//CELERITY 5
/datum/movespeed_modifier/celerity5
	multiplicative_slowdown = -1.5

/datum/discipline_power/celerity/five
	name = "Celerity 5"
	desc = "You are like light. Blaze your way through the world."

	mutually_exclusive = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four
	)

/datum/discipline_power/celerity/five/activate()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity5)

/datum/discipline_power/celerity/five/deactivate()
	 . = ..()
	 owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity5)
