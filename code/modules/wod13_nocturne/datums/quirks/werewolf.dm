/datum/quirk/wyrm_tainted
	name = "Wyrm Tainted"
	desc = "The touch of the wyrm has perverted you. Other werewolves can sense this taint, and your crinos form is changed."
	mob_trait = TRAIT_WYRMTAINTED
	value = -1
	gain_text = "<span class='warning'>You feel wrongness crawling beneath your skin.</span>"
	lose_text = "<span class='notice'>You feel relief and warmth.</span>"
	allowed_species = list("Werewolf", "Human")

/datum/quirk/fair_glabro
	name = "Fair Glabro"
	desc = "Your Glabro Form is less bestial than others. Allowing you to use it in public"
	mob_trait = TRAIT_FAIR_GLABRO
	value = 4
	allowed_species = list("Werewolf")

/datum/quirk/kinfolk
	name = "Kinfolk"
	desc = "You are both related to, and possiblly accepted by a pack of werewolves, or other fera. You may know their customs, and are privy to secret signs which can identify you as a friend. Make no mistake, knowledge of this trait is a liability in the wrong hands, and you are open to consequences from enemies of the Fera."
	value = 2
	allowed_species = list("Human")
	mob_trait = TRAIT_KINFOLK

/*
/datum/quirk/kinfolk/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/garou_tongue)
	H.grant_language(/datum/language/primal_tongue, understood = TRUE, spoken = FALSE)
*/
