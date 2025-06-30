
/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybindings_set;keybinding=[kb.name];old_key=[old_key];clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/// checks through keybindings for outdated unbound keys and updates them
/datum/preferences/proc/check_keybindings()
	if(!parent)
		return
	var/list/user_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)
	var/list/notadded = list()
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		if(length(user_binds[kb.name]))
			continue // key is unbound and or bound to something
		var/addedbind = FALSE
		if(hotkeys)
			for(var/hotkeytobind in kb.classic_keys)
				if(!length(key_bindings[hotkeytobind]))
					LAZYADD(key_bindings[hotkeytobind], kb.name)
					addedbind = TRUE
		else
			for(var/classickeytobind in kb.classic_keys)
				if(!length(key_bindings[classickeytobind]))
					LAZYADD(key_bindings[classickeytobind], kb.name)
					addedbind = TRUE
		if(!addedbind)
			notadded += kb
	if(length(notadded))
		addtimer(CALLBACK(src, PROC_REF(announce_conflict), notadded), 5 SECONDS)

/datum/preferences/proc/announce_conflict(list/notadded)
	to_chat(parent, "<span class='userdanger'>KEYBINDING CONFLICT!!!\n\
	There are new keybindings that have defaults bound to keys you already set, They will default to Unbound. You can bind them in Setup Character or Game Preferences\n\
	<a href='byond://?_src_=prefs;preference=tab;tab=3'>Or you can click here to go straight to the keybindings page</a></span>")
	for(var/item in notadded)
		var/datum/keybinding/conflicted = item
		to_chat(parent, "<span class='userdanger'>[conflicted.category]: [conflicted.full_name] needs updating")
		LAZYADD(key_bindings["Unbound"], conflicted.name) // set it to unbound to prevent this from opening up again in the future

/proc/sanitize_keybindings(value)
	var/list/base_bindings = sanitize_islist(value,list())
	for(var/key in base_bindings)
		base_bindings[key] = base_bindings[key] & GLOB.keybindings_by_name
		if(!length(base_bindings[key]))
			base_bindings -= key
	return base_bindings
