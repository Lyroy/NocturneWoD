/obj/item/implanter
	name = "implanter"
	desc = "A sterile automatic implant injector."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "implanter0"
	inhand_icon_state = "syringe_0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=600, /datum/material/glass=200)
	var/obj/item/implant/imp = null
	var/imp_type = null


/obj/item/implanter/update_icon_state()
	if(imp)
		icon_state = "implanter1"
	else
		icon_state = "implanter0"


/obj/item/implanter/attack(mob/living/M, mob/user)
	if(!istype(M))
		return
	if(user && imp)
		if(M != user)
			M.visible_message(span_warning("[user] is attempting to implant [M]."))

		var/turf/T = get_turf(M)
		if(T && (M == user || do_mob(user, M, 50)))
			if(src && imp)
				if(imp.implant(M, user))
					if (M == user)
						to_chat(user, span_notice("You implant yourself."))
					else
						M.visible_message(span_notice("[user] implants [M].</span>"), span_notice("[user] implants you."))
					imp = null
					update_icon()
				else
					to_chat(user, span_warning("[user] fails to implant [src]."))

/obj/item/implanter/attackby(obj/item/I, mob/living/user, params)
	if(IS_WRITING_UTENSIL(I))
		return ..()

/obj/item/implanter/Initialize(mapload)
	. = ..()
	if(imp_type)
		imp = new imp_type(src)
	update_icon()
