#define BANDIT_TYPE_NPC /mob/living/carbon/human/npc/bandit
#define POLICE_TYPE_NPC /mob/living/carbon/human/npc/police

/mob/living/carbon/human/npc
	name = "Loh ebanii"
	/// Until we do a full NPC refactor (see: rewriting every single bit of code)
	/// use this to determine NPC weapons and their chances to spawn with them -- assuming you want the NPC to do that
	/// Otherwise just set it under the NPC's type as
	/// my_weapon = type_path
	/// my_backup_weapon = type_path
	/// This only determines my_weapon, you set my_backup_weapon yourself
	/// The last entry in the list for a type of NPC should always have 100 as the index
	var/static/list/role_weapons_chances = list(
		BANDIT_TYPE_NPC = list(
			 /obj/item/gun/ballistic/automatic/vampire/deagle = 33,
			 /obj/item/gun/ballistic/vampire/revolver/snub = 33,
			 /obj/item/melee/vampirearms/baseball = 100,
		),
		POLICE_TYPE_NPC = list(
			/obj/item/gun/ballistic/vampire/revolver = 66,
			/obj/item/gun/ballistic/automatic/vampire/ar15 = 100,
		)
	)
	a_intent = INTENT_HELP
	var/datum/socialrole/socialrole

	var/is_talking = FALSE
	var/last_annoy = 0
	COOLDOWN_DECLARE(car_dodge)
	var/hostile = FALSE
	var/fights_anyway = FALSE
	var/last_danger_meet = 0
	var/mob/living/danger_source
	var/atom/movable/less_danger
	var/mob/living/last_attacker
	var/last_health = 100
	var/mob/living/last_damager

	var/turf/walktarget	//dlya movementa

	var/last_grab = 0

	var/tupik_steps = 0
	var/tupik_loc

	var/stopturf = 1

	var/extra_mags=2
	var/extra_loaded_rounds=10

	var/has_weapon = FALSE

	var/my_weapon_type = null
	var/obj/item/my_weapon = null

	var/my_backup_weapon_type = null
	var/obj/item/my_backup_weapon = null

	var/spawned_weapon = FALSE

	var/spawned_backup_weapon = FALSE

	var/ghoulificated = FALSE

	var/staying = FALSE

	var/lifespan = 0	//How many cycles. He'll be deleted if over than a ten thousand
	var/old_movement = FALSE
	var/max_stat = 2

	var/list/spotted_bodies = list()

	var/is_criminal = FALSE

	var/list/drop_on_death_list = null

/mob/living/carbon/human/npc/LateInitialize()
	. = ..()
	if(role_weapons_chances.Find(type))
		for(var/weapon in role_weapons_chances[type])
			if(prob(role_weapons_chances[type][weapon]))
				my_weapon = new weapon(src)
				break
	if(!my_weapon && my_weapon_type)
		my_weapon = new my_weapon_type(src)



	if(my_weapon)
		has_weapon = TRUE
		equip_to_appropriate_slot(my_weapon)
		if(istype(my_weapon, /obj/item/gun/ballistic))
			RegisterSignal(my_weapon, COMSIG_GUN_FIRED, PROC_REF(handle_gun))
			RegisterSignal(my_weapon, COMSIG_GUN_EMPTY, PROC_REF(handle_empty_gun))
		register_sticky_item(my_weapon)

	if(my_backup_weapon_type)
		my_backup_weapon = new my_backup_weapon_type(src)
		equip_to_appropriate_slot(my_backup_weapon)
		register_sticky_item(my_backup_weapon)

//====================Sticky Item Handling====================
/mob/living/carbon/human/npc/proc/register_sticky_item(obj/item/my_item)
	ADD_TRAIT(my_item, TRAIT_NODROP, NPC_ITEM_TRAIT)
	if(!drop_on_death_list?.len)
		drop_on_death_list = list()
	drop_on_death_list += my_item

/mob/living/carbon/human/npc/death(gibbed)
	. = ..()
	if(drop_on_death_list?.len)
		for(var/obj/item/dropping_item in drop_on_death_list)
			drop_on_death_list -= dropping_item
			if(HAS_TRAIT_FROM(dropping_item, TRAIT_NODROP, NPC_ITEM_TRAIT))
				REMOVE_TRAIT(dropping_item, TRAIT_NODROP, NPC_ITEM_TRAIT)
			dropItemToGround(dropping_item, TRUE)

//If an npc's item has TRAIT_NODROP, we NEVER drop it, even if it is forced.
/mob/living/carbon/human/npc/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(I && HAS_TRAIT(I, TRAIT_NODROP))
		return FALSE
	. = ..()
//============================================================


/datum/movespeed_modifier/npc
	multiplicative_slowdown = 2

/mob/living/carbon/human/npc/proc/GetSayDelay(var/message)
	var/delay = length_char(message)
	return delay

/mob/living/carbon/human/npc/proc/RealisticSay(var/message)
	walk(src,0)
	if(!message)
		return
	if(is_talking)
		return
	if(stat >= HARD_CRIT)
		return
	is_talking = TRUE
	var/delay = round(length_char(message)/2)
	spawn(5)
		remove_overlay(SAY_LAYER)
		var/mutable_appearance/say_overlay = mutable_appearance('icons/mob/talk.dmi', "default0", -SAY_LAYER)
		overlays_standing[SAY_LAYER] = say_overlay
		apply_overlay(SAY_LAYER)
		spawn(max(1, delay))
			if(stat != DEAD)
				remove_overlay(SAY_LAYER)
				say(message)
				is_talking = FALSE

/mob/living/carbon/human/npc/proc/Annoy(var/atom/source)
	walk(src,0)
	if(CheckMove())
		return
	if(is_talking)
		return
	if(danger_source)
		return
	if(stat >= HARD_CRIT)
		return
	if(world.time <= last_annoy+50)
		return
	if(source)
		spawn(rand(3, 7))
			face_atom(source)
	last_annoy = world.time
	var/phrase
	if(prob(50))
		phrase = pick(socialrole.neutral_phrases)
	else
		if(gender == MALE)
			phrase = pick(socialrole.male_phrases)
		else
			phrase = pick(socialrole.female_phrases)
	RealisticSay(phrase)

/mob/living/carbon/human/Bump(atom/Obstacle)
	. = ..()
	var/mob/living/carbon/human/npc/NPC = locate() in get_turf(Obstacle)
	if(NPC)
		if(a_intent != INTENT_HELP)
			NPC.Annoy(src)

/mob/living/carbon/Move(NewLoc, direct)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		H.update_shadow()
	if(istype(src, /mob/living/carbon/human/npc))
		var/mob/living/carbon/human/npc/CPN = src
		if(CPN.CheckMove())
			walk(src,0)
		var/getaway = CPN.stopturf+1
		if(!CPN.old_movement)
			getaway = 2
		if(get_dist(src, CPN.walktarget) <= getaway)
			walk(src,0)
			CPN.walktarget = null
	if(HAS_TRAIT(src, TRAIT_RUBICON))
		if(istype(NewLoc, /turf/open/floor/plating/shit))
			return
	. = ..()

/mob/living/carbon/human/npc/attack_hand(mob/user)
	if(user)
		if(user.a_intent == INTENT_HELP)
			Annoy(user)
		if(user.a_intent == INTENT_DISARM)
			Aggro(user, TRUE)
		if(user.a_intent == INTENT_HARM)
			for(var/mob/living/carbon/human/npc/NEPIC in oviewers(7, src))
				NEPIC.Aggro(user)
			Aggro(user, TRUE)
	..()

/mob/living/carbon/human/npc/on_hit(obj/projectile/P)
	. = ..()

	if (!P?.firer)
		return

	for (var/mob/living/carbon/human/npc/NEPIC in oviewers(7, src))
		NEPIC.Aggro(P.firer)

	Aggro(P.firer, TRUE)
	var/witness_count

	for (var/mob/living/carbon/human/npc/NEPIC in viewers(7, usr))
		if (NEPIC && NEPIC.stat != DEAD)
			witness_count++
		if (witness_count > 1)
			for (var/obj/item/police_radio/radio in GLOB.police_radios)
				radio.announce_crime("victim", get_turf(src))
			for (var/obj/machinery/p25transceiver/police/radio in GLOB.p25_tranceivers)
				if (radio.p25_network == "police")
					radio.announce_crime("victim", get_turf(src))
					break

/mob/living/carbon/human/npc/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	. = ..()
	if(throwingdatum?.thrower && (AM.throwforce > 5 || (AM.throwforce && src.health < src.maxHealth)))
		Aggro(throwingdatum.thrower, TRUE)

/mob/living/carbon/human/npc/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if(user)
		if(W.force > 5 || (W.force && src.health < src.maxHealth))
			for(var/mob/living/carbon/human/npc/NEPIC in oviewers(7, src))
				NEPIC.Aggro(user)
			Aggro(user, TRUE)

/mob/living/carbon/human/npc/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	. = ..()
	last_grab = world.time

/mob/living/carbon/human/npc/proc/EmoteAction()
	walk(src,0)
	if(CheckMove())
		return
	var/shitemote = pick("sigh", "smile", "stare", "look", "spin", "giggle", "blink", "blush", "nod", "sniff", "shrug", "cough", "yawn")
	if(!is_talking)
		is_talking = TRUE
		spawn(rand(5, 10))
			emote(shitemote)
			is_talking = FALSE

/mob/living/carbon/human/npc/proc/StareAction()
	walk(src,0)
	if(CheckMove())
		return
	if(!is_talking)
		var/list/interest_persons = list()
		for(var/mob/living/carbon/human/H in viewers(4, src))
			if(H)
				if(H != src)
					interest_persons += H
		if(length(interest_persons))
			is_talking = TRUE
			spawn(rand(2, 7))
				face_atom(pick(interest_persons))
				spawn(rand(1, 5))
					is_talking = FALSE

/mob/living/carbon/human/npc/proc/SpeechAction()
	walk(src,0)
	if(CheckMove())
		return
	if(!is_talking)
		var/list/interest_persons = list()
		for(var/mob/living/carbon/human/npc/H in viewers(4, src))
			if(H)
				if(H != src && !H.CheckMove())
					interest_persons += H
		if(length(interest_persons))
			var/mob/living/carbon/human/npc/N = pick(interest_persons)
			face_atom(N)
			var/question = pick(socialrole.random_phrases)
			RealisticSay(question)
			spawn(rand(1, 5))
				N.face_atom(src)
				N.is_talking = TRUE
				spawn(GetSayDelay(question))
					N.is_talking = FALSE
					N.RealisticSay(pick(N.socialrole.answer_phrases))

/mob/living/carbon/human/npc/proc/ghoulificate(mob/owner)
	set waitfor = FALSE
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as [owner]`s ghoul?", null, null, null, 50, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, "<span class='ghostalert'>[owner] is ghoulificating [src].</span>")
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		key = C.key
		ghoulificated = TRUE
		set_species(/datum/species/ghoul)
		if(mind)
			if(mind.enslaved_to != owner)
				mind.enslave_mind_to_creator(owner)
				to_chat(src, "<span class='userdanger'><b>AS PRECIOUS VITAE ENTER YOUR MOUTH, YOU NOW ARE IN THE BLOODBOND OF [owner]. SERVE YOUR REGNANT CORRECTLY, OR YOUR ACTIONS WILL NOT BE TOLERATED.</b></span>")
				return TRUE
	return FALSE
