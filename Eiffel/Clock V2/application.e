note
	description: "CLOCK application root class"
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
		local
		o : CLOCK
			-- Run application.
		do
			--| Add your code here
			print ("Hello Eiffel World!%N")

			create o.make(22, 1)
			print(o.hours)
			print("%N")
			print(o.out)

		end

end
