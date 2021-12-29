note
	description: "Summary description for {KING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KING

inherit
	PIECE
		redefine
			make,
			out
		end

create
	make

feature {NONE}
	repr: STRING

feature
	make (player: STRING)
		do
			name := "KING"
			repr := "UNICODE"
			if player.as_upper.is_equal ("SINGLE") then
			repr := "ASCII"
			color := "WHITE"
			else
			color := player.as_upper
			end
		end

	is_valid_move (board: BOARD; from_code, to_code: STRING): BOOLEAN
		local
			delta_x, delta_y: INTEGER
		do
			delta_x := to_code.at (2).difference(from_code.at (2)).abs
			delta_y := to_code.at (1).difference(from_code.at (1)).abs
			Result := board.is_empty (to_code) and then ((delta_x = 1) or (delta_y = 1))
		end

	out: STRING
		local
			u: UTF_CONVERTER
		do
			Result := u.string_32_to_utf_8_string_8({STRING_32} "K")
			if color.is_equal ("BLACK") then
			Result := u.string_32_to_utf_8_string_8({STRING_32} "k")
			end
			if repr.is_equal ("ASCII") then
			Result := "K"
			end
		end

end
