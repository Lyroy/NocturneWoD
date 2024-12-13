/atom/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/Z = user
		if(Z.auspex_examine)
			if(!isturf(src) && !isobj(src) && !ismob(src))
				return
			var/list/fingerprints = list()
			var/list/blood = return_blood_DNA()
			var/list/fibers = return_fibers()
			var/list/reagents = list()

			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(!H.gloves)
					fingerprints += md5(H.dna.uni_identity)

			else if(!ismob(src))
				fingerprints = return_fingerprints()


				if(isturf(src))
					var/turf/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type
				if(isobj(src))
					var/obj/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type

			// We gathered everything. Create a fork and slowly display the results to the holder of the scanner.

			var/found_something = FALSE

			// Fingerprints
			if(length(fingerprints))
				to_chat(user, "<span class='info'><B>Prints:</B></span>")
				for(var/finger in fingerprints)
					to_chat(user, "[finger]")
				found_something = TRUE

			// Blood
			if (length(blood))
				to_chat(user, "<span class='info'><B>Blood:</B></span>")
				found_something = TRUE
				for(var/B in blood)
					to_chat(user, "Type: <font color='red'>[blood[B]]</font> DNA (UE): <font color='red'>[B]</font>")

			//Fibers
			if(length(fibers))
				to_chat(user, "<span class='info'><B>Fibers:</B></span>")
				for(var/fiber in fibers)
					to_chat(user, "[fiber]")
				found_something = TRUE

			//Reagents
			if(length(reagents))
				to_chat(user, "<span class='info'><B>Reagents:</B></span>")
				for(var/R in reagents)
					to_chat(user, "Reagent: <font color='red'>[R]</font> Volume: <font color='red'>[reagents[R]]</font>")
				found_something = TRUE

			if(!found_something)
				to_chat(user, "<I># No forensic traces found #</I>") // Don't display this to the holder user
			return

/datum/movespeed_modifier/temporis5
	multiplicative_slowdown = -2.5

/datum/movespeed_modifier/wing
	multiplicative_slowdown = -0.25

/datum/movespeed_modifier/temporis
	multiplicative_slowdown = 7.5

/proc/dancefirst(mob/living/M)
	if(M.dancing)
		return
	M.dancing = TRUE
	var/matrix/initial_matrix = matrix(M.transform)
	for (var/i in 1 to 75)
		if (!M)
			return
		switch(i)
			if (1 to 15)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (16 to 30)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(1,-1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (31 to 45)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-1,-1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (46 to 60)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-1,1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (61 to 75)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(1,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
		M.setDir(turn(M.dir, 90))
		switch (M.dir)
			if (NORTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (SOUTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,-3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (EAST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (WEST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
		sleep(0.1 SECONDS)
	M.lying_fix()
	M.dancing = FALSE

/proc/dancesecond(mob/living/M)
	if(M.dancing)
		return
	M.dancing = TRUE
	animate(M, transform = matrix(180, MATRIX_ROTATE), time = 1, loop = 0)
	var/matrix/initial_matrix = matrix(M.transform)
	for (var/i in 1 to 60)
		if (!M)
			return
		if (i<31)
			initial_matrix = matrix(M.transform)
			initial_matrix.Translate(0,1)
			animate(M, transform = initial_matrix, time = 1, loop = 0)
		if (i>30)
			initial_matrix = matrix(M.transform)
			initial_matrix.Translate(0,-1)
			animate(M, transform = initial_matrix, time = 1, loop = 0)
		M.setDir(turn(M.dir, 90))
		switch (M.dir)
			if (NORTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (SOUTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,-3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (EAST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (WEST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
		sleep(0.1 SECONDS)
	M.lying_fix()
	M.dancing = FALSE

/mob/living/carbon/human/proc/walk_to_caster(mob/living/step_to)
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_to(src, step_to, 0)
		face_atom(step_to)

/mob/living/carbon/human/proc/step_away_caster(mob/living/step_from)
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_away(src, step_from, 99)
		face_atom(step_from)

/mob/living/carbon/human/proc/attack_myself_command()
	if(!CheckFrenzyMove())
		a_intent = INTENT_HARM
		var/obj/item/I = get_active_held_item()
		if(I)
			if(I.force)
				ClickOn(src)
			else
				drop_all_held_items()
				ClickOn(src)
		else
			ClickOn(src)

/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	/*
	cost = 1
	ranged = FALSE
	delay = 20 SECONDS
	violates_masquerade = TRUE
	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	clan_restricted = TRUE
	*/
	var/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel/GA

/datum/movespeed_modifier/protean2
	multiplicative_slowdown = -0.15

/obj/effect/proc_holder/spell/targeted/shapeshift/gangrel
	name = "Gangrel Form"
	desc = "Take on the shape a wolf."
	charge_max = 50
	cooldown_min = 50
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/gangrel

/datum/discipline/protean/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	/*
	var/mod = min(4, level_casting)
//	var/mutable_appearance/protean_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "protean[mod]", -PROTEAN_LAYER)
	if(!GA)
		GA = new(owner)
	switch(mod)
		if(1)
			owner.drop_all_held_items()
			owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
			owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
			owner.add_client_colour(/datum/client_colour/glass_colour/red)
			spawn(delay+owner.discipline_time_plus)
				if(owner)
					for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner.contents)
						if(G)
							qdel(G)
					owner.remove_client_colour(/datum/client_colour/glass_colour/red)
					owner.playsound_local(owner.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
		if(2)
			owner.drop_all_held_items()
			owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
			owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
			owner.add_client_colour(/datum/client_colour/glass_colour/red)
			owner.add_movespeed_modifier(/datum/movespeed_modifier/protean2)
			spawn(delay+owner.discipline_time_plus)
				if(owner)
					for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner.contents)
						if(G)
							qdel(G)
					owner.remove_client_colour(/datum/client_colour/glass_colour/red)
					owner.playsound_local(owner.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
					owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean2)
		if(3)
			owner.drop_all_held_items()
			GA.Shapeshift(owner)
			spawn(delay+owner.discipline_time_plus)
				if(owner && owner.stat != DEAD)
					GA.Restore(GA.myshape)
					owner.Stun(15)
					owner.do_jitter_animation(30)
					owner.playsound_local(owner, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
		if(4 to 5)
			owner.drop_all_held_items()
			if(level_casting == 4)
				GA.shapeshift_type = /mob/living/simple_animal/hostile/gangrel/better
			if(level_casting == 5)
				GA.shapeshift_type = /mob/living/simple_animal/hostile/gangrel/best
			GA.Shapeshift(owner)
			spawn(delay+owner.discipline_time_plus)
				if(owner && owner.stat != DEAD)
					GA.Restore(GA.myshape)
					owner.Stun(10)
					owner.do_jitter_animation(15)
					owner.playsound_local(owner, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
	*/

/mob/living/proc/tremere_gib()
	Stun(50)
	new /obj/effect/temp_visual/tremere(loc, "gib")
	animate(src, pixel_y = 16, color = "#ff0000", time = 50, loop = 1)

	spawn(50)
		if(stat != DEAD)
			death()
		var/list/items = list()
		items |= get_equipped_items(TRUE)
		for(var/obj/item/I in items)
			dropItemToGround(I)
		drop_all_held_items()
		spawn_gibs()
		spawn_gibs()
		spawn_gibs()
		qdel(src)

/obj/effect/projectile/tracer/thaumaturgy
	name = "blood beam"
	icon_state = "cult"

/obj/effect/projectile/muzzle/thaumaturgy
	name = "blood beam"
	icon_state = "muzzle_cult"

/obj/effect/projectile/impact/thaumaturgy
	name = "blood beam"
	icon_state = "impact_cult"

/obj/projectile/thaumaturgy
	name = "blood beam"
	icon_state = "thaumaturgy"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 5
	damage_type = BURN
	hitsound = 'code/modules/wod13/sounds/drinkblood1.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = LASER
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 1
	light_color = COLOR_SOFT_RED
	ricochets_max = 0
	ricochet_chance = 0
	tracer_type = /obj/effect/projectile/tracer/thaumaturgy
	muzzle_type = /obj/effect/projectile/muzzle/thaumaturgy
	impact_type = /obj/effect/projectile/impact/thaumaturgy
	var/level = 1

/obj/projectile/thaumaturgy/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if(ishuman(firer))
		var/mob/living/carbon/human/VH = firer
		if(isliving(target))
			var/mob/living/VL = target
			if(isgarou(VL))
				if(VL.bloodpool >= 1 && VL.stat != DEAD)
					var/sucked = min(VL.bloodpool, 2)
					VL.adjust_blood_points(-sucked)
					VL.apply_damage(45, BURN)
					VL.visible_message("<span class='danger'>[target]'s wounds spray boiling hot blood!</span>", "<span class='userdanger'>Your blood boils!</span>")
					VL.add_splatter_floor(get_turf(target))
					VL.add_splatter_floor(get_turf(get_step(target, target.dir)))
				if(!iskindred(target))
					if(VL.bloodpool >= 1 && VL.stat != DEAD)
						var/sucked = min(VL.bloodpool, 2)
						VL.adjust_blood_points(-sucked)
					if(ishuman(VL))
						if(VL.bloodpool >= 1 && VL.stat != DEAD)
							var/mob/living/carbon/human/VHL = VL
							VHL.adjust_blood_points(-1)
//							if(isnpc(VL))
//								AdjustHumanity(VH, -1, 3)
					//VH.adjust_blood_points(sucked)
			else
				if(VL.bloodpool >= 1)
					var/sucked = min(VL.bloodpool, level)
					VL.adjust_blood_points(-sucked)
					VH.adjust_blood_points(sucked)

/datum/discipline/thaumaturgy
	name = "Thaumaturgy"
	desc = "Opens the secrets of blood magic and how you use it, allows to steal other's blood. Violates Masquerade."
	icon_state = "thaumaturgy"
	/*
	cost = 1
	ranged = TRUE
	delay = 5 SECONDS
	violates_masquerade = TRUE
	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'
	clan_restricted = TRUE
	dead_restricted = FALSE
	*/

/datum/discipline/thaumaturgy/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	switch(level_casting)
		if(1)
			var/turf/start = get_turf(owner)
			var/obj/projectile/thaumaturgy/H = new(start)
			H.firer = owner
			H.preparePixelProjectile(target, start)
			H.fire(direct_target = target)
		if(2)
			var/turf/start = get_turf(owner)
			var/obj/projectile/thaumaturgy/H = new(start)
			H.firer = owner
			H.damage = 10+owner.thaum_damage_plus
			H.preparePixelProjectile(target, start)
			H.level = 2
			H.fire(direct_target = target)
		if(3)
			var/turf/start = get_turf(owner)
			var/obj/projectile/thaumaturgy/H = new(start)
			H.firer = owner
			H.damage = 15+owner.thaum_damage_plus
			H.preparePixelProjectile(target, start)
			H.level = 2
			H.fire(direct_target = target)
		else
			if(iscarbon(target))
				target.Stun(2.5 SECONDS)
				target.visible_message("<span class='danger'>[target] throws up!</span>", "<span class='userdanger'>You throw up!</span>")
				playsound(get_turf(target), 'code/modules/wod13/sounds/vomit.ogg', 75, TRUE)
				target.add_splatter_floor(get_turf(target))
				target.add_splatter_floor(get_turf(get_step(target, target.dir)))
			else
				owner.adjust_blood_points(target.bloodpool)
				if(!istype(target, /mob/living/simple_animal/hostile/megafauna))
//				if(isnpc(target))
//					AdjustHumanity(owner, -1, 0)
					target.tremere_gib()
/*
/datum/discipline/bloodshield
	name = "Blood shield"
	desc = "Boosts armor."
	icon_state = "bloodshield"
	cost = 2
	ranged = FALSE
	delay = 150
	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

/datum/discipline/bloodshield/activate(mob/living/target, mob/living/carbon/human/owner)
	..()
	var/mod = level_casting
	owner.physiology.armor.melee = owner.physiology.armor.melee+(15*mod)
	owner.physiology.armor.bullet = owner.physiology.armor.bullet+(15*mod)
	animate(owner, color = "#ff0000", time = 10, loop = 1)
//	owner.color = "#ff0000"
	spawn(delay+owner.discipline_time_plus)
		if(owner)
			playsound(owner.loc, 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
			owner.physiology.armor.melee = owner.physiology.armor.melee-(15*mod)
			owner.physiology.armor.bullet = owner.physiology.armor.bullet-(15*mod)
			owner.color = initial(owner.color)
*/

/datum/discipline/serpentis
	name = "Serpentis"
	desc = "Act like a cobra, get the powers to stun targets with your gaze and your tongue, praise the mummy traditions and spread them to your childe. Violates Masquerade."
	icon_state = "serpentis"
	/*
	cost = 1
	ranged = TRUE
	delay = 5
//	range_sh = 2
	violates_masquerade = TRUE
	clan_restricted = TRUE
	dead_restricted = FALSE
	*/

/datum/discipline/serpentis/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	if(level_casting == 1)
		var/antidir = NORTH
		switch(owner.dir)
			if(NORTH)
				antidir = SOUTH
			if(SOUTH)
				antidir = NORTH
			if(WEST)
				antidir = EAST
			if(EAST)
				antidir = WEST
		if(target.dir == antidir)
			target.Immobilize(10)
			target.visible_message("<span class='warning'><b>[owner] hypnotizes [target] with his eyes!</b></span>", "<span class='warning'><b>[owner] hypnotizes you like a cobra!</b></span>")
			owner.playsound_local(target.loc, 'code/modules/wod13/sounds/serpentis.ogg', 50, TRUE)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				H.remove_overlay(MUTATIONS_LAYER)
				var/mutable_appearance/serpentis_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "serpentis", -MUTATIONS_LAYER)
				H.overlays_standing[MUTATIONS_LAYER] = serpentis_overlay
				H.apply_overlay(MUTATIONS_LAYER)
				spawn(5)
					H.remove_overlay(MUTATIONS_LAYER)
	if(level_casting >= 2)
//		var/turf/start = get_turf(owner)
//		var/obj/projectile/tentacle/H = new(start)
//		H.hitsound = 'code/modules/wod13/sounds/tongue.ogg'
		var/bloodpoints_to_suck = max(0, min(target.bloodpool, level_casting-1))
		if(bloodpoints_to_suck)
			owner.adjust_blood_points(bloodpoints_to_suck)
			target.adjust_blood_points(-bloodpoints_to_suck)
		var/obj/item/ammo_casing/magic/tentacle/casing = new (owner.loc)
		playsound(owner.loc, 'code/modules/wod13/sounds/tongue.ogg', 100, TRUE)
		casing.fire_casing(target, owner, null, null, null, ran_zone(), 0,  owner)
		owner.playsound_local(target.loc, 'code/modules/wod13/sounds/serpentis.ogg', 50, TRUE)
		qdel(casing)

/datum/discipline/vicissitude
	name = "Vicissitude"
	desc = "It is widely known as Tzimisce art of flesh and bone shaping. Violates Masquerade."
	icon_state = "vicissitude"
	/*
	cost = 1
	ranged = TRUE
	delay = 100
	range_sh = 2
	violates_masquerade = TRUE
	clan_restricted = TRUE
	dead_restricted = FALSE
	*/

/datum/discipline/vicissitude/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	if(iswerewolf(target) || isgarou(target))
		owner.playsound_local(owner.loc, 'code/modules/wod13/sounds/vicissitude.ogg', 50, TRUE)
		//owner.adjustFireLoss(35)		//abusers suffer no more
		owner.Stun(20)
		owner.emote("scream")
		target.apply_damage(10*level_casting, BRUTE)
		target.apply_damage(5*level_casting, CLONE)
		target.visible_message("<span class='danger'>[target]'s skin writhes like worms, twisting and contorting!</span>", "<span class='userdanger'>Your flesh twists unnaturally!</span>")
		target.Stun(30)
		target.emote("scream")
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		owner.playsound_local(target.loc, 'code/modules/wod13/sounds/vicissitude.ogg', 50, TRUE)
		if(target.stat >= UNCONSCIOUS)
			if(istype(target, /mob/living/carbon/human/npc))
				var/mob/living/carbon/human/npc/NPC = target
				NPC.last_attacker = null
			if(!iskindred(target) || !isgarou(target))
				if(H.stat != DEAD)
					H.death()
				switch(level_casting)
					if(1)
						new /obj/item/stack/human_flesh(target.loc)
						new /obj/item/guts(target.loc)
						qdel(target)
					if(2)
						new /obj/item/stack/human_flesh/five(target.loc)
						new /obj/item/guts(target.loc)
						new /obj/item/spine(target.loc)
						var/obj/item/bodypart/B = H.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
						if(B)
							B.drop_limb()
						qdel(target)
					if(3)
						var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
						var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
						var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
						var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
						if(B1)
							B1.drop_limb()
						if(B2)
							B2.drop_limb()
						if(B3)
							B3.drop_limb()
						if(B4)
							B4.drop_limb()
						new /obj/item/stack/human_flesh/ten(target.loc)
						new /obj/item/guts(target.loc)
						new /obj/item/spine(target.loc)
						qdel(target)
					if(4)
						var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
						var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
						var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
						var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
						var/obj/item/bodypart/CH = H.get_bodypart(BODY_ZONE_CHEST)
						if(B1)
							B1.drop_limb()
						if(B2)
							B2.drop_limb()
						if(B3)
							B3.drop_limb()
						if(B4)
							B4.drop_limb()
						if(CH)
							CH.dismember()
						new /obj/item/stack/human_flesh/twenty(target.loc)
						qdel(target)
					if(5)
						var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
						var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
						var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
						var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
						var/obj/item/bodypart/CH = H.get_bodypart(BODY_ZONE_CHEST)
						var/obj/item/bodypart/HE = H.get_bodypart(BODY_ZONE_HEAD)
						if(B1)
							B1.drop_limb()
						if(B2)
							B2.drop_limb()
						if(B3)
							B3.drop_limb()
						if(B4)
							B4.drop_limb()
						if(CH)
							CH.dismember()
						if(HE)
							HE.dismember()
						new /obj/item/stack/human_flesh/fifty(target.loc)
						new /obj/item/guts(target.loc)
						new /obj/item/spine(target.loc)
						qdel(target)
		else
			target.emote("scream")
			target.apply_damage(20*level_casting, BRUTE, BODY_ZONE_CHEST)
			if(prob(5*level_casting))
				var/obj/item/bodypart/B = H.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
				if(B)
					B.drop_limb()
	//else
		//target.death() - Removed until a better solution is found to not have insta-kills on player mobs, unsure of side effects for normal vicissitude use but call death above already so should be fine?

/turf
	var/silented = FALSE

/obj/projectile/quietus
	name = "acid spit"
	icon_state = "har4ok"
	pass_flags = PASSTABLE
	damage = 80
	damage_type = BURN
	hitsound = 'sound/weapons/effects/searwall.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	ricochets_max = 0
	ricochet_chance = 0

/datum/discipline/quietus
	name = "Quietus"
	desc = "Make a poison out of nowhere and forces all beings in range to mute, poison your touch, poison your weapon, poison your spit and make it acid. Violates Masquerade."
	icon_state = "quietus"
	/*
	cost = 1
	ranged = FALSE
	delay = 50
//	range = 2
	violates_masquerade = TRUE
	clan_restricted = TRUE
	*/

/datum/discipline/quietus/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	owner.playsound_local(target.loc, 'code/modules/wod13/sounds/quietus.ogg', 50, TRUE)
	switch(level_casting)
		if(1)
			for(var/mob/living/carbon/human/H in oviewers(7, owner))
				ADD_TRAIT(H, TRAIT_DEAF, "quietus")
				if(H.get_confusion() < 15)
					var/diff = 15 - H.get_confusion()
					H.add_confusion(min(15, diff))
				spawn(50)
					if(H)
						REMOVE_TRAIT(H, TRAIT_DEAF, "quietus")
		if(2)
			owner.drop_all_held_items()
			owner.put_in_active_hand(new /obj/item/melee/touch_attack/quietus(owner))
		if(3)
			if(owner.lastattacked)
				if(isliving(owner.lastattacked))
					var/mob/living/L = owner.lastattacked
					L.adjustStaminaLoss(80)
					L.adjustFireLoss(10)
					to_chat(owner, "You send your curse on [L], the last creature you attacked.")
				else
					to_chat(owner, "You don't seem to have last attacked soul earlier...")
					return
			else
				to_chat(owner, "You don't seem to have last attacked soul earlier...")
				return
		if(4)
			owner.drop_all_held_items()
			owner.put_in_active_hand(new /obj/item/quietus_upgrade(owner))
		if(5)
			owner.drop_all_held_items()
			owner.put_in_active_hand(new /obj/item/gun/magic/quietus(owner))

/obj/item/gun/magic/quietus
	name = "acid spit"
	desc = "Spit poison on your targets."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "har4ok"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL | NOBLUDGEON
	flags_1 = NONE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	ammo_type = /obj/item/ammo_casing/magic/quietus
	fire_sound = 'sound/effects/splat.ogg'
	force = 0
	max_charges = 1
	fire_delay = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	item_flags = DROPDEL

/obj/item/ammo_casing/magic/quietus
	name = "acid spit"
	desc = "A spit."
	projectile_type = /obj/projectile/quietus
	caliber = CALIBER_TENTACLE
	firing_effect_type = null
	item_flags = DROPDEL

/obj/item/gun/magic/quietus/process_fire()
	. = ..()
	if(charges == 0)
		qdel(src)
/*
	playsound(target.loc, 'code/modules/wod13/sounds/quietus.ogg', 50, TRUE)
	target.Stun(5*level_casting)
	if(level_casting >= 3)
		if(target.bloodpool > 1)
			var/transfered = max(1, target.bloodpool-3)
			owner.adjust_blood_points(transfered)
			target.adjust_blood_points(-transfered)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/quietus_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "quietus", -MUTATIONS_LAYER)
		H.overlays_standing[MUTATIONS_LAYER] = quietus_overlay
		H.apply_overlay(MUTATIONS_LAYER)
		spawn(5*level_casting)
			H.remove_overlay(MUTATIONS_LAYER)
*/
/datum/discipline/necromancy
	name = "Necromancy"
	desc = "Offers control over another, undead reality."
	icon_state = "necromancy"
	/*
	cost = 1
	ranged = TRUE
	range_sh = 2
	delay = 50
	violates_masquerade = TRUE
	clan_restricted = TRUE
	dead_restricted = FALSE
	*/

/datum/discipline/necromancy/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	owner.playsound_local(target.loc, 'code/modules/wod13/sounds/necromancy.ogg', 50, TRUE)
	var/limit = min(3, level)+owner.social-1+owner.more_companions
	if(length(owner.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/B = pick(owner.beastmaster)
		B.death()
	if(target.stat == DEAD)
		switch(level_casting)
			if(1)
				if(!length(owner.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(owner)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(owner)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level1(owner.loc)
				M.my_creator = owner
				owner.beastmaster |= M
				M.beastmaster = owner
//				if(target.key)
//					M.key = target.key
//				else
//					M.give_player()
				target.gib()
			if(2)
				if(!length(owner.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(owner)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(owner)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level2(owner.loc)
				M.my_creator = owner
				owner.beastmaster |= M
				M.beastmaster = owner
				target.gib()
			if(3)
				if(!length(owner.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(owner)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(owner)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level3(owner.loc)
				M.my_creator = owner
				owner.beastmaster |= M
				M.beastmaster = owner
				target.gib()
			if(4)
				if(!length(owner.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(owner)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(owner)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level4(owner.loc)
				M.my_creator = owner
				owner.beastmaster |= M
				M.beastmaster = owner
				target.gib()
			if(5)
				if(!length(owner.beastmaster))
					var/datum/action/beastmaster_stay/E1 = new()
					E1.Grant(owner)
					var/datum/action/beastmaster_deaggro/E2 = new()
					E2.Grant(owner)
				var/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/M = new /mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level5(owner.loc)
				M.my_creator = owner
				owner.beastmaster |= M
				M.beastmaster = owner
				target.gib()
	else
		target.apply_damage(5 * level_casting, BRUTE, owner.zone_selected)
		target.apply_damage(6 * level_casting, CLONE, owner.zone_selected)
		target.emote("scream")

/datum/discipline/obtenebration
	name = "Obtenebration"
	desc = "Controls the darkness around you."
	icon_state = "obtenebration"
	/*
	cost = 1
	ranged = TRUE
	delay = 100
	violates_masquerade = TRUE
	clan_restricted = TRUE
	activate_sound = 'sound/magic/voidblink.ogg'
	*/

/datum/discipline/obtenebration/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	/*
	if(level_casting == 1)
		var/atom/movable/AM = new(target)
		AM.set_light(3, -7)
		spawn(delay+owner.discipline_time_plus)
			AM.set_light(0)
	else
		target.Stun(10*(level_casting-1))
		var/obj/item/ammo_casing/magic/tentacle/lasombra/casing = new (owner.loc)
		casing.fire_casing(target, owner, null, null, null, ran_zone(), 0,  owner)
	*/

/datum/discipline/daimonion
	name = "Daimonion"
	desc = "Get a help from the Hell creatures, resist THE FIRE, transform into an imp. Violates Masquerade."
	icon_state = "daimonion"
	/*
	cost = 1
	ranged = FALSE
	delay = 150
	violates_masquerade = TRUE
	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	clan_restricted = TRUE
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/BAT
	*/

/datum/discipline/daimonion/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	/*
	var/mod = min(4, level_casting)
//	var/mutable_appearance/protean_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "protean[mod]", -PROTEAN_LAYER)
	if(!BAT)
		BAT = new(owner)
	switch(mod)
		if(1)
			owner.physiology.burn_mod *= 1/100
			owner.color = "#884200"
			spawn(delay+owner.discipline_time_plus)
				if(owner)
					owner.color = initial(owner.color)
					owner.physiology.burn_mod *= 100
					owner.playsound_local(owner.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
		if(2)
			owner.dna.species.GiveSpeciesFlight(owner)
			spawn(delay+owner.discipline_time_plus)
				if(owner)
					owner.dna.species.RemoveSpeciesFlight(owner)
					owner.playsound_local(owner.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
		if(3)
			owner.drop_all_held_items()
			owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
			owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
			spawn(delay+owner.discipline_time_plus)
				if(owner)
					for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner)
						if(G)
							qdel(G)
					owner.playsound_local(owner.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
		if(4 to 5)
			owner.drop_all_held_items()
			BAT.Shapeshift(owner)
			spawn(delay+owner.discipline_time_plus)
				if(owner && owner.stat != DEAD)
					BAT.Restore(BAT.myshape)
					owner.Stun(15)
					owner.do_jitter_animation(30)
					owner.playsound_local(owner.loc, 'code/modules/wod13/sounds/protean_deactivate.ogg', 50, FALSE)
	*/

/datum/discipline/valeren
	name = "Valeren"
	desc = "Use your third eye in healing or protecting needs."
	icon_state = "valeren"
	/*
	cost = 1
	ranged = TRUE
	delay = 50
	violates_masquerade = FALSE
	activate_sound = 'code/modules/wod13/sounds/valeren.ogg'
	clan_restricted = TRUE
	dead_restricted = FALSE
	var/datum/beam/current_beam
	var/humanity_restored = 0
	*/

/datum/discipline/valeren/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	/*
	switch(level_casting)
		if(1)
			healthscan(owner, target, 1, FALSE)
			chemscan(owner, target)
//			woundscan(owner, target, src)
			to_chat(owner, "<b>[target]</b> has <b>[num2text(target.bloodpool)]/[target.maxbloodpool]</b> blood points.")
			to_chat(owner, "<b>[target]</b> has a rating of <b>[target.humanity]</b> on their path.")
		if(2)
			if(get_dist(owner, target) <= 2)
				if(isgarou(target))
					return
				if(iskindred(target))
					target.add_confusion(5)
					target.drowsyness += 4
				else if(ishuman(target))
					target.SetSleeping(30 SECONDS)
			else
				to_chat(owner, "You need to be close to use this power.")
				return
		if(3)
			if(current_beam)
				qdel(current_beam)
			owner.Beam(target, icon_state="sm_arc", time = 50, maxdistance = 9, beam_type = /obj/effect/ebeam/medical)
			target.adjustBruteLoss(-50, TRUE)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				if(length(H.all_wounds))
					var/datum/wound/W = pick(H.all_wounds)
					W.remove_wound()
			target.adjustFireLoss(-50, TRUE)
			target.update_damage_overlays()
			target.update_health_hud()
		if(4)
			if(current_beam)
				qdel(current_beam)
			owner.Beam(target, icon_state="sm_arc", time = 50, maxdistance = 9, beam_type = /obj/effect/ebeam/medical)
			target.adjustBruteLoss(-60, TRUE)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				if(length(H.all_wounds))
					var/datum/wound/W = pick(H.all_wounds)
					W.remove_wound()
			target.adjustFireLoss(-60, TRUE)
			target.update_damage_overlays()
			target.update_health_hud()
		if(5)
			if(owner.grab_state > GRAB_PASSIVE)
				if(ishuman(owner.pulling))
					var/mob/living/carbon/human/PB = owner.pulling
					if(do_after(owner, 10 SECONDS) && iskindred(PB) && humanity_restored < 3)
						to_chat(owner, "<span class='notice'>You healed [PB]'s soul slightly.</span>")
						PB.AdjustHumanity(1, 10)
						humanity_restored += 1
					else if(humanity_restored >=3)
						to_chat(owner, "<span class='warning'>You can't heal anymore souls this night.</span>")
					else
						to_chat(owner, "<span class='warning'>You need to grab a kindred and stay still to use this power.</span>")
						return
			else
				to_chat(owner, "<span class='warning'>You need to hold your patient properly to heal their soul.</span>")
				return
	*/

/datum/discipline/melpominee
	name = "Melpominee"
	desc = "Named for the Greek Muse of Tragedy, Melpominee is a unique discipline of the Daughters of Cacophony. It explores the power of the voice, shaking the very soul of those nearby and allowing the vampire to perform sonic feats otherwise impossible."
	icon_state = "melpominee"
	/*
	cost = 1
	ranged = TRUE
	delay = 75
	violates_masquerade = FALSE
	activate_sound = 'code/modules/wod13/sounds/melpominee.ogg'
	clan_restricted = TRUE
	dead_restricted = FALSE
	*/

/*
/mob/living/carbon/human/proc/create_walk_to(var/max)
	var/datum/cb = CALLBACK(src,/mob/living/carbon/human/proc/walk_to_caster)
	for(var/i in 1 to max)
		addtimer(cb, (i - 1)*total_multiplicative_slowdown())

/datum/discipline/melpominee/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	switch(level_casting)
		if(1)
			if (target.stat == DEAD)
				//why? because of laziness, it sends messages to deadchat if you do that
				to_chat(owner, "<span class='notice'>You can't use this on corpses.</span>")
				return
			var/new_say = input(owner, "What will your target say?") as text|null
			if(new_say)
				if(CHAT_FILTER_CHECK(new_say))
					to_chat(owner, "<span class='warning'>That message contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[new_say]\"</span></span>")
					SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
					return
				target.say("[new_say]", forced = "melpominee 1")

				var/base_difficulty = 5
				var/difficulty_malus = 0
				var/masked = FALSE
				if (ishuman(target)) //apply a malus and different text if victim's mouth isn't visible, and a malus if they're already typing
					var/mob/living/carbon/human/victim = target
					if ((victim.wear_mask?.flags_inv & HIDEFACE) || (victim.head?.flags_inv & HIDEFACE))
						masked = TRUE
						base_difficulty += 2
					if (victim.overlays_standing[SAY_LAYER]) //ugly way to check for if the victim is currently typing
						base_difficulty += 2

				for (var/mob/living/hearer in (view(7, target) - owner - target))
					if (!hearer.client)
						continue
					difficulty_malus = 0
					if (get_dist(hearer, target) > 3)
						difficulty_malus += 1
					if (storyteller_roll(hearer.mentality + hearer.additional_mentality, base_difficulty + difficulty_malus) == ROLL_SUCCESS)
						if (masked)
							to_chat(hearer, "<span class='warning'>[target.name]'s jaw isn't moving to match [target.p_their()] words.</span>")
						else
							to_chat(hearer, "<span class='warning'>[target.name]'s lips aren't moving to match [target.p_their()] words.</span>")
		if(2)
			target = input(owner, "Who will you project your voice to?") as null|mob in (GLOB.player_list - owner)
			if(target)
				var/input_message = input(owner, "What message will you project to them?") as null|text
				if (input_message)
					if(CHAT_FILTER_CHECK(input_message))
						to_chat(owner, "<span class='warning'>That message contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[input_message]\"</span></span>")
						SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
						return
					var/language = owner.get_selected_language()
					var/message = owner.compose_message(owner, language, input_message, , list())
					to_chat(target, "<span class='purple'><i>You hear someone's voice in your head...</i></span>")
					target.Hear(message, target, language, input_message, , , )
					to_chat(owner, "<span class='notice'>You project your voice to [target]'s ears.</span>")
		if(3)
			for(var/mob/living/carbon/human/HU in oviewers(7, owner))
				if(HU)
					HU.owner = owner
					HU.create_walk_to(2 SECONDS)
					HU.remove_overlay(MUTATIONS_LAYER)
					var/mutable_appearance/song_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "song", -MUTATIONS_LAYER)
					HU.overlays_standing[MUTATIONS_LAYER] = song_overlay
					HU.apply_overlay(MUTATIONS_LAYER)
					spawn(2 SECONDS)
						if(HU)
							HU.remove_overlay(MUTATIONS_LAYER)
		if(4)
			playsound(owner.loc, 'code/modules/wod13/sounds/killscream.ogg', 100, FALSE)
			for(var/mob/living/carbon/human/HU in oviewers(7, owner))
				if(HU)
					HU.Stun(2 SECONDS)
					HU.remove_overlay(MUTATIONS_LAYER)
					var/mutable_appearance/song_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "song", -MUTATIONS_LAYER)
					HU.overlays_standing[MUTATIONS_LAYER] = song_overlay
					HU.apply_overlay(MUTATIONS_LAYER)
					spawn(2 SECONDS)
						if(HU)
							HU.remove_overlay(MUTATIONS_LAYER)
		if(5)
			playsound(owner.loc, 'code/modules/wod13/sounds/killscream.ogg', 100, FALSE)
			for(var/mob/living/carbon/human/HU in oviewers(7, owner))
				if(HU)
					HU.Stun(20)
					HU.apply_damage(50, BRUTE, BODY_ZONE_HEAD)
					HU.remove_overlay(MUTATIONS_LAYER)
					var/mutable_appearance/song_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "song", -MUTATIONS_LAYER)
					HU.overlays_standing[MUTATIONS_LAYER] = song_overlay
					HU.apply_overlay(MUTATIONS_LAYER)
					spawn(20)
						if(HU)
							HU.remove_overlay(MUTATIONS_LAYER)
	*/


/datum/discipline/temporis
	name = "Temporis"
	desc = "Temporis is a Discipline unique to the True Brujah. Supposedly a refinement of Celerity, Temporis grants the Cainite the ability to manipulate the flow of time itself."
	icon_state = "temporis"
	/*
	cost = 1
	ranged = TRUE
	delay = 50
	violates_masquerade = FALSE
	activate_sound = 'code/modules/wod13/sounds/temporis.ogg'
	clan_restricted = TRUE
	dead_restricted = FALSE
	var/current_cycle = 0
	var/datum/component/temporis_target


#define TEMPORIS_ATTACK_SPEED_MODIFIER 0.25

/obj/effect/temporis
	name = "Za Warudo"
	desc = "..."
	anchored = 1

/obj/effect/temporis/Initialize()
	. = ..()
	spawn(5)
		qdel(src)


/mob/living/carbon/human/Move(atom/newloc, direct, glide_size_override)
	..()
	if(temporis_visual)
		var/obj/effect/temporis/T = new(loc)
		T.name = name
		T.appearance = appearance
		T.dir = dir
		animate(T, pixel_x = rand(-32,32), pixel_y = rand(-32,32), alpha = 255, time = 10)
		if(CheckEyewitness(src, src, 7, FALSE))
			AdjustMasquerade(-1)
	else if(temporis_blur)
		var/obj/effect/temporis/T = new(loc)
		T.name = name
		T.appearance = appearance
		T.dir = dir
		animate(T, pixel_x = rand(-32,32), pixel_y = rand(-32,32), alpha = 155, time = 5)
		if(CheckEyewitness(src, src, 7, FALSE))
			AdjustMasquerade(-1)

/datum/discipline/temporis/activate(mob/living/target, mob/living/carbon/human/owner)
	. = ..()
	if (owner.celerity_visual) //no using two time powers at once
		to_chat(owner, "<span class='userdanger'>You try to manipulate your temporal field, but Celerity causes it to slip out of your grasp!</span>")
		owner.emote("scream")
		spawn(3 SECONDS)
			owner.gib()
		return
	switch(level_casting)
		if(1)
			to_chat(owner, "<b>[SScity_time.timeofnight]</b>")
			owner.adjust_blood_points(1)
		if(2)
			target.AddComponent(/datum/component/dejavu, rewinds = 4, interval = 2 SECONDS)
		if(3)
			to_chat(target, "<span class='userdanger'><b>Slow down.</b></span>")
			target.add_movespeed_modifier(/datum/movespeed_modifier/temporis)
			spawn(10 SECONDS)
				if(target)
					target.remove_movespeed_modifier(/datum/movespeed_modifier/temporis)
		if(4)
			to_chat(owner, "<b>Use the second Temporis button at the bottom of the screen to cast this level of Temporis.</b>")
			owner.adjust_blood_points(1)
		if(5)
			to_chat(owner, "<b>Use the third Temporis button at the bottom of the screen to cast this level of Temporis.</b>")
			owner.adjust_blood_points(1)
	*/
