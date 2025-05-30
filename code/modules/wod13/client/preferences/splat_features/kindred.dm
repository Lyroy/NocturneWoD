/datum/preference/choiced/kindred_morality
	savefile_key = "feature_kindred_morality"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Morality"
	should_generate_icons = TRUE
	relevant_inherent_trait = TRAIT_VTM_MORALITY

/datum/preference/choiced/kindred_morality/create_default_value()
	return "Humanity"

/datum/preference/choiced/kindred_morality/init_possible_values()
	return list("Humanity", "Enlightenment")

/datum/preference/choiced/kindred_morality/icon_for(value)
	return uni_icon('icons/obj/drinks/drinks.dmi', "bloodglass")

/datum/preference/choiced/kindred_morality/apply_to_human(mob/living/carbon/human/target, value)
	if (!iskindred(target))
		return
	if (value != "Enlightenment")
		return

	var/datum/species/human/kindred/kindred_species = target.dna.species
	kindred_species.enlightenment = TRUE
