/mob/living/carbon/human/npc/walkby/club
	staying = TRUE

/mob/living/carbon/human/npc/walkby/club/Life()
	. = ..()

	if (!staying || stat >= UNCONSCIOUS)
		return
	if (!prob(5))
		return

	var/hasjukebox = FALSE
	for (var/obj/machinery/jukebox/jukebox in range(5, src))
		hasjukebox = TRUE

		if (!jukebox.active)
			continue
		if (prob(50))
			dancefirst(src)
		else
			dancesecond(src)

	if (!hasjukebox)
		staying = FALSE
