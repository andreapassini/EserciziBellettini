note
	description: "Summary description for {MATRIX_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MATRIX_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_rotate
		local
			matrix: MATRIX_WITH_SYMMETRIES[INTEGER]
			n: INTEGER
		do
			create matrix.make_filled(0, 3, 4)
			across 1 |..| 3 as r loop
				across 1 |..| 4 as c loop
					n := n + 1
					matrix.put (n, r.item, c.item)
				end
			end
			check
				matrix.item (1, 1) = 1
				matrix.item (2, 2) = 6
				matrix.item (3, 3) = 11
			end
			matrix.rotate90
			assert("wrong 1 1 -> " + matrix.item (1, 1).out, matrix.item (1, 1) = 9)
			assert("wrong 2 2 -> " + matrix.item (2, 2).out, matrix.item (2, 2) = 6)
			assert("wrong 3 3 -> " + matrix.item (3, 3).out, matrix.item (3, 3) = 3)
			assert("wrong 4 2 -> " + matrix.item (4, 2).out, matrix.item (4, 2) = 8)
		end

	test_flip_even
		local
			matrix: MATRIX_WITH_SYMMETRIES[INTEGER]
			n: INTEGER
		do
			create matrix.make_filled(0, 3, 4)
			across 1 |..| 3 as r loop
				across 1 |..| 4 as c loop
					n := n + 1
					matrix.put (n, r.item, c.item)
				end
			end
			check
				matrix.item (1, 1) = 1
				matrix.item (2, 2) = 6
				matrix.item (3, 3) = 11
			end
			matrix.flip_columns
			assert("wrong 1 1 -> " + matrix.item (1, 1).out, matrix.item (1, 1) = 4)
			assert("wrong 2 2 -> " + matrix.item (2, 2).out, matrix.item (2, 2) = 7)
			assert("wrong 3 3 -> " + matrix.item (3, 3).out, matrix.item (3, 3) = 10)
		end

	test_flip_odd
		local
			matrix: MATRIX_WITH_SYMMETRIES[INTEGER]
			n: INTEGER
		do
			create matrix.make_filled(0, 3, 3)
			across 1 |..| 3 as r loop
				across 1 |..| 3 as c loop
					n := n + 1
					matrix.put (n, r.item, c.item)
				end
			end
			check
				matrix.item (1, 1) = 1
				matrix.item (2, 2) = 5
				matrix.item (3, 3) = 9
			end
			matrix.flip_columns
			assert("wrong 1 1 -> " + matrix.item (1, 1).out, matrix.item (1, 1) = 3)
			assert("wrong 2 2 -> " + matrix.item (2, 2).out, matrix.item (2, 2) = 5)
			assert("wrong 3 3 -> " + matrix.item (3, 3).out, matrix.item (3, 3) = 7)
		end

end
