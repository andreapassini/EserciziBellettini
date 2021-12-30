note
	description: "Summary description for {SQUARE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SQUARE

inherit
	RECTANGLE
		select
			is_equal
		end

	REGULAR_POLYGON
		rename
			is_equal as is_equal_as_rp
		end

create
	make_with_edge

feature
	make_with_edge (width: REAL)
		do
			make(width, width)
		end
			
end
