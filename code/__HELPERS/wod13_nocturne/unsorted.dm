/proc/limb_name2body_part_covered(limb_name)
	switch(limb_name)
		if("Head")
			return HEAD
		if("Chest")
			return CHEST
		if("Left Arm")
			return ARM_LEFT
		if("Right Arm")
			return ARM_RIGHT
		if("Left Leg")
			return LEG_LEFT
		if("Right Leg")
			return LEG_RIGHT

/proc/body_part_covered2limb_name(body_part_covered)
	switch(body_part_covered)
		if(HEAD)
			return "Head"
		if(CHEST)
			return "Chest"
		if(ARM_LEFT)
			return "Left Arm"
		if(ARM_RIGHT)
			return "Right Arm"
		if(LEG_LEFT)
			return "Left Leg"
		if(LEG_RIGHT)
			return "Right Leg"
