GLOBAL_LIST_INIT(ai_names, world.file2list("strings/names/ai.txt"))
GLOBAL_LIST_INIT(wizard_first, world.file2list("strings/names/wizardfirst.txt"))
GLOBAL_LIST_INIT(wizard_second, world.file2list("strings/names/wizardsecond.txt"))
GLOBAL_LIST_INIT(ninja_titles, world.file2list("strings/names/ninjatitle.txt"))
GLOBAL_LIST_INIT(ninja_names, world.file2list("strings/names/ninjaname.txt"))
GLOBAL_LIST_INIT(commando_names, world.file2list("strings/names/death_commando.txt"))
GLOBAL_LIST_INIT(first_names, world.file2list("strings/names/first.txt"))
GLOBAL_LIST_INIT(first_names_male, world.file2list("strings/names/first_male.txt"))
GLOBAL_LIST_INIT(first_names_female, world.file2list("strings/names/first_female.txt"))
GLOBAL_LIST_INIT(first_names_male_triad, world.file2list("strings/names/first_male_triad.txt"))
GLOBAL_LIST_INIT(first_names_female_triad, world.file2list("strings/names/first_female_triad.txt"))
GLOBAL_LIST_INIT(last_names_triad, world.file2list("strings/names/last_triad.txt"))
GLOBAL_LIST_INIT(last_names, world.file2list("strings/names/last.txt"))
GLOBAL_LIST_INIT(lizard_names_male, world.file2list("strings/names/lizard_male.txt"))
GLOBAL_LIST_INIT(lizard_names_female, world.file2list("strings/names/lizard_female.txt"))
GLOBAL_LIST_INIT(clown_names, world.file2list("strings/names/clown.txt"))
GLOBAL_LIST_INIT(mime_names, world.file2list("strings/names/mime.txt"))
GLOBAL_LIST_INIT(carp_names, world.file2list("strings/names/carp.txt"))
GLOBAL_LIST_INIT(golem_names, world.file2list("strings/names/golem.txt"))
GLOBAL_LIST_INIT(moth_first, world.file2list("strings/names/moth_first.txt"))
GLOBAL_LIST_INIT(moth_last, world.file2list("strings/names/moth_last.txt"))
GLOBAL_LIST_INIT(plasmaman_names, world.file2list("strings/names/plasmaman.txt"))
GLOBAL_LIST_INIT(ethereal_names, world.file2list("strings/names/ethereal.txt"))
GLOBAL_LIST_INIT(posibrain_names, world.file2list("strings/names/posibrain.txt"))
GLOBAL_LIST_INIT(nightmare_names, world.file2list("strings/names/nightmare.txt"))
GLOBAL_LIST_INIT(megacarp_first_names, world.file2list("strings/names/megacarp1.txt"))
GLOBAL_LIST_INIT(megacarp_last_names, world.file2list("strings/names/megacarp2.txt"))

//Book Quotes
GLOBAL_LIST_INIT(bahari_quotes, world.file2list("strings/quotes/bahari.txt"))
GLOBAL_LIST_INIT(noddist_quotes, world.file2list("strings/quotes/noddist.txt"))
GLOBAL_LIST_INIT(quran_quotes, world.file2list("strings/quotes/islam.txt"))

GLOBAL_LIST_INIT(verbs, world.file2list("strings/names/verbs.txt"))
GLOBAL_LIST_INIT(ing_verbs, world.file2list("strings/names/ing_verbs.txt"))
GLOBAL_LIST_INIT(adverbs, world.file2list("strings/names/adverbs.txt"))
GLOBAL_LIST_INIT(adjectives, world.file2list("strings/names/adjectives.txt"))
GLOBAL_LIST_INIT(gross_adjectives,  world.file2list("strings/names/gross_adjectives.txt"))
GLOBAL_LIST_INIT(dream_strings, world.file2list("strings/dreamstrings.txt"))
//loaded on startup because of "
//would include in rsc if ' was used

/*
List of configurable names in preferences and their metadata
"id" = list(
	"pref_name" = "name", //pref label
	"qdesc" =  "name", //popup question text
	"allow_numbers" = FALSE, // numbers allowed in the name
	"group" = "whatever", // group (these will be grouped together on pref ui ,order still follows the list so they need to be concurrent to be grouped)
	"allow_null" = FALSE // if empty name is entered it's replaced with default value
	),
*/
