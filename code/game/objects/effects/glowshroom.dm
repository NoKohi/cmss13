//separate dm since hydro is getting bloated already

/obj/effect/glowshroom
	name = "glowshroom"
	anchored = 1
	opacity = FALSE
	density = FALSE
	icon = 'icons/obj/items/lighting.dmi'
	icon_state = "glowshroomf"
	layer = ABOVE_TURF_LAYER

	var/endurance = 30
	var/potency = 30
	var/delay = 1200
	var/floor = 0
	var/yield = 3
	var/evolveChance = 2
	var/lastTick = 0
	var/spreaded = 1

/obj/effect/glowshroom/single

/obj/effect/glowshroom/Initialize(mapload, ...)
	. = ..()

	setDir(CalcDir())

	if(!floor)
		switch(dir) //offset to make it be on the wall rather than on the floor
			if(NORTH)
				pixel_y = 32
			if(SOUTH)
				pixel_y = -32
			if(EAST)
				pixel_x = 32
			if(WEST)
				pixel_x = -32
		icon_state = "glowshroom[rand(1,3)]"
	else //if on the floor, glowshroom on-floor sprite
		icon_state = "glowshroomf"

	SetLuminosity(round(potency/15))
	lastTick = world.timeofday

/obj/effect/glowshroom/Destroy()
	SetLuminosity(0)
	. = ..()

/obj/effect/glowshroom/proc/CalcDir(turf/location = loc)
	set background = 1
	var/direction = 16

	for(var/wallDir in cardinal)
		var/turf/newTurf = get_step(location,wallDir)
		if(istype(newTurf, /turf/closed/wall))
			direction |= wallDir

	for(var/obj/effect/glowshroom/shroom in location)
		if(shroom == src)
			continue
		if(shroom.floor) //special
			direction &= ~16
		else
			direction &= ~shroom.dir

	var/list/dirList = list()

	for(var/i=1,i<=16,i <<= 1)
		if(direction & i)
			dirList += i

	if(dirList.len)
		var/newDir = pick(dirList)
		if(newDir == 16)
			floor = 1
			newDir = 1
		return newDir

	floor = 1
	return 1

/obj/effect/glowshroom/attackby(obj/item/W as obj, mob/user as mob)
	..()

	endurance -= W.force

	CheckEndurance()

/obj/effect/glowshroom/ex_act(severity)
	switch(severity)
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if (prob(5))
				deconstruct(FALSE)
				return
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			if (prob(50))
				deconstruct(FALSE)
				return
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			deconstruct(FALSE)
			return
		else
	return

/obj/effect/glowshroom/fire_act(exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		endurance -= 5
		CheckEndurance()

/obj/effect/glowshroom/proc/CheckEndurance()
	if(endurance <= 0)
		qdel(src)
