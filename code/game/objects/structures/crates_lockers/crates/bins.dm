/obj/structure/closet/crate/bin
	desc = ""
	name = "trash bin"
	icon_state = "largebins"
	open_sound = 'sound/blank.ogg'
	close_sound = 'sound/blank.ogg'
	anchored = TRUE
	horizontal = FALSE
	delivery_icon = null

/obj/structure/closet/crate/bin/Initialize()
	. = ..()
	update_icon()

/obj/structure/closet/crate/bin/update_icon()
	..()
	cut_overlays()
	if(contents.len == 0)
		add_overlay("largebing")
	else if(contents.len >= storage_capacity)
		add_overlay("largebinr")
	else
		add_overlay("largebino")

/obj/structure/closet/crate/bin/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/storage/bag/trash))
		var/obj/item/storage/bag/trash/T = W
		to_chat(user, "<span class='notice'>I fill the bag.</span>")
		for(var/obj/item/O in src)
			SEND_SIGNAL(T, COMSIG_TRY_STORAGE_INSERT, O, user, TRUE)
		T.update_icon()
		do_animate()
		return TRUE
	else
		return ..()

/obj/structure/closet/crate/bin/proc/do_animate()
	playsound(loc, open_sound, 15, TRUE, -3)
	flick("animate_largebins", src)
	addtimer(CALLBACK(src, PROC_REF(do_close)), 13)

/obj/structure/closet/crate/bin/proc/do_close()
	playsound(loc, close_sound, 15, TRUE, -3)
	update_icon()
