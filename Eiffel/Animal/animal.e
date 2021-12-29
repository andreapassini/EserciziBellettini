note
	description: "Summary description for {ANIMAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ANIMAL

inherit

	FOOD

feature

	energy: INTEGER

	eat(f: FOOD)
	require
		no_self_eating: f /= Current
	deferred
	ensure
		energy >= old energy
	end


end
