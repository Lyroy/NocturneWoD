/obj/item/computer_hardware/printer
	name = "printer"
	desc = "Computer-integrated printer with paper recycling module."
	power_usage = 100
	icon_state = "printer"
	w_class = WEIGHT_CLASS_NORMAL
	device_type = MC_PRINT
	expansion_hw = TRUE
	var/stored_paper = 20
	var/max_paper = 30

/obj/item/computer_hardware/printer/diagnostics(mob/living/user)
	..()
	to_chat(user, span_notice("Paper level: [stored_paper]/[max_paper]."))

/obj/item/computer_hardware/printer/examine(mob/user)
	. = ..()
	. += span_notice("Paper level: [stored_paper]/[max_paper].")


/obj/item/computer_hardware/printer/proc/print_text(text_to_print, paper_title = "")
	if(!stored_paper)
		return FALSE
	if(!check_functionality())
		return FALSE

	var/obj/item/paper/printed_paper = new/obj/item/paper(holder.drop_location())

	// Damaged printer causes the resulting paper to be somewhat harder to read.
	if(damage > damage_malfunction)
		printed_paper.add_raw_text(stars(text_to_print, 100-malfunction_probability))
	else
		printed_paper.add_raw_text(text_to_print)
	if(paper_title)
		printed_paper.name = paper_title
	printed_paper.update_icon()
	stored_paper--
	return TRUE

/obj/item/computer_hardware/printer/try_insert(obj/item/I, mob/living/user = null)
	if(istype(I, /obj/item/paper))
		if(stored_paper >= max_paper)
			to_chat(user, span_warning("You try to add \the [I] into [src], but its paper bin is full!"))
			return FALSE

		if(user && !user.temporarilyRemoveItemFromInventory(I))
			return FALSE
		to_chat(user, span_notice("You insert \the [I] into [src]'s paper recycler."))
		qdel(I)
		stored_paper++
		return TRUE
	if(istype(I, /obj/item/paper_bin))
		var/obj/item/paper_bin/bin = I
		if(bin.total_paper > 0)
			if(stored_paper >= max_paper)
				balloon_alert(user, "it's full!")
				return FALSE
			/// Number of sheets we're adding
			var/num_to_add = 0

			for(var/obj/item/paper/paper_in_stack as anything in bin.paper_stack) // Search for the first blank sheet of paper, then toss it in
				if(paper_in_stack.get_total_length()) // Uh oh, paper has words!
					continue
				if(istype(paper_in_stack, /obj/item/paper/carbon)) // Add both the carbon, and the copy
					var/obj/item/paper/carbon/carbon_paper = paper_in_stack
					if(!carbon_paper.copied && ((max_paper - stored_paper) >= 2)) // See if there's room for both
						num_to_add = 2
				else
					num_to_add = 1
				bin.paper_stack -= paper_in_stack
				bin.total_paper -= 1
				qdel(paper_in_stack)
				stored_paper += num_to_add
				break // All full!

			if (num_to_add == 0 && bin.total_paper > 0)
				bin.total_paper -= 1
				num_to_add = 1
				stored_paper += 1

			bin.update_icon()
			if(!num_to_add)
				balloon_alert(user, "everything is written on!")
			else
				balloon_alert(user, "pulled in [num_to_add] sheets\s of paper")
			return TRUE
		else
			balloon_alert(user, "the bin is empty!")
			return FALSE
	return FALSE

/obj/item/computer_hardware/printer/mini
	name = "miniprinter"
	desc = "A small printer with paper recycling module."
	power_usage = 50
	icon_state = "printer_mini"
	w_class = WEIGHT_CLASS_TINY
	stored_paper = 5
	max_paper = 15
