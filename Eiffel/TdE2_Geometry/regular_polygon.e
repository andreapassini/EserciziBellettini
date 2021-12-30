note
	description: "Summary description for {REGULAR_POLYGON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REGULAR_POLYGON

inherit
	POLYGON
		redefine
			is_equal
		end

feature
	make_with_edge (edge: REAL)
		deferred
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result := min_edge = other.min_edge
		end

end
