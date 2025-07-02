// This is the lowest supported version, anything below this is completely obsolete and the entire savefile will be wiped.
#define SAVEFILE_VERSION_MIN 40

// This is the current version, anything below this will attempt to update (if it's not obsolete)
// You do not need to raise this if you are adding new values that have sane defaults.
// Only raise this value when changing the meaning/format/name/layout of an existing value
// where you would want the updater procs below to run
#define SAVEFILE_VERSION_MAX 40

GLOBAL_LIST_EMPTY(preferences_datums)

// tab definitions - KEEP SEQUENTIAL
#define PREFS_CHARACTER_SETTINGS_TAB 1
#define PREFS_QUIRKS_TAB 2
#define PREFS_ATTRIBUTES_TAB 3
#define PREFS_CONNECTIONS_TAB 4
#define PREFS_OCCUPATION_TAB 5
#define PREFS_GAME_PREFERENCES_TAB 6
#define PREFS_OOC_PREFERENCES_TAB 7
#define PREFS_KEYBINDINGS_TAB 8

// Highest level that a base attribute can be upgraded to. Bonus attributes can increase the actual amount past the limit.
#define ATTRIBUTE_BASE_LIMIT 5
