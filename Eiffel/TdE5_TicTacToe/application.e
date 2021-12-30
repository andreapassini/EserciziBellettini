note
	description: "TICTACTOE application root class"
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
			t: TICTACTOE
			i: INTEGER
		do
			create t.make
			print ("%NNuova partita%N")
			from
				i := 1
			until
				t.is_finished
			loop
				t.play (i.integer_quotient (3) + 1, i.integer_remainder (3) + 1)
				print ("%N" + t.out + "%N")
				i := i + 1
			end
			print ("%NFine partita%N")
		end

end
