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
			
		end

end
