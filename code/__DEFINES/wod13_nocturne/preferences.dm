// This is the lowest supported version, anything below this is completely obsolete and the entire savefile will be wiped.
#define SAVEFILE_VERSION_MIN 40

// This is the current version, anything below this will attempt to update (if it's not obsolete)
// You do not need to raise this if you are adding new values that have sane defaults.
// Only raise this value when changing the meaning/format/name/layout of an existing value
// where you would want the updater procs below to run
#define SAVEFILE_VERSION_MAX 40

GLOBAL_LIST_EMPTY(preferences_datums)


// Highest level that a base attribute can be upgraded to. Bonus attributes can increase the actual amount past the limit.
#define ATTRIBUTE_BASE_LIMIT 5
