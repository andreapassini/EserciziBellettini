note
	description: "Summary description for {GRASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRASS

inherit
	FOOD
	redefine
		out
	end

feature

	weight: INTEGER

	out: STRING
		do
			Result := "Grass : " + weight.out + "kg"
		end

	consume (q: INTEGER)
		require
			q > 0
			weight >= q
		do
			weight := weight - q
		ensure
			weight = old weight - q
		end

	grow (q: INTEGER)
		require
			q > 0
		do
			weight := weight + q
		ensure
			weight = old weight + q
		end

invariant

	weight >= 0

end
