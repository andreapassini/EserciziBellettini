note
	description: "CHESS application root class"
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
			b: BOARD
			wk, bk: KING
		do
			--| Add your code here
			-- print ("Hello Eiffel World!%N")
			create b.make
			create wk.make ("WHITE")
			create bk.make ("BLACK")
			print ("%N***********************************************%N")
			b.put ("a5", wk)
			b.put ("h3", bk)
			print (b)
			b.move ("a5", "b6")
			print (b)
		end

end
