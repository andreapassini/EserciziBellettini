note
	description: "Summary description for {NEW_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature --Events

	on_prepare
		-- <Precursor>
		do
			create b.make(10)
		end

	b: RING_BUFFER [INTEGER]

feature --Test routines

	test_buffer
		do
				assert("Initial capacity", b.capacity = 10)
				assert("Initial count", b.count = 0)

			b.extend (5)
			b.extend (8)

				assert("Capacity", b.capacity = 10)
				assert("Count", b.count = 2)
				assert("Item", b.item = 5)

			b.remove

				assert("Capacity after remove", b.capacity = 10)
				assert("Count after remove", b.count = 1)
				assert("Item after remove", b.item = 8)

			b.remove

				assert("Capacity after remove 2", b.capacity = 10)
				assert("Count after remove 2", b.count = 0)
		end

	test_queries
		do
			assert("Empty", b.is_empty)
			assert("Not full", not b.is_full)

			across 1 |..| 10 as i loop b.extend (i.item) end

			assert("Not Empty", not b.is_empty)
			assert("Full", b.is_full)

			b.remove
			assert("Not Empty", not b.is_empty)
			assert("Not Full", not b.is_full)
		end

	test_wipe_out
		do
			b.extend (-1)
			b.extend (-2)
			assert("Not Empty", not b.is_empty)
			b.wipe_out
			assert("Empty", b.is_empty)
		end

	test_char
		local
			bs: RING_BUFFER[CHARACTER]
		do
			create bs.make (3)
			bs.extend ('M')
			assert("Count", bs.count = 1)
		end

end
