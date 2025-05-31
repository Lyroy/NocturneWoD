//MUSIC

/datum/vampiremusic
	var/length = 30 SECONDS
	var/sound
	var/forced = FALSE

/datum/vampiremusic/forest
	length = 389 SECONDS
	sound = 'code/modules/wod13/sounds/night_ambience.ogg'

/datum/vampiremusic/penumbra
	length = 336 SECONDS
	sound = 'code/modules/wod13/sounds/penumbra.ogg'

/datum/vampiremusic/santamonica
	length = 304 SECONDS
	sound = 'code/modules/wod13/sounds/santamonica.ogg'

/datum/vampiremusic/downtown
	length = 259 SECONDS
	sound = 'code/modules/wod13/sounds/downtown.ogg'

/datum/vampiremusic/sewer
	length = 134 SECONDS
	sound = 'code/modules/wod13/sounds/enterlair.ogg'
	forced = TRUE

/datum/vampiremusic/hollywood
	length = 337 SECONDS
	sound = 'code/modules/wod13/sounds/hollywood.ogg'

/datum/vampiremusic/chinatown
	length = 369 SECONDS
	sound = 'code/modules/wod13/sounds/chinatown.ogg'

/datum/vampiremusic/prince
	length = 132 SECONDS
	sound = 'code/modules/wod13/sounds/prince.ogg'
	forced = TRUE

/datum/vampiremusic/church
	length = 91 SECONDS
	sound = 'code/modules/wod13/sounds/hahihaho.ogg'
	forced = TRUE

/datum/vampiremusic/bar
	length = 497 SECONDS
	sound = 'code/modules/wod13/sounds/naive.ogg'
	forced = TRUE

/datum/vampiremusic/theatre
	length = 93 SECONDS
	sound = 'code/modules/wod13/sounds/theatre.ogg'
	forced = TRUE

/datum/vampiremusic/nosferatu
	length = 181 SECONDS
	sound = 'code/modules/wod13/sounds/nosferatu.ogg'
	forced = TRUE

/datum/vampiremusic/elevator
	length = 157 SECONDS
	sound = 'code/modules/wod13/sounds/lift.ogg'
	forced = TRUE

/mob/living/proc/handle_vampire_music()
	if(!client)
		return
	if(stat == DEAD)
		return

	var/turf/T

	if(!isturf(loc))
		var/atom/A = loc
		if(!isturf(A.loc))
			return
		T = A.loc
	else
		T = loc

	if(istype(get_area(T), /area/vtm))
		var/area/vtm/VTM = get_area(T)
		if(VTM)

			if(!VTM.music)
				client << sound(null, 0, 0, CHANNEL_LOBBYMUSIC)
				last_vampire_ambience = 0
				wait_for_music = 0
				return
			var/datum/vampiremusic/VMPMSC = new VTM.music()
			if(VMPMSC.forced && wait_for_music != VMPMSC.length)
				client << sound(null, 0, 0, CHANNEL_LOBBYMUSIC)
				last_vampire_ambience = 0
				wait_for_music = 0
				wasforced = TRUE

			else if(wasforced && wait_for_music != VMPMSC.length)
				client << sound(null, 0, 0, CHANNEL_LOBBYMUSIC)
				last_vampire_ambience = 0
				wait_for_music = 0
				wasforced = FALSE

			if(last_vampire_ambience+wait_for_music+10 < world.time)
				wait_for_music = VMPMSC.length
				client << sound(VMPMSC.sound, 0, 0, CHANNEL_LOBBYMUSIC, 10)
				last_vampire_ambience = world.time
			qdel(VMPMSC)
