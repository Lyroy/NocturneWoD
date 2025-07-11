/*
	Defines for use in saycode and text formatting.
	Currently contains speech spans and message modes
*/
#define RADIO_EXTENSION "department specific"
#define RADIO_KEY "department specific key"
#define LANGUAGE_EXTENSION "language specific"

//Message modes. Each one defines a radio channel, more or less.
//if you use ! as a mode key for some ungodly reason, change the first character for ionnum() so get_message_mode() doesn't freak out with state law prompts - shiz.
#define MODE_HEADSET "headset"
#define MODE_ROBOT "robot"

#define MODE_R_HAND "right hand"
#define MODE_KEY_R_HAND "r"

#define MODE_L_HAND "left hand"
#define MODE_KEY_L_HAND "l"

#define MODE_INTERCOM "intercom"
#define MODE_KEY_INTERCOM "i"
#define MODE_TOKEN_INTERCOM ":i"

#define MODE_BINARY "binary"
#define MODE_KEY_BINARY "b"
#define MODE_TOKEN_BINARY ":b"

#define WHISPER_MODE "the type of whisper"
#define MODE_WHISPER "whisper"
#define MODE_WHISPER_CRIT "whispercrit"

#define MODE_DEPARTMENT "department"
#define MODE_KEY_DEPARTMENT "h"
#define MODE_TOKEN_DEPARTMENT ":h"

#define MODE_ADMIN "admin"
#define MODE_KEY_ADMIN "p"

#define MODE_DEADMIN "deadmin"
#define MODE_KEY_DEADMIN "d"

#define MODE_ALIEN "alientalk"
#define MODE_HOLOPAD "holopad"

#define MODE_VOCALCORDS "cords"
#define MODE_KEY_VOCALCORDS "x"

#define MODE_MONKEY "monkeyhive"

#define MODE_MAFIA "mafia"

#define MODE_SING "sing"

//Spans. Robot speech, italics, etc. Applied in compose_message().
#define SPAN_ROBOT "robot"
#define SPAN_YELL "yell"
#define SPAN_ITALICS "italics"
#define SPAN_SANS "sans"
#define SPAN_PAPYRUS "papyrus"
#define SPAN_REALLYBIG "reallybig"
#define SPAN_COMMAND "command_headset"
#define SPAN_CLOWN "clown"
#define SPAN_SINGING "singing"
#define SPAN_TAPE_RECORDER "tape_recorder"

#define SPAN_PHONE "phone"
#define SPAN_SMALLPHONE "smallphone"

//bitflag #defines for return value of the radio() proc.
#define ITALICS			(1<<0)
#define REDUCE_RANGE	(1<<1)
#define NOPASS			(1<<2)

//Eavesdropping
#define EAVESDROP_EXTRA_RANGE 1 //how much past the specified message_range does the message get starred, whispering only

/// How close intercoms can be for radio code use
#define MODE_RANGE_INTERCOM 1

// A link given to ghost alice to follow bob
#define FOLLOW_LINK(alice, bob) "<a href=byond://?src=[REF(alice)];follow=[REF(bob)]>(F)</a>" //<a href=byond://?src=[REF(alice)];follow=[REF(bob)]>(F)</a> //! [ChillRaccoon] - REWORK OR REMOVE
#define TURF_LINK(alice, turfy) "<a href=byond://?src=[REF(alice)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(T)</a>" //<a href=byond://?src=[REF(alice)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(T)</a> //! [ChillRaccoon] - REWORK OR REMOVE
#define FOLLOW_OR_TURF_LINK(alice, bob, turfy) "<a href=byond://?src=[REF(alice)];follow=[REF(bob)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(F)</a>" //<a href=byond://?src=[REF(alice)];follow=[REF(bob)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(F)</a> //! [ChillRaccoon] - REWORK OR REMOVE

//Don't set this very much higher then 1024 unless you like inviting people in to dos your server with message spam
#define MAX_MESSAGE_LEN			2048 // ^^ SUCK MY DICK
#define MAX_NAME_LEN			42
#define MAX_BROADCAST_LEN		512
#define MAX_CHARTER_LEN			80
#define MAX_FLAVOR_LEN 			4096

#define MAX_PLAQUE_LEN 144
#define MAX_LABEL_LEN 64
#define MAX_DESC_LEN 280

// Is something in the IC chat filter? This is config dependent.
#define CHAT_FILTER_CHECK(T) (config.ic_filter_regex && findtext(T, config.ic_filter_regex))

// Audio/Visual Flags. Used to determine what sense are required to notice a message.
#define MSG_VISUAL (1<<0)
#define MSG_AUDIBLE (1<<1)

#define INVOCATION_SHOUT "shout"
#define INVOCATION_EMOTE "emote"
#define INVOCATION_WHISPER "whisper"

//Used in visible_message_flags, audible_message_flags and runechat_flags
#define EMOTE_MESSAGE (1<<0)
