//Preferences stuff
	//Hairstyles
GLOBAL_LIST_EMPTY(hairstyles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(hairstyles_male_list)		//stores only hair names
GLOBAL_LIST_EMPTY(hairstyles_female_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hairstyles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
GLOBAL_LIST_EMPTY(facial_hairstyles_male_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hairstyles_female_list)	//stores only hair names
GLOBAL_LIST_EMPTY(gradients_list) //stores /datum/sprite_accessory/gradient indexed by name
	//Underwear
GLOBAL_LIST_EMPTY(underwear_list)		//stores /datum/sprite_accessory/underwear indexed by name
GLOBAL_LIST_EMPTY(underwear_m)	//stores only underwear name
GLOBAL_LIST_EMPTY(underwear_f)	//stores only underwear name
	//Undershirts
GLOBAL_LIST_EMPTY(undershirt_list) 	//stores /datum/sprite_accessory/undershirt indexed by name
GLOBAL_LIST_EMPTY(undershirt_m)	 //stores only undershirt name
GLOBAL_LIST_EMPTY(undershirt_f)	 //stores only undershirt name
	//Socks
GLOBAL_LIST_EMPTY(socks_list)		//stores /datum/sprite_accessory/socks indexed by name
	//Lizard Bits (all datum lists indexed by name)
GLOBAL_LIST_EMPTY(body_markings_list)
GLOBAL_LIST_EMPTY(tails_list_lizard)
GLOBAL_LIST_EMPTY(animated_tails_list_lizard)
GLOBAL_LIST_EMPTY(snouts_list)
GLOBAL_LIST_EMPTY(horns_list)
GLOBAL_LIST_EMPTY(frills_list)
GLOBAL_LIST_EMPTY(spines_list)
GLOBAL_LIST_EMPTY(legs_list)
GLOBAL_LIST_EMPTY(animated_spines_list)

	//Mutant Human bits
GLOBAL_LIST_EMPTY(tails_list_human)
GLOBAL_LIST_EMPTY(animated_tails_list_human)
GLOBAL_LIST_EMPTY(ears_list)
GLOBAL_LIST_EMPTY(wings_list)
GLOBAL_LIST_EMPTY(wings_open_list)
GLOBAL_LIST_EMPTY(r_wings_list)
GLOBAL_LIST_EMPTY(moth_wings_list)
GLOBAL_LIST_EMPTY(moth_antennae_list)
GLOBAL_LIST_EMPTY(moth_markings_list)
GLOBAL_LIST_EMPTY(caps_list)
GLOBAL_LIST_EMPTY(tails_list_monkey)

// nocturne additions
GLOBAL_LIST_EMPTY(mam_body_markings_list)

//a way to index the right bodypart list given the type of bodypart
GLOBAL_LIST_INIT(mutant_reference_list, list(
	"body_marking" = GLOB.body_markings_list,
	"tail_lizard" = GLOB.tails_list_lizard,
	"waggingtail_lizard" = GLOB.animated_tails_list_lizard,
	"snout" = GLOB.snouts_list,
	"horns" = GLOB.horns_list,
	"frills" = GLOB.frills_list,
	"spines" = GLOB.spines_list,
	"legs" = GLOB.legs_list,
	"waggingspines" = GLOB.animated_spines_list,
	"tail_human" = GLOB.tails_list_human,
	"waggingtail_human" = GLOB.animated_tails_list_human,
	"ears" = GLOB.ears_list,
	"wings" = GLOB.wings_list,
	"wingsopen" = GLOB.wings_open_list,
	"moth_wings" = GLOB.moth_wings_list,
	"moth_antennae" = GLOB.moth_antennae_list,
	"moth_markings" = GLOB.moth_markings_list,
	"caps" = GLOB.caps_list,
	"tail_monkey" = GLOB.tails_list_monkey,
	"mam_body_markings" = GLOB.mam_body_markings_list,))

// way to index mutant parts to their display names (jesus christ this piece of shit should just be rewritten to use datums FUCK TG)
GLOBAL_LIST_INIT(mutant_name_list, list(
	"body_marking" = "Markings",
	"tail_lizard" = "Tail",
	"snout" = "Snout",
	"horns" = "Horns",
	"frills" = "Frills",
	"spines" = "Spines",
	"legs" = "Legs",
	"tail_human" = "Tail",
	"ears" = "Ears",
	"wings" = "Wings",
	"moth_wings" = "Wings",
	"moth_antennae" = "Antennae",
	"moth_markings" = "Markings",
	"caps" = "Cap",
	"tail_monkey" = "Tail",))

//references wag types to regular types, wings open to wings, etc
GLOBAL_LIST_INIT(mutant_transform_list, list(
	"wingsopen" = "wings",
	"waggingtail_human" = "tail_human",
	"waggingtail_lizard" = "tail_lizard",
	"waggingspines" = "spines",))

GLOBAL_LIST_INIT(color_list_ethereal, list(
	"Red" = "ff4d4d",
	"Faint Red" = "ffb3b3",
	"Dark Red" = "9c3030",
	"Orange" = "ffa64d",
	"Burnt Orange" = "cc4400",
	"Bright Yellow" = "ffff99",
	"Dull Yellow" = "fbdf56",
	"Faint Green" = "ddff99",
	"Green" = "97ee63",
	"Seafoam Green" = "00fa9a",
	"Dark Green" = "37835b",
	"Cyan Blue" = "00ffff",
	"Faint Blue" = "b3d9ff",
	"Blue" = "3399ff",
	"Dark Blue" = "6666ff",
	"Purple" = "ee82ee",
	"Dark Fuschia" = "cc0066",
	"Pink" = "ff99cc",
	"White" = "f2f2f2",))

GLOBAL_LIST_INIT(ghost_forms_with_directions_list, list(
	"ghost",
	"ghostian",
	"ghostian2",
	"ghostking",
	"ghost_red",
	"ghost_black",
	"ghost_blue",
	"ghost_yellow",
	"ghost_green",
	"ghost_pink",
	"ghost_cyan",
	"ghost_dblue",
	"ghost_dred",
	"ghost_dgreen",
	"ghost_dcyan",
	"ghost_grey",
	"ghost_dyellow",
	"ghost_dpink",
	"skeleghost",
	"ghost_purpleswirl",
	"ghost_rainbow",
	"ghost_fire",
	"ghost_funkypurp",
	"ghost_pinksherbert",
	"ghost_blazeit",
	"ghost_mellow",
	"ghost_camo",
	"catghost")) //stores the ghost forms that support directional sprites

GLOBAL_LIST_INIT(ghost_forms_with_accessories_list, list("ghost")) //stores the ghost forms that support hair and other such things

GLOBAL_LIST_INIT(ai_core_display_screens, sortList(list(
	":thinking:",
	"Alien",
	"Angel",
	"Banned",
	"Bliss",
	"Blue",
	"Clown",
	"Database",
	"Dorf",
	"Firewall",
	"Fuzzy",
	"Gentoo",
	"Glitchman",
	"Gondola",
	"Goon",
	"Hades",
	"HAL 9000",
	"Heartline",
	"Helios",
	"House",
	"Inverted",
	"Matrix",
	"Monochrome",
	"Murica",
	"Nanotrasen",
	"Not Malf",
	"Portrait",
	"President",
	"Random",
	"Rainbow",
	"Red",
	"Red October",
	"Static",
	"Syndicat Meow",
	"Text",
	"Too Deep",
	"Triumvirate",
	"Triumvirate-M",
	"Weird")))

/proc/resolve_ai_icon(input)
	if(!input || !(input in GLOB.ai_core_display_screens))
		return "ai"
	else
		if(input == "Random")
			input = pick(GLOB.ai_core_display_screens - "Random")
		if(input == "Portrait")
			var/datum/portrait_picker/tgui  = new(usr)//create the datum
			tgui.ui_interact(usr)//datum has a tgui component, here we open the window
			return "ai-portrait" //just take this until they decide
		return "ai-[lowertext(input)]"

GLOBAL_LIST_INIT(security_depts_prefs, sortList(list(SEC_DEPT_RANDOM, SEC_DEPT_NONE, SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY)))

	//Backpacks
#define GBACKPACK "Grey Backpack"
#define GSATCHEL "Grey Satchel"
#define GDUFFELBAG "Grey Duffel Bag"
#define LSATCHEL "Leather Satchel"
#define DBACKPACK "Department Backpack"
#define DSATCHEL "Department Satchel"
#define DDUFFELBAG "Department Duffel Bag"
GLOBAL_LIST_INIT(backpacklist, list(DBACKPACK, DSATCHEL, DDUFFELBAG, GBACKPACK, GSATCHEL, GDUFFELBAG, LSATCHEL))

	//Suit/Skirt
#define PREF_SUIT "Jumpsuit"
#define PREF_SKIRT "Jumpskirt"
GLOBAL_LIST_INIT(jumpsuitlist, list(PREF_SUIT, PREF_SKIRT))

//Uplink spawn loc
#define UPLINK_PDA		"PDA"
#define UPLINK_RADIO	"Radio"
#define UPLINK_PEN		"Pen" //like a real spy!
#define UPLINK_IMPLANT  "Implant"
GLOBAL_LIST_INIT(uplink_spawn_loc_list, list(UPLINK_PDA, UPLINK_RADIO, UPLINK_PEN, UPLINK_IMPLANT))

	//Female Uniforms
GLOBAL_LIST_EMPTY(female_clothing_icons)

GLOBAL_LIST_INIT(scarySounds, list('sound/weapons/thudswoosh.ogg','sound/weapons/taser.ogg','sound/weapons/armbomb.ogg','sound/voice/hiss1.ogg','sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg','sound/voice/hiss5.ogg','sound/voice/hiss6.ogg','sound/effects/glassbr1.ogg','sound/effects/glassbr2.ogg','sound/effects/glassbr3.ogg','sound/items/welder.ogg','sound/items/welder2.ogg','sound/machines/airlock.ogg','sound/effects/clownstep1.ogg','sound/effects/clownstep2.ogg'))


// Reference list for disposal sort junctions. Set the sortType variable on disposal sort junctions to
// the index of the sort department that you want. For example, sortType set to 2 will reroute all packages
// tagged for the Cargo Bay.

/* List of sortType codes for mapping reference
0 Waste
1 Disposals - All unwrapped items and untagged parcels get picked up by a junction with this sortType. Usually leads to the recycler.
2 Cargo Bay
3 QM Office
4 Engineering
5 CE Office
6 Atmospherics
7 Security
8 HoS Office
9 Medbay
10 CMO Office
11 Chemistry
12 Research
13 RD Office
14 Robotics
15 HoP Office
16 Library
17 Chapel
18 Theatre
19 Bar
20 Kitchen
21 Hydroponics
22 Janitor
23 Genetics
24 Experimentor Lab
25 Toxins
26 Dormitories
27 Virology
28 Xenobiology
29 Law Office
30 Detective's Office
*/

//The whole system for the sorttype var is determined based on the order of this list,
//disposals must always be 1, since anything that's untagged will automatically go to disposals, or sorttype = 1 --Superxpdude

//If you don't want to fuck up disposals, add to this list, and don't change the order.
//If you insist on changing the order, you'll have to change every sort junction to reflect the new order. --Pete

GLOBAL_LIST_INIT(TAGGERLOCATIONS, list("Disposals",
	"Cargo Bay", "QM Office", "Engineering", "CE Office",
	"Atmospherics", "Security", "HoS Office", "Medbay",
	"CMO Office", "Chemistry", "Research", "RD Office",
	"Robotics", "HoP Office", "Library", "Chapel", "Theatre",
	"Bar", "Kitchen", "Hydroponics", "Janitor Closet","Genetics",
	"Experimentor Lab", "Toxins", "Dormitories", "Virology",
	"Xenobiology", "Law Office","Detective's Office"))

GLOBAL_LIST_INIT(station_prefixes, world.file2list("strings/station_prefixes.txt"))

GLOBAL_LIST_INIT(station_names, world.file2list("strings/station_names.txt"))

GLOBAL_LIST_INIT(station_suffixes, world.file2list("strings/station_suffixes.txt"))

GLOBAL_LIST_INIT(greek_letters, world.file2list("strings/greek_letters.txt"))

GLOBAL_LIST_INIT(phonetic_alphabet, world.file2list("strings/phonetic_alphabet.txt"))

GLOBAL_LIST_INIT(numbers_as_words, world.file2list("strings/numbers_as_words.txt"))

GLOBAL_LIST_INIT(wisdoms, world.file2list("strings/wisdoms.txt"))

/proc/generate_number_strings()
	var/list/L[198]
	for(var/i in 1 to 99)
		L += "[i]"
		L += "\Roman[i]"
	return L

GLOBAL_LIST_INIT(station_numerals, greek_letters + phonetic_alphabet + numbers_as_words + generate_number_strings())

GLOBAL_LIST_INIT(admiral_messages, list("Do you know how expensive these stations are?","Stop wasting my time.","I was sleeping, thanks a lot.","Stand and fight you cowards!","You knew the risks coming in.","Stop being paranoid.","Whatever's broken just build a new one.","No.", "<i>null</i>","<i>Error: No comment given.</i>", "It's a good day to die!"))
