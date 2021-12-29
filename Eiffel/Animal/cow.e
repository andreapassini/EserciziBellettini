note
	description: "Summary description for {COW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COW

inherit
	ANIMAL

feature

	eat(f: GRASS)
		require else
			f.weight >= 10
		do
			if f.weight < 10 then
				f.grow (10)
			end
			f.consume (10)
			energy := energy + 1
		ensure then
			f.weight <= old f.weight
		-- Esempio costrutto rescue (simile a try/catch in Java)
		-- rescue
		--	f.grow (10)
		--	retry
		end


end
