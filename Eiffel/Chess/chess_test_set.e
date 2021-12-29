note
	description: "Summary description for {CHESS_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHESS_TEST_SET

inherit
	EQA_TEST_SET
	redefine
		on_prepare
	end

feature {NONE} -- Events
	b: BOARD
	wk, bk: KING

	on_prepare
		do
			create b.make
			create wk.make ("WHITE")
			create bk.make ("BLACK")
		end

feature -- Test routines
	test_valid_move
		do
			b.put ("b5", wk)
			assert ("b6", wk.is_valid_move (b, "b5", "b6"))
			assert ("c6", wk.is_valid_move (b, "b5", "c6"))
			assert ("c5", wk.is_valid_move (b, "b5", "c5"))
			assert ("c4", wk.is_valid_move (b, "b5", "c4"))
			assert ("b4", wk.is_valid_move (b, "b5", "b4"))
			assert ("a4", wk.is_valid_move (b, "b5", "a4"))
			assert ("a5", wk.is_valid_move (b, "b5", "a5"))
			assert ("a6", wk.is_valid_move (b, "b5", "a6"))
			assert ("b5", not wk.is_valid_move (b, "b5", "b5"))
			assert ("b7", not wk.is_valid_move (b, "b5", "b7"))
			assert ("b5 from b6", not wk.is_valid_move (b, "b6", "b5"))
			b.put ("b6", bk)
			assert ("b6", not wk.is_valid_move (b, "b5", "b6"))
		end

	test_board
		do
			assert ("Initially empty", b.is_empty ("b5"))
			b.put ("b5", wk)
			assert ("Not empty", not b.is_empty ("b5"))
		end

end
