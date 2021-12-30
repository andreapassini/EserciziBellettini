note
	description: "Summary description for {TTT_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTT_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			on_prepare, on_clean
		end

feature {NONE} -- Events

		t: TICTACTOE

		on_prepare
			-- <Precursor>
			do
				create t.make
			end

		on_clean
			-- <Precursor>
			do
				t.restart
			end

feature -- Test routines

	test_v_full
		local
			tmp: TICTACTOE
		do
			create tmp.make_ongoing (<<'.','.','X',
									   '.','.','X',
									   '.','.','X'>>)
			assert ("%N" + tmp.out + "%N v_full not true", tmp.v_full(3, 'X'))
			assert ("%N" + tmp.out + "%N v_full not false", not tmp.v_full(1, 'X'))
			assert ("%N" + tmp.out + "%N X not winner", tmp.is_winner ('X'))
		end

	test_h_full
		local
			tmp: TICTACTOE
		do
			create tmp.make_ongoing (<<'X','X','X',
									   '.','.','O',
									   '.','.','O'>>)
			assert ("%N" + tmp.out + "%N h_full not true", tmp.h_full(1, 'X'))
			assert ("%N" + tmp.out + "%N h_full not false", not tmp.v_full(3, 'X'))
			assert ("%N" + tmp.out + "%N X not winner", tmp.is_winner ('X'))
		end

	test_d_dx_full
		local
			tmp: TICTACTOE
		do
			create tmp.make_ongoing (<<'X','.','.',
									   '.','X','O',
									   '.','.','X'>>)
			assert ("%N" + tmp.out + "%N d_dx_full not true", tmp.d_dx_full(1, 'X'))
			assert ("%N" + tmp.out + "%N d_sx_full not false", not tmp.d_sx_full(3, 'X'))
			assert ("%N" + tmp.out + "%N X not winner", tmp.is_winner ('X'))
		end

	test_d_sx_full
		local
			tmp: TICTACTOE
		do
			create tmp.make_ongoing (<<'O','.','X',
									   '.','X','O',
									   'X','.','X'>>)
			assert ("%N" + tmp.out + "%N d_sx_full not true", tmp.d_sx_full(3, 'X'))
			assert ("%N" + tmp.out + "%N d_dx_full not false", not tmp.d_dx_full(1, 'X'))
			assert ("%N" + tmp.out + "%N X not winner", tmp.is_winner ('X'))
		end

	test_tie
		local
			tmp: TICTACTOE
		do
			create tmp.make_ongoing (<<'X','O','X',
									   'O','X','O',
									   'O','X','O'>>)
			assert ("%N" + tmp.out + "%N not tie", tmp.is_tie)
		end

	test_index
		do
			assert ("%N" + t.out + "%N not available", t.is_available (1, 1))
			assert ("%N" + t.out + "%N not valid", t.is_valid_index (3))
			assert ("%N" + t.out + "%N valid", not t.is_valid_index (4))
		end

	test_is_equal
		local
			a, b, c: TICTACTOE
		do
			create a.make_ongoing (<<'O','.','X',
									 '.','X','O',
									 'X','.','X'>>)
			create b.make_ongoing (<<'O','.','X',
									 '.','X','O',
									 'X','.','X'>>)
			create c.make_ongoing (<<'O','.','X',
									 '.','X','O',
									 'X','O','X'>>)
			assert("a not equal b", a.is_equal(b))
			assert("a equal c", not a.is_equal(c))
		end

end
