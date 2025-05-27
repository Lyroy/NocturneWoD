/datum/icon_generator/

	var/mob/owner

	var/hair_style
	var/beard_style
	var/hair_color

	var/gender_suffix
	var/body_type_prefix
	var/skin_tone
	var/race = "human"

	var/list/gear_icons = list(
		"clothes" = list("emo","black","red","gothic","rich","janitor","graveyard"),
		"shoes" = list("shoes","jackboots","sneakers"),
		"hands" = list("leather","work","latex"),
		"belt" = list(),
		"jacket" = list("fancy_red_jacket","fancy_gray_jacket","coat1","coat2","jacket1","jacket2","trench1","trench2"),
		"eyes" = list("yellow","sun"),
		"face" = list(), //Facial covers covers facial hair, but not eyes/eye cover
		"mask" = list(), //Masks cover facial hair and eyes/eye cover
		"hat" = list(), //hats don't cover hair. This is just to make things simpler and not additonally run lists against lists to exclude hair coverage.
		"helmet" = list(), //helmets cover hair. This is an abstact to determine icon layering, not actual armor, that is decided later.
		)

	var/hair_covered = 0
	var/beard_covered = 0
	var/eyes_covered = 0
	var/eye_cover_covered = 0

/datum/icon_generator/New(mob/new_owner)
	. = ..()
	if(!new_owner) return

	owner = new_owner

/datum/icon_generator/proc/check_coverage()

	var/list/list_to_check = list()
	list_to_check = gear_icons["eyes"]
	if(list_to_check.len != 0)
		eyes_covered = 1
	list_to_check = gear_icons["face"]
	if(list_to_check.len != 0)
		beard_covered = 1
	list_to_check = gear_icons["mask"]
	if(list_to_check.len != 0)
		eye_cover_covered = 1
		eyes_covered = 1
		beard_covered = 1
	list_to_check = gear_icons["helmet"]
	if(list_to_check.len != 0)
		hair_covered = 1


/datum/icon_generator/proc/generate_icon()
	owner.overlays.Cut()
	check_coverage()
	var/datum/sprite_accessory/S
	var/image/finished_image = new(src)
	var/mutable_appearance/body_icon = new(src)
	finished_image.appearance = owner.appearance
	if(!skin_tone)
		skin_tone = random_skin_tone()
	if(race == "vampire")
		skin_tone = get_vamp_skin_color(skin_tone)
	var/skin_tone_hex = "#[skintone2hex(skin_tone)]"

	if(!body_type_prefix)
		body_type_prefix = pick(prob(70);"",
		prob(15);"f",
		prob(15);"s"
		)

	if(!gender_suffix)
		gender_suffix = pick("_m","_f")

	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_head[gender_suffix]"),layer = 3.98)
	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_chest[gender_suffix]"),layer = 3.98)
	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_r_hand"),layer = 3.98)
	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_r_arm"),layer = 3.98)
	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_l_hand"),layer = 3.98)
	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_l_arm"),layer = 3.98)
	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_r_leg"),layer = 3.98)
	body_icon.overlays += image(icon = icon(icon = 'icons/mob/human_parts_greyscale.dmi', icon_state = "[body_type_prefix]human_l_leg"),layer = 3.98)
	body_icon.color = skin_tone_hex

	finished_image.overlays += body_icon

	if(!eyes_covered)
		var/mutable_appearance/eyes = new(src)
		eyes.overlays += image(icon = icon(icon = 'icons/mob/human_face.dmi', icon_state = "eyes"), layer = 3.981)
		eyes.color = pick("#191099","#0d6b05","#7a3802")
		finished_image.overlays += eyes

	if(!hair_style && !beard_style)
		if(gender_suffix == "_m")
			if(hair_covered == 0) hair_style = pick(GLOB.hairstyles_male_list)
			if(beard_covered == 0) beard_style = pick(GLOB.facial_hairstyles_male_list)
		if(gender_suffix == "_f")
			if(hair_covered == 0) hair_style = pick(GLOB.hairstyles_female_list)
	if(!hair_color)
		hair_color = "#[random_color()]"
	if(hair_style && !hair_covered)
		S = GLOB.hairstyles_list[hair_style]
		if(S)
			var/mutable_appearance/hair = new(src)
			hair.overlays += image(icon = icon(icon = S.icon,icon_state = S.icon_state),layer = 3.981)
			hair.color = hair_color
			finished_image.overlays += hair
	if(beard_style && !beard_covered)
		S = GLOB.facial_hairstyles_list[beard_style]
		if(S)
			var/mutable_appearance/beard = new()
			beard.overlays += image(icon = icon(icon = S.icon,icon_state = S.icon_state),layer = 3.981)
			beard.color = hair_color
			finished_image.overlays += beard

	var/list/list_to_check = list()
	var/icon_file
	if(body_type_prefix == "s")
		if(gender_suffix == "_m")
			icon_file = 'code/modules/wod13/worn_slim_m.dmi'
		if(gender_suffix == "_f")
			icon_file = 'code/modules/wod13/worn_slim_f.dmi'
	if(body_type_prefix == "f")
		icon_file = 'code/modules/wod13/worn_fat.dmi'
	if(!icon_file) icon_file = 'code/modules/wod13/worn.dmi'

	list_to_check = gear_icons["clothes"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.99)
		finished_image.overlays += clothing
	list_to_check = gear_icons["shoes"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.991)
		finished_image.overlays += clothing
	list_to_check = gear_icons["hands"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.991)
		finished_image.overlays += clothing
	list_to_check = gear_icons["belt"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.991)
		finished_image.overlays += clothing
	list_to_check = gear_icons["jacket"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.992)
		finished_image.overlays += clothing
	list_to_check = gear_icons["eyes"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.992)
		finished_image.overlays += clothing
	list_to_check = gear_icons["face"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.992)
		finished_image.overlays += clothing
	list_to_check = gear_icons["mask"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.992)
		finished_image.overlays += clothing
	list_to_check = gear_icons["hat"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.993)
		finished_image.overlays += clothing
	list_to_check = gear_icons["helmet"]
	if(list_to_check.len != 0)
		var/mutable_appearance/clothing = new(src)
		var/picked_state = pick(list_to_check)
		clothing.overlays += image(icon = icon(icon = icon_file, icon_state = picked_state),layer = 3.994)
		finished_image.overlays += clothing

	owner.appearance = finished_image.appearance

/datum/combat_ai/

	var/mob/living/owner
	var/loop_terminator = 0

	var/movement_time = 5 // This is tied to the movement proc and animation, essentially the time it takes the AI to take a full step.
	var/mob_heartbeat = 5 // In most cases, this should be sinced to movement_time, however just in case: When the Ai is not moving or otherwise making decisions, it waits this ammount between loops.

	var/armor = 0 // Armor reduces incoming damage to a minimum of 1. It can also shatter and otherwise be removed, which is a one way deal.
	var/poise = 10 // Poise drains with parries and at double the ammount of incoming damage.
	var/health = 10 // This is the one that kills the mob :P

	var/turf/anchor_turf
	var/mob/living/target_player

	/*Attack Cadence Format is: number for animation time, letter for attack type, optional number as the so called "attack factor" which does different things for different attacks.
	Attack types:
	n - Normal;
	a - AOE - hits around, factor 1 also applies knockback;
	c - Cone - hits 3 grids in front based on dir, supports diagonals too, factor 1 also applies knockback; Wind up to animation times will always be at least 3 (so total animation time of anyhting less than 4 will be normalized to at least 4), though any unblockable attacks should come with a gratious indiator anyway.
	p - Power - special animation, typically unblockable. Factor 1 makes it blockable with a narrower window, sucesfull block immediatly breaks poise
	t - Thrust - Moves mob forward, knocking hit mobs out of the way. Stops at walls and obstacles.
	f - Fast - omits windup. Good for combos.
	g - Grab - Unblockable, if hits players immobilizes them and plays a "grab animation" depending on number subtype which includes multiple unblockable hits. Can be interrupted by incoming damage from another player controlled via the grab_durability var, sucessful interrupt breaks poise
	*/
	var/list/attack_cadence = list(list("5n","10n","15n"))

	var/attacking_flag = 0
	var/attack_delay = 10 //This is a pause AFTER all the attacks in a single cadence, ie extra time between attack decisons. Individual attack loops are decided by cadence
	var/grab_durability = 1 // Ammount of damage that needs to be dealt for the mob to break its grab
	var/in_grab = 0

	var/return_override
	var/return_distance = 14 // Ammount from anchor turf the NPC "protects", meaning they will disengage and return to their anchor when their target is this ammoutn away from it.

/datum/combat_ai/New(mob/owner_mob)
	. = ..()
	if(!owner_mob) return
	owner = owner_mob
	anchor_turf = get_turf(owner)
	INVOKE_ASYNC(src,PROC_REF(ai_loop))

/datum/combat_ai/proc/combat_stun()
	loop_terminator = 1
	in_grab = 0
	sleep(25)
	if(health > 0) INVOKE_ASYNC(src, PROC_REF(damage_animation),owner,"poise_restore")
	sleep(5)
	if(health > 0)
		loop_terminator = 0
		grab_durability = initial(grab_durability)
		poise = initial(poise)
		INVOKE_ASYNC(src, PROC_REF(ai_loop))

/datum/combat_ai/proc/attack_animation(mob/attacking_mob,turf/target,type,time,factor) // I strongly recommend this is async invoked, just saying :P
	if(!type || !time) return
	//Universal refs
	var/starting_x = attacking_mob.pixel_x
	var/starting_y = attacking_mob.pixel_y
	var/turf/current_turf = get_turf(attacking_mob)
	//timers
	var/wind_up = ceil(time / 2)
	var/attack = floor(time / 2)
	//blinking/indicator values
	var/color_value = attacking_mob.color
	var/blink_value = color_value
	var/matrix/M = new()
	var/matrix/N = new()
	var/matrix/O = new()
	var/fade_in
	if(wind_up == 1)
		fade_in = 1
	else
		fade_in = wind_up - 1
	var/flash
	if(fade_in == 1)
		flash = 1
	else
		flash = 2
	var/fade_out
	if(attack == 1)
		fade_out = 1
	else
		fade_out = attack - 1
	M.Scale(0.01)
	N.Scale(1)
	O.Scale(2.5)
	var/mutable_appearance/indicator = new()
	indicator.alpha = 0
	indicator.layer = ABOVE_MOB_LAYER
	indicator.pixel_y = 28
	switch(type) // Attack Indicator/blining values segment. Actual animations trigger later
		if("n")
			blink_value = "#ffd0be"
		if("a")
			indicator.overlays += icon(icon = 'icons/effects/combat.dmi',icon_state = "circle")
			indicator.transform = M
			blink_value = "#ff8800"
			indicator.color = "#d38817"
			attacking_mob.vis_contents += indicator.overlays
			animate(indicator,time = fade_in,alpha = 255, transform = N, pixel_y = 32)
			animate(time = flash, color = blink_value)
			animate(time = fade_out, alpha = 0, transform = O)
		if("c")
			indicator.overlays += icon(icon = 'icons/effects/combat.dmi',icon_state = "cone")
			M.Turn(factor)
			indicator.transform = M
			blink_value = "#ff8800"
			indicator.color = "#d38817"
			attacking_mob.vis_contents += indicator.overlays
			animate(indicator,time = fade_in,alpha = 255, transform = N, pixel_y = 32)
			animate(time = flash, color = blink_value)
			animate(time = fade_out, alpha = 0, transform = O)
		if("p","g")
			indicator.overlays += icon(icon = 'icons/effects/combat.dmi',icon_state = "cross")
			indicator.transform = M
			blink_value = "#ff1c1c"
			indicator.color = "#990000"
			attacking_mob.vis_contents += indicator.overlays
			animate(indicator,time = fade_in,alpha = 255, transform = N, pixel_y = 32)
			animate(time = flash, color = blink_value)
			animate(time = fade_out, alpha = 0, transform = O)
		if("t")
			indicator.overlays += icon(icon = 'icons/effects/combat.dmi',icon_state = "arrow")
			M.Turn(factor)
			indicator.transform = M
			blink_value = "#d15106"
			indicator.color = "#d66727"
			attacking_mob.vis_contents += indicator.overlays
			animate(indicator,time = fade_in,alpha = 255, transform = N, pixel_y = 32)
			animate(time = flash, color = blink_value)
			animate(time = fade_out, alpha = 0, transform = O)
		if("f")
			indicator.overlays += icon(icon = 'icons/effects/combat.dmi',icon_state = "triangle")
			indicator.transform = M
			blink_value = "#1e5a0c"
			indicator.color = "#258308"
			attacking_mob.vis_contents += indicator.overlays
			animate(indicator,time = fade_in,alpha = 255, transform = N, pixel_y = 32)
			animate(time = flash, color = blink_value)
			animate(time = fade_out, alpha = 0, transform = O)
	switch(type) // Attack animations go here
		if("n") // Normal attack - mob pulls back, then pushes forward. Strike counted at apex of pushing animation.
			var/pull_x = attacking_mob.pixel_x
			var/pull_y = attacking_mob.pixel_y
			var/push_x = 0
			var/push_y = 0
			switch(get_dir(current_turf,target))
				if(NORTH)
					attacking_mob.dir = NORTH
					pull_y -= 16
					push_y = 16
				if(NORTHEAST)
					attacking_mob.dir = EAST
					pull_y -= 8
					push_y = 8
					pull_x -= 8
					push_x = 8
				if(EAST)
					attacking_mob.dir = EAST
					pull_x -= 16
					push_x = 16
				if(SOUTHEAST)
					attacking_mob.dir = EAST
					pull_x -= 8
					push_x = 8
					pull_y += 8
					push_y = -8
				if(SOUTH)
					attacking_mob.dir = SOUTH
					pull_y += 16
					push_y = -16
				if(SOUTHWEST)
					attacking_mob.dir = WEST
					pull_y += 8
					push_y = -8
					pull_x += 8
					push_x = -8
				if(WEST)
					attacking_mob.dir = WEST
					pull_x += 16
					push_x = -16
				if(NORTHWEST)
					attacking_mob.dir = WEST
					pull_x += 8
					push_x = -8
					pull_y -= 8
					push_y = 8
			animate(attacking_mob,time = wind_up, pixel_x = pull_x, pixel_y = pull_y)
			animate(time = attack, pixel_x = push_x, pixel_y = push_y)

		if("a") // AoE attack - mob shakes slightly, then shakes more as the attack is about to be unleashed.
			var/current_frame = 0
			while(current_frame < wind_up)
				animate(attacking_mob, time = 1, pixel_x = rand(-3,3), pixel_y = rand(-3,3))
				sleep(1)
				current_frame += 1
			current_frame = 0
			while(current_frame < attack)
				animate(attacking_mob, time = 1, pixel_x = rand(-6,6), pixel_y = rand(-6,6))
				sleep(1)
				current_frame += 1

		if("c") // Cone AoE, this will normalize wind up to 3 if trigerred with less. Acts similar to normal attack, but does a little loop depending on orientation of attack
			if(wind_up < 3) wind_up = 3 // This is a somewhat hacky way of making sure the animation does not skip, but this assumes that the end user knows to respect minimum timers. *coughs*
			attack = (time - (3 * floor(wind_up / 3))) // This is to ensure that all of the input time gets processed as an animation, since this is cruical to damage processing etc
			var/start_x = 0
			var/start_y = 0
			var/mid_x = 0
			var/mid_y = 0
			var/fin_x = 0
			var/fin_y = 0
			var/push_x = 0
			var/push_y = 0
			switch(get_dir(current_turf,target))
				if(NORTH)
					attacking_mob.dir = NORTH
					start_x = 6
					start_y = -10
					mid_x = 0
					mid_y = -16
					fin_x = -6
					fin_y = -10
					push_y = 16
				if(SOUTH)
					attacking_mob.dir = SOUTH
					start_x = 6
					start_y = 10
					mid_x = 0
					mid_y = 16
					fin_x = -6
					fin_y = 10
					push_y = -16
				if(EAST)
					attacking_mob.dir = EAST
					start_x = -10
					start_y = 6
					mid_x = -16
					mid_y = 0
					fin_x = -10
					fin_y = -6
					push_x = 16
				if(WEST)
					attacking_mob.dir = WEST
					start_x = 10
					start_y = 6
					mid_x = 16
					mid_y = 0
					fin_x = 10
					fin_y = -6
					push_x = -16
				if(NORTHEAST)
					attacking_mob.dir = EAST
					start_x = -12
					start_y = 0
					mid_x = -12
					mid_y = -12
					fin_x =  0
					fin_y = -12
					push_x = 8
					push_y = 8
				if(NORTHWEST)
					attacking_mob.dir = WEST
					start_x = 12
					start_y = 0
					mid_x = 12
					mid_y = -12
					fin_x =  0
					fin_y = -12
					push_x = -8
					push_y = 8
				if(SOUTHEAST)
					attacking_mob.dir = EAST
					start_x = -12
					start_y = 0
					mid_x = -12
					mid_y = 12
					fin_x =  0
					fin_y = 12
					push_x = 8
					push_y = -8
				if(SOUTHWEST)
					attacking_mob.dir = WEST
					start_x = -12
					start_y = 0
					mid_x = -12
					mid_y = 12
					fin_x =  0
					fin_y = 12
					push_x = -8
					push_y = -8
			animate(attacking_mob, time = floor(wind_up / 3),pixel_x = start_x, pixel_y = start_y)
			animate(time = floor(wind_up / 3),pixel_x = mid_x, pixel_y = mid_y)
			animate(time = floor(wind_up / 3),pixel_x = fin_x, pixel_y = fin_y)
			animate(time = attack,pixel_x = push_x, pixel_y = push_y)

		if("p","g") // power attacks and grabs are essentially the same mechanic - in most cases you need to move out of the way or you get hurt, so they share a warning animation. This can be individualized later obviously
			var/push_x = 0
			var/push_y = 0
			switch(get_dir(current_turf,target))
				if(NORTH)
					push_y = 16
				if(SOUTH)
					push_y = -16
				if(EAST)
					push_x = 16
				if(WEST)
					push_x = -16
				if(NORTHEAST)
					push_x = 8
					push_y = 8
				if(NORTHWEST)
					push_x = -8
					push_y = 8
				if(SOUTHEAST)
					push_x = 8
					push_y = -8
				if(SOUTHWEST)
					push_x = -8
					push_y = -8
			var/obj/icon_obj = new()
			icon_obj.mouse_opacity = 1
			icon_obj.appearance = attacking_mob.appearance
			icon_obj.layer = EFFECTS_LAYER
			icon_obj.dir = attacking_mob.dir
			var/matrix/P = new
			P.Scale(3)
			target.vis_contents += icon_obj
			animate(icon_obj, time = wind_up, color = blink_value, transform = M, alpha = 0)
			sleep(wind_up)
			target.vis_contents -= icon_obj
			qdel(icon_obj)
			animate(attacking_mob, time = attack,pixel_x = push_x, pixel_y = push_y)

		if("t")
			var/pull_x = attacking_mob.pixel_x
			var/pull_y = attacking_mob.pixel_y
			var/push_x = attacking_mob.pixel_x
			var/push_y = attacking_mob.pixel_y
			switch(get_dir(current_turf,target))
				if(NORTH)
					attacking_mob.dir = NORTH
					pull_y -= 24
					push_y = 24
				if(NORTHEAST)
					attacking_mob.dir = EAST
					pull_y -= 12
					push_y = 12
					pull_x -= 12
					push_x = 12
				if(EAST)
					attacking_mob.dir = EAST
					pull_x -= 24
					push_x = 24
				if(SOUTHEAST)
					attacking_mob.dir = EAST
					pull_x -= 12
					push_x = 12
					pull_y += 12
					push_y = -12
				if(SOUTH)
					attacking_mob.dir = SOUTH
					pull_y += 24
					push_y = -24
				if(SOUTHWEST)
					attacking_mob.dir = WEST
					pull_y += 12
					push_y = -12
					pull_x += 12
					push_x = -12
				if(WEST)
					attacking_mob.dir = WEST
					pull_x += 24
					push_x = -24
				if(NORTHWEST)
					attacking_mob.dir = WEST
					pull_x += 12
					push_x = -12
					pull_y -= 12
					push_y = 12
			animate(attacking_mob,time = wind_up, pixel_x = pull_x, pixel_y = pull_y)
			animate(time = attack, pixel_x = push_x, pixel_y = push_y)
		if("f")
			var/push_x = 0
			var/push_y = 0
			switch(get_dir(current_turf,target))
				if(NORTH)
					push_y = 16
				if(SOUTH)
					push_y = -16
				if(EAST)
					push_x = 16
				if(WEST)
					push_x = -16
				if(NORTHEAST)
					push_x = 8
					push_y = 8
				if(NORTHWEST)
					push_x = -8
					push_y = 8
				if(SOUTHEAST)
					push_x = 8
					push_y = -8
				if(SOUTHWEST)
					push_x = -8
					push_y = -8
			animate(attacking_mob,time = attack, pixel_x = push_x, pixel_y = push_y)

	animate(attacking_mob,time = attack, pixel_x = starting_x, pixel_y = starting_y)
	return

/datum/combat_ai/proc/damage_animation(mob/target,type)
	switch(type)
		if(null)
			return
		if("poise_restore")
			var/obj/icon_obj = new()
			icon_obj.mouse_opacity = 1
			icon_obj.appearance = target.appearance
			icon_obj.dir = target.dir
			icon_obj.layer = EFFECTS_LAYER
			icon_obj.alpha = 0
			var/matrix/M = new
			M.Scale(3)
			icon_obj.transform = M
			var/matrix/N = new
			N.Scale(1)
			animate(icon_obj, time = 5, alpha = 255, transform = N)
			target.vis_contents += icon_obj
			sleep(6)
			target.vis_contents -= icon_obj
		if("poise_break")
			var/obj/icon_obj = new()
			icon_obj.mouse_opacity = 1
			icon_obj.appearance = target.appearance
			icon_obj.layer = EFFECTS_LAYER
			icon_obj.dir = target.dir
			var/matrix/M = new
			M.Scale(3)
			animate(icon_obj, time = 5, alpha = 0, transform = M)
			target.vis_contents += icon_obj
			sleep(6)
			target.vis_contents -= icon_obj
		if("poise_hit")
			var/obj/icon_obj = new()
			icon_obj.mouse_opacity = 1
			icon_obj.appearance = target.appearance
			icon_obj.layer = EFFECTS_LAYER
			var/matrix/M = new
			M.Scale(1.2 + (0.05 * ((initial(poise) + 1) - poise)))
			animate(icon_obj, time = 3, alpha = 0, transform = M)
			target.vis_contents += icon_obj
			sleep(4)
			target.vis_contents -= icon_obj
		if("dam_hit")
			var/starting_x = target.pixel_x
			var/starting_y = target.pixel_y
			var/displacement_x = starting_x + pick(-3,3)
			var/displacement_y = starting_y + pick(-3,3)
			animate(target, time = 1, pixel_x = displacement_x, pixel_y = displacement_y)
			animate(time = 1, pixel_x = starting_x, pixel_y = starting_y)

/datum/combat_ai/proc/die()
	loop_terminator = 1
	var/matrix/M = new
	M.Turn(pick(-90,90))
	var/displacement_x = owner.pixel_x + rand(-10,10)
	var/displacement_y = owner.pixel_y + rand(-10,10)
	animate(owner, time = 4, pixel_x = displacement_x, pixel_y = displacement_y, transform = M, easing = QUAD_EASING|EASE_IN)
	owner.density = 0

/datum/combat_ai/proc/process_damage(damage_number,damage_type)
	if(!damage_number) return
	if(health == 0) return
	var/damage_to_deal = damage_number - armor
	return_override = 0
	if(in_grab == 1)
		grab_durability -= damage_to_deal
		if(grab_durability <= 0)
			poise = 0
			in_grab = 0
			INVOKE_ASYNC(src,PROC_REF(damage_animation),owner,"poise_break")
			INVOKE_ASYNC(src,PROC_REF(process_knockback),owner,1)
			INVOKE_ASYNC(src,PROC_REF(combat_stun))
			return

	if(damage_type == "poise")
		if(poise >= 0)
			poise -= damage_to_deal
			if(poise <= 0)
				poise = 0
				INVOKE_ASYNC(src,PROC_REF(damage_animation),owner,"poise_break")
				INVOKE_ASYNC(src,PROC_REF(process_knockback),owner,1)
				INVOKE_ASYNC(src,PROC_REF(combat_stun))
				return
			else
				INVOKE_ASYNC(src,PROC_REF(damage_animation),owner,"poise_hit")
		return
	if(damage_type == "health")
		if(health > 0)
			var/new_health = health - damage_number
			if(new_health <= 0)
				health = 0
				die()
				return
			else
				health -= damage_number
				INVOKE_ASYNC(src,PROC_REF(damage_animation),owner,"dam_hit")
				return
	if(damage_type == BURN)
		INVOKE_ASYNC(src, PROC_REF(process_damage),(damage_number),"health")
		return
	if(poise > 0) INVOKE_ASYNC(src, PROC_REF(process_damage),(damage_number * 2),"poise")
	INVOKE_ASYNC(src, PROC_REF(process_damage),(damage_number),"health")

/datum/combat_ai/proc/list_turfs_in_line(turf/origin_turf,turf/target_turf)
	var/list/turf_list = list()
	var/turf/current_turf = origin_turf
	while(current_turf != target_turf)
		current_turf = get_step_towards(origin_turf,target_turf)
		turf_list += current_turf
	return turf_list

/datum/combat_ai/proc/animate_knockback(mob/target_mob,turf/target_turf,collision = 0,distance)
	var/turf/turf_to_target = target_turf
	var/mob/mob_to_animate = target_mob
	var/turf/mob_turf = get_turf(mob_to_animate)
	mob_to_animate.anchored = 1
	var/original_animate_movement = mob_to_animate.animate_movement
	mob_to_animate.animate_movement = NO_STEPS
	if(distance)
		var/origin_px = mob_to_animate.pixel_x
		var/origin_py = mob_to_animate.pixel_y
		var/displacement_x = (mob_turf.x - turf_to_target.x) * 32
		var/displacement_y = (mob_turf.y - turf_to_target.y) * 32
		mob_to_animate.forceMove(target_turf)
		mob_to_animate.pixel_x += displacement_x
		mob_to_animate.pixel_y += displacement_y
		if(collision == 1)
			if(displacement_x > 0)
				displacement_x -= 32
			else
				displacement_x += 32
			if(displacement_y > 0)
				displacement_y -= 32
			else
				displacement_y += 32
		animate(mob_to_animate,time = distance * 2, pixel_x = origin_px, pixel_y = origin_py, easing = SINE_EASING|EASE_OUT)
		sleep(distance * 2)
	if(collision == 1)
		if(istype(mob_to_animate,/mob/living/))
			var/mob/living/living_mob = mob_to_animate
			if(!istype(living_mob,/mob/living/npc))
				damage_animation(living_mob)
			living_mob.apply_damage((5 * distance), BRUTE)
	mob_to_animate.anchored = 0
	mob_to_animate.animate_movement = original_animate_movement

/datum/combat_ai/proc/process_thrust(list/turfs_to_attack,thrust_power)
	for (var/turf/turf_to_hit in turfs_to_attack)
		sleep(2)
		for(var/mob/living/attacked_mob in turf_to_hit)
			if(istype(attacked_mob,/mob/living/carbon/))
				var/mob/living/carbon/attacked_carbon_mob = attacked_mob
				if(world.time > attacked_carbon_mob.blocking_timestamp + 5)
					attacked_carbon_mob.apply_damage(rand(owner.melee_damage_lower,owner.melee_damage_upper))
				else
					attacked_carbon_mob.apply_damage((rand(owner.melee_damage_lower,owner.melee_damage_upper)) / 2)
				INVOKE_ASYNC(src, PROC_REF(damage_animation),attacked_carbon_mob)
				INVOKE_ASYNC(src, PROC_REF(process_knockback),attacked_carbon_mob,thrust_power)
				if(istype(attacked_mob,/mob/living/carbon/human))
					var/mob/living/carbon/human/attacked_human_mob = attacked_mob
					if(attacked_human_mob.blocking == TRUE) attacked_human_mob.SwitchBlocking()
				if(attacked_carbon_mob.blocking == TRUE) attacked_carbon_mob.blocking = FALSE


/datum/combat_ai/proc/animate_thrust(mob/target_mob,turf/target_turf)
	var/mob/mob_to_animate = target_mob
	var/turf/mob_turf = get_turf(target_mob)
	var/distance_to_animate = get_dist(mob_turf,target_turf)
	var/origin_px = mob_to_animate.pixel_x
	var/origin_py = mob_to_animate.pixel_y
	var/displacement_x = (mob_turf.x - target_turf.x) * 32
	var/displacement_y = (mob_turf.y - target_turf.y) * 32
	mob_to_animate.forceMove(target_turf)
	mob_to_animate.pixel_x += displacement_x
	mob_to_animate.pixel_y += displacement_y
	animate(mob_to_animate,time = distance_to_animate * 2, pixel_x = origin_px, pixel_y = origin_py, easing = SINE_EASING|EASE_IN)

/datum/combat_ai/proc/process_knockback(mob/target_mob,distance)
	var/turf/mob_turf = get_turf(target_mob)
	var/turf/target_turf
	switch(target_mob.dir)
		if(NORTH)
			target_turf = locate(mob_turf.x,(mob_turf.y - distance),mob_turf.y)
		if(SOUTH)
			target_turf = locate(mob_turf.x,(mob_turf.y + distance),mob_turf.y)
		if(EAST)
			target_turf = locate((mob_turf.x - distance),mob_turf.y,mob_turf.y)
		if(WEST)
			target_turf = locate((mob_turf.x + distance),mob_turf.y,mob_turf.y)
		//I dont think diagonals are ever needed but just in case :P
		if(NORTHEAST)
			target_turf = locate((mob_turf.x - distance),(mob_turf.y - distance),mob_turf.y)
		if(NORTHWEST)
			target_turf = locate((mob_turf.x + distance),(mob_turf.y - distance),mob_turf.y)
		if(SOUTHEAST)
			target_turf = locate((mob_turf.x - distance),(mob_turf.y + distance),mob_turf.y)
		if(SOUTHWEST)
			target_turf = locate((mob_turf.x + distance),(mob_turf.y + distance),mob_turf.y)
	var/list/crossed_turfs = list_turfs_in_line(mob_turf, target_turf)
	var/distance_to_animate = 0
	var/collision = 0
	var/turf/ending_turf = mob_turf
	for(var/turf/turf_to_test in crossed_turfs)
		if(istype(turf_to_test,/turf/closed/))
			collision = 1
			break
		for(var/obj/obj_to_test in turf_to_test)
			if(obj_to_test && obj_to_test.density == 1)
				collision = 1
				break
		distance_to_animate += 1
		ending_turf = turf_to_test
	animate_knockback(target_mob,ending_turf,collision,distance_to_animate)

/datum/combat_ai/proc/process_grab(mob/target_mob,grab_type)
	loop_terminator = 1
	var/mob/living/carbon/grabbed_mob = target_mob
	switch(grab_type)
		if(1)
			target_mob.anchored = 1
			owner.anchored = 1
			var/turf/owner_turf = get_turf(owner)
			var/turf/target_turf = get_turf(target_mob)
			var/owner_px = owner.pixel_x
			var/owner_py = owner.pixel_y
			var/target_px = grabbed_mob.pixel_x
			var/target_py = grabbed_mob.pixel_y
			switch(get_dir(owner_turf,target_turf))
				if(NORTH)
					animate(owner,time = 2,pixel_y = 12)
					animate(grabbed_mob,time = 2,pixel_y = -12)
				if(SOUTH)
					animate(owner,time = 2,pixel_y = -12)
					animate(grabbed_mob,time = 2,pixel_y = 12)
				if(EAST)
					animate(owner,time = 2,pixel_x = 12)
					animate(grabbed_mob,time = 2,pixel_x = -12)
				if(WEST)
					animate(owner,time = 2,pixel_x = -12)
					animate(grabbed_mob,time = 2,pixel_x = 12)
				if(NORTHEAST)
					animate(owner,time = 2,pixel_y = 12, pixel_x = 12)
					animate(grabbed_mob,time = 2,pixel_y = -12, pixel_x = -12)
				if(NORTHWEST)
					animate(owner,time = 2,pixel_y = 12, pixel_x = -12)
					animate(grabbed_mob,time = 2,pixel_y = -12, pixel_x = 12)
				if(SOUTHEAST)
					animate(owner,time = 2,pixel_y = -12, pixel_x = 12)
					animate(grabbed_mob,time = 2,pixel_y = 12, pixel_x = -12)
				if(SOUTHWEST)
					animate(owner,time = 2,pixel_y = -12, pixel_x = -12)
					animate(grabbed_mob,time = 2,pixel_y = 12, pixel_x = 12)
			sleep(2)
			var/hits_animated = 0
			while(in_grab == 1 && (hits_animated < 3))
				switch(get_dir(owner_turf,target_turf))
					if(NORTH)
						animate(owner,time = 3,pixel_y = -12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_y = 12, easing = SINE_EASING|EASE_IN)
					if(SOUTH)
						animate(owner,time = 3,pixel_y = 12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_y = -12, easing = SINE_EASING|EASE_IN)
					if(EAST)
						animate(owner,time = 3,pixel_x = -12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_x = 12, easing = SINE_EASING|EASE_IN)
					if(WEST)
						animate(owner,time = 3,pixel_x = 12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_x = -12, easing = SINE_EASING|EASE_IN)
					if(NORTHEAST)
						animate(owner,time = 3,pixel_y = -12,pixel_x = -12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_y = 12,pixel_x = 12, easing = SINE_EASING|EASE_IN)
					if(NORTHWEST)
						animate(owner,time = 3,pixel_y = -12, pixel_x = 12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_y = 12, pixel_x = -12, easing = SINE_EASING|EASE_IN)
					if(SOUTHEAST)
						animate(owner,time = 3,pixel_y = 12,pixel_x = -12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_y = -12, pixel_x = 12, easing = SINE_EASING|EASE_IN)
					if(SOUTHWEST)
						animate(owner,time = 3,pixel_y = 12, pixel_x = 12, easing = SINE_EASING|EASE_IN)
						animate(time = 3,pixel_y = -12, pixel_x = -12, easing = SINE_EASING|EASE_IN)
				sleep(6)
				if(in_grab == 1)
					grabbed_mob.apply_damage(rand(owner.melee_damage_lower / 2,owner.melee_damage_upper / 2))
				hits_animated += 1
			animate(owner,time = 2,pixel_x = owner_px, pixel_y = owner_py)
			animate(grabbed_mob,time = 2,pixel_x = target_px, pixel_y = target_py)
			grabbed_mob.anchored = 0
			if(loop_terminator == 1 && health > 0 && poise > 0)
				loop_terminator = 0
				INVOKE_ASYNC(src, PROC_REF(ai_loop))


/datum/combat_ai/proc/process_attack(turf/turf_target)
	var/list/attack_list = pick(attack_cadence)
	attacking_flag = 1
	var/current_position = 1
	while(current_position <= attack_list.len)
		if(loop_terminator)
			attack_list = list()
			break

		var/current_line = attack_list[current_position]
		var/number_bits = 0
		var/current_bit = 1
		var/bit_to_test = copytext(current_line,current_bit,current_bit+1)
		while(text2num(bit_to_test) != null)
			number_bits += 1
			current_bit += 1
			bit_to_test = copytext(current_line,current_bit,current_bit+1)
		if(number_bits == 0) return "err_no_bits"
		var/attack_time = text2num(copytext(current_line,1,1 + number_bits))
		var/attack_type = copytext(current_line,number_bits+1,number_bits+2)
		var/attack_factor
		if(length(current_line) > number_bits + 1) attack_factor = copytext(current_line,number_bits+2,0)
		INVOKE_ASYNC(src, PROC_REF(attack_animation),owner,turf_target,attack_type,attack_time,attack_factor)
		sleep(attack_time)

		// Attack types and parrying

		switch(attack_type)
			if("n")
				for(var/mob/living/attacked_mob in turf_target)
					if(istype(attacked_mob,/mob/living/carbon/))
						var/mob/living/carbon/attacked_carbon_mob = attacked_mob
						if(world.time > attacked_carbon_mob.blocking_timestamp + 5)
							attacked_carbon_mob.apply_damage(rand(owner.melee_damage_lower,owner.melee_damage_upper))
							INVOKE_ASYNC(src, PROC_REF(damage_animation),attacked_carbon_mob)
						else
							process_damage(2,"poise")
						if(istype(attacked_mob,/mob/living/carbon/human))
							var/mob/living/carbon/human/attacked_human_mob = attacked_mob
							if(attacked_human_mob.blocking == TRUE) attacked_human_mob.SwitchBlocking()
						if(attacked_carbon_mob.blocking == TRUE) attacked_carbon_mob.blocking = FALSE // This is a failsafe in case the above is not trigerred on player mobs.
			if("a")
				var/list/turfs_attacked = list()
				var/turf/turf_to_add = get_step(owner,NORTHEAST)
				turfs_attacked += turf_to_add
				turf_to_add = get_step(owner,EAST)
				turfs_attacked += turf_to_add
				turf_to_add = get_step(owner,SOUTHEAST)
				turfs_attacked += turf_to_add
				turf_to_add = get_step(owner,SOUTH)
				turfs_attacked += turf_to_add
				turf_to_add = get_step(owner,SOUTHWEST)
				turfs_attacked += turf_to_add
				turf_to_add = get_step(owner,WEST)
				turfs_attacked += turf_to_add
				turf_to_add = get_step(owner,NORTHWEST)
				turfs_attacked += turf_to_add
				turf_to_add = get_step(owner,NORTH)
				turfs_attacked += turf_to_add
				for(var/turf/turf_to_check in turfs_attacked)
					for(var/mob/living/attacked_mob in turf_to_check)
						if(istype(attacked_mob,/mob/living/carbon/))
							var/mob/living/carbon/attacked_carbon_mob = attacked_mob
							INVOKE_ASYNC(src, PROC_REF(damage_animation),attacked_carbon_mob)
							if(world.time > attacked_carbon_mob.blocking_timestamp + 5)
								attacked_carbon_mob.apply_damage(ceil(owner.melee_damage_upper / 3))
								if(attack_factor == 1) INVOKE_ASYNC(src, PROC_REF(process_knockback),attacked_carbon_mob,1)
							else
								attacked_carbon_mob.apply_damage(ceil(owner.melee_damage_upper / 6))
								INVOKE_ASYNC(src, PROC_REF(process_knockback),attacked_carbon_mob,1)
							if(istype(attacked_mob,/mob/living/carbon/human))
								var/mob/living/carbon/human/attacked_human_mob = attacked_mob
								if(attacked_human_mob.blocking == TRUE) attacked_human_mob.SwitchBlocking()
							if(attacked_carbon_mob.blocking == TRUE) attacked_carbon_mob.blocking = FALSE
			if("c")
				var/list/turfs_attacked = list()
				var/turf/own_turf = get_turf(owner)
				var/turf/turf_to_add
				switch(get_dir(own_turf,turf_target))
					if(NORTH)
						turf_to_add = locate(own_turf.x,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x - 1,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x + 1,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
					if(SOUTH)
						turf_to_add = locate(own_turf.x,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x - 1,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x + 1,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
					if(EAST)
						turf_to_add = locate(own_turf.x + 1,own_turf.y, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x + 1,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x + 1,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
					if(WEST)
						turf_to_add = locate(own_turf.x - 1,own_turf.y, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x - 1,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x - 1,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
					if(NORTHEAST)
						turf_to_add = locate(own_turf.x + 1,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x + 1,own_turf.y, own_turf.z)
						turfs_attacked += turf_to_add
					if(NORTHWEST)
						turf_to_add = locate(own_turf.x - 1,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x,own_turf.y + 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x - 1,own_turf.y, own_turf.z)
						turfs_attacked += turf_to_add
					if(SOUTHEAST)
						turf_to_add = locate(own_turf.x + 1,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x + 1,own_turf.y, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
					if(SOUTHWEST)
						turf_to_add = locate(own_turf.x - 1,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x - 1,own_turf.y, own_turf.z)
						turfs_attacked += turf_to_add
						turf_to_add = locate(own_turf.x,own_turf.y - 1, own_turf.z)
						turfs_attacked += turf_to_add
				for(var/turf/turf_to_check in turfs_attacked)
					for(var/mob/living/attacked_mob in turf_to_check)
						if(istype(attacked_mob,/mob/living/carbon/))
							var/mob/living/carbon/attacked_carbon_mob = attacked_mob
							INVOKE_ASYNC(src, PROC_REF(damage_animation),attacked_carbon_mob)
							if(world.time > attacked_carbon_mob.blocking_timestamp + 5)
								attacked_carbon_mob.apply_damage(ceil(owner.melee_damage_upper / 2))
								if(attack_factor == 1) INVOKE_ASYNC(src, PROC_REF(process_knockback),attacked_carbon_mob,1)
							else
								attacked_carbon_mob.apply_damage(ceil(owner.melee_damage_upper / 4))
								INVOKE_ASYNC(src, PROC_REF(process_knockback),attacked_carbon_mob,1)
							if(istype(attacked_mob,/mob/living/carbon/human))
								var/mob/living/carbon/human/attacked_human_mob = attacked_mob
								if(attacked_human_mob.blocking == TRUE) attacked_human_mob.SwitchBlocking()
							if(attacked_carbon_mob.blocking == TRUE) attacked_carbon_mob.blocking = FALSE
			if("p")
				for(var/mob/living/attacked_mob in turf_target)
					if(istype(attacked_mob,/mob/living/carbon/))
						var/mob/living/carbon/attacked_carbon_mob = attacked_mob
						if(world.time > attacked_carbon_mob.blocking_timestamp + 2)
							attacked_carbon_mob.apply_damage(rand(owner.melee_damage_lower * 1.5,owner.melee_damage_upper * 1.5))
							INVOKE_ASYNC(src, PROC_REF(damage_animation),attacked_carbon_mob)
							INVOKE_ASYNC(src, PROC_REF(process_knockback),attacked_carbon_mob,2)
						else
							if(attack_factor == 1)
								process_damage(poise,"poise")
							else
								attacked_carbon_mob.apply_damage(rand(owner.melee_damage_lower,owner.melee_damage_upper))
								INVOKE_ASYNC(src, PROC_REF(damage_animation),attacked_carbon_mob)
								INVOKE_ASYNC(src, PROC_REF(process_knockback),attacked_carbon_mob,1)
						if(istype(attacked_mob,/mob/living/carbon/human))
							var/mob/living/carbon/human/attacked_human_mob = attacked_mob
							if(attacked_human_mob.blocking == TRUE) attacked_human_mob.SwitchBlocking()
						if(attacked_carbon_mob.blocking == TRUE) attacked_carbon_mob.blocking = FALSE
			if("t")
				var/distance_to_thrust = attack_factor
				var/final_turf = get_turf(owner)
				var/list/turfs_to_ping = list()
				var/current_step = 0
				while(current_step < distance_to_thrust)
					var/tested_turf = get_step(final_turf,owner.dir)
					if(istype(tested_turf,/turf/closed/))
						break
					for(var/obj/item/item_to_test in tested_turf)
						if(item_to_test.density == 1)
							break
					final_turf = tested_turf
					turfs_to_ping += tested_turf
					current_step += 1
				if(turfs_to_ping.len > 0)
					INVOKE_ASYNC(src, PROC_REF(animate_thrust),owner,final_turf)
					INVOKE_ASYNC(src, PROC_REF(process_thrust),turfs_to_ping,attack_factor)
			if("g")
				for(var/mob/living/attacked_mob in turf_target)
					if(istype(attacked_mob,/mob/living/carbon/))
						var/mob/living/carbon/attacked_carbon_mob = attacked_mob
						if(attacked_carbon_mob.client)
							INVOKE_ASYNC(src, PROC_REF(process_grab),attacked_carbon_mob,attack_factor)
							break
		if(loop_terminator)
			attack_list = list()
			break
		sleep(floor(attack_time / 2))
		if(loop_terminator)
			attack_list = list()
			break
		current_position += 1
	attacking_flag = 0

/datum/combat_ai/proc/animate_step(turf/target_turf)
	var/turf/owner_turf = get_turf(owner)
	var/current_pixel_x = owner.pixel_x
	var/current_pixel_y = owner.pixel_y
	owner.forceMove(target_turf)
	switch(get_dir(owner_turf,target_turf))
		if(NORTH)
			owner.pixel_y -= 32
			owner.dir = NORTH
		if(SOUTH)
			owner.pixel_y += 32
			owner.dir = SOUTH
		if(EAST)
			owner.pixel_x -= 32
			owner.dir = EAST
		if(WEST)
			owner.pixel_x += 32
			owner.dir = WEST
		if(NORTHEAST)
			owner.pixel_y -= 32
			owner.pixel_x -= 32
			owner.dir = EAST
		if(NORTHWEST)
			owner.pixel_y -= 32
			owner.pixel_x += 32
			owner.dir = WEST
		if(SOUTHEAST)
			owner.pixel_y += 32
			owner.pixel_x -= 32
			owner.dir = EAST
		if(SOUTHWEST)
			owner.pixel_y += 32
			owner.pixel_x += 32
			owner.dir = WEST
	animate(owner,time = movement_time, pixel_x = current_pixel_x, pixel_y = current_pixel_y,easing = LINEAR_EASING)
	sleep(movement_time)
	owner.pixel_x = current_pixel_x
	owner.pixel_y = current_pixel_y
	return

/datum/combat_ai/proc/navigate_around(turf/starting_turf,turf/ending_turf)
	var/turf/new_turf
	switch(get_dir(starting_turf,ending_turf))
		if(NORTH,SOUTH)
			new_turf = locate(ending_turf.x + 1,ending_turf.y,ending_turf.z)
			for(var/atom/atom_to_test in new_turf)
				if(atom_to_test.density == 1)
					new_turf = locate(ending_turf.x - 1,ending_turf.y,ending_turf.z)
					for(var/atom/other_atom_to_test in new_turf)
						if(atom_to_test.density == 1) return
		if(EAST,WEST)
			new_turf = locate(ending_turf.x,ending_turf.y + 1,ending_turf.z)
			for(var/atom/atom_to_test in new_turf)
				if(atom_to_test.density == 1)
					new_turf = locate(ending_turf.x,ending_turf.y - 1,ending_turf.z)
					for(var/atom/other_atom_to_test in new_turf)
						if(atom_to_test.density == 1) return
		if(NORTHEAST)
			new_turf = locate(ending_turf.x,ending_turf.y + 1,ending_turf.z)
			for(var/atom/atom_to_test in new_turf)
				if(atom_to_test.density == 1)
					new_turf = locate(ending_turf.x + 1,ending_turf.y,ending_turf.z)
					for(var/atom/other_atom_to_test in new_turf)
						if(atom_to_test.density == 1) return
		if(NORTHWEST)
			new_turf = locate(ending_turf.x,ending_turf.y + 1,ending_turf.z)
			for(var/atom/atom_to_test in new_turf)
				if(atom_to_test.density == 1)
					new_turf = locate(ending_turf.x - 1,ending_turf.y,ending_turf.z)
					for(var/atom/other_atom_to_test in new_turf)
						if(atom_to_test.density == 1) return
		if(SOUTHEAST)
			new_turf = locate(ending_turf.x, ending_turf.y - 1,ending_turf.z)
			for(var/atom/atom_to_test in new_turf)
				if(atom_to_test.density == 1)
					new_turf = locate(ending_turf.x + 1,ending_turf.y,ending_turf.z)
					for(var/atom/other_atom_to_test in new_turf)
						if(atom_to_test.density == 1) return
		if(SOUTHWEST)
			new_turf = locate(ending_turf.x,ending_turf.y - 1,ending_turf.z)
			for(var/atom/atom_to_test in new_turf)
				if(atom_to_test.density == 1)
					new_turf = locate(ending_turf.x - 1,ending_turf.y,ending_turf.z)
					for(var/atom/other_atom_to_test in new_turf)
						if(atom_to_test.density == 1) return
	animate_step(new_turf)



/datum/combat_ai/proc/process_movement(turf/starting_turf,turf/ending_turf)

	if(get_dist(starting_turf,ending_turf) > 1)
		var/next_turf = get_step_towards(starting_turf,ending_turf)
		for(var/atom/atom_to_test in next_turf)
			if(atom_to_test.density == 1)
				navigate_around(starting_turf, next_turf)
				break
			else
				animate_step(next_turf)
		return
	if(get_dist(starting_turf,ending_turf) == 1)
		return 1

/datum/combat_ai/proc/process_target()
	if(!target_player)
		for(var/mob/living/mob_in_range in range(7,owner))
			var/list/anchor_range = range(return_distance, anchor_turf)
			if ((anchor_range.Find(mob_in_range) != 0) && mob_in_range.client)
				target_player = mob_in_range
				return_override = 0
	else if(get_dist(target_player,anchor_turf) > return_distance)
		return_override = 1
		target_player = null

/datum/combat_ai/proc/ai_loop()
	while(loop_terminator == 0)
		if(attacking_flag == 1)
			sleep(mob_heartbeat)
			continue
		var/turf/own_turf = get_turf(owner)
		if(return_override == 1)
			process_movement(own_turf,anchor_turf)
		process_target()
		if(!target_player)
			sleep(mob_heartbeat)
			continue
		var/turf/target_turf = get_turf(target_player)
		if(process_movement(own_turf,target_turf) == 1)
			process_attack(target_turf)
			if(attack_delay != 0) sleep(attack_delay)

