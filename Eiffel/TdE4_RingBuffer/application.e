note
	description: "RING_BUFFER application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			o: RING_BUFFER [INTEGER]
		do
			--| Add your code here
			--print ("Hello Eiffel World!%N")
			create o.make(10)
			print(o.capacity)
			print(o.count)

		end

end
