/**
 * Assigns a human an alternative body sprite
 * accounting for body model. If no sprite name
 * is supplied, sets it to the default for the
 * human depending on species or Clan.
 *
 * Arguments:
 * * sprite_name - Name of the sprite that'll be used as the base for this human's limbs.
 */
/mob/living/carbon/human/proc/set_body_sprite(sprite_name)
	// Cannot be used without species code as this relies on limbs_id
	CHECK_DNA_AND_SPECIES(src)

	// If no base sprite is supplied, get a default from either the species or the Clan
	if (!sprite_name)
		if (clan?.alt_sprite)
			sprite_name = clan.alt_sprite
		else
			sprite_name = initial(dna.species.limbs_id)

	// Assigns a body model and an alternative sprite
	dna.species.limbs_id = sprite_name

	// Update icons to reflect new body sprite
	update_body()

/**
 * Rots the vampire's body along four stages of decay.
 *
 * Vampire bodies are either pre-decayed if they're Cappadocians,
 * or they decay on death to what their body should naturally
 * be according to their chronological age. Stage 1 is
 * fairly normal looking with discoloured skin, stage 2 is
 * somewhat decayed-looking, stage 3 is very decayed, and stage
 * 4 is a long-dead completely decayed corpse. This has no effect
 * on Clans that already have alt_sprites unless they're being
 * rotted to stage 3 and above.
 *
 * Arguments:
 * * rot_stage - how much to rot the vampire, on a scale from 1 to 4.
 */
/mob/living/carbon/human/proc/rot_body(rot_stage)
	// Won't work unless this person has limbs_id on species
	CHECK_DNA_AND_SPECIES(src)

	// Won't replace other alternative sprites unless it's advanced decay
	if (!NORMAL_BODY_SPRITE(src) && !findtext(GET_BODY_SPRITE(src), "rotten") && (rot_stage <= 2))
		return

	// Apply rotten sprite and rotting effects
	switch (rot_stage)
		if (1)
			set_body_sprite("rotten1")
		if (2)
			set_body_sprite("rotten2")
		if (3)
			set_body_sprite("rotten3")
			skin_tone = ALBINO
			hairstyle = "Bald"
			facial_hairstyle = "Shaved"
			ADD_TRAIT(src, TRAIT_MASQUERADE_VIOLATING_FACE, MAGIC_TRAIT)
		if (4)
			set_body_sprite("rotten4")
			skin_tone = ALBINO
			hairstyle = "Bald"
			facial_hairstyle = "Shaved"
			ADD_TRAIT(src, TRAIT_MASQUERADE_VIOLATING_FACE, MAGIC_TRAIT)

