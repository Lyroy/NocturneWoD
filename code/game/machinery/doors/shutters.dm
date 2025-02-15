/obj/machinery/door/poddoor/shutters
	gender = PLURAL
	name = "shutters"
	desc = "Heavy duty mechanical shutters with an atmospheric seal that keeps them airtight once closed."
	icon = 'icons/obj/doors/shutters.dmi'
	layer = ABOVE_ALL_MOB_LAYER
	closingLayer = ABOVE_ALL_MOB_LAYER
	damage_deflection = 20
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 75, "bomb" = 25, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 70)
	max_integrity = 100

/obj/machinery/door/poddoor/shutters/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/shutters/indestructible
	name = "hardened shutters"
	ertblast = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/shutters/window
	name = "windowed shutters"
	desc = "A shutter with a thick see-through polycarbonate window."
	icon = 'icons/obj/doors/shutters_window.dmi'
	icon_state = "closed"
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/poddoor/shutters/window/preopen
	icon_state = "open"
	density = FALSE

/obj/machinery/door/poddoor/shutters/armory
	name = "armory shutters"
	ertblast = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	id = 10

/obj/machinery/door/poddoor/shutters/bankvault
	name = "vault shutters"
	ertblast = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	id = 11
