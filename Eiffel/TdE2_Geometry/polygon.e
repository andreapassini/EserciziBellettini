note
	description: "Summary description for {POLYGON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	POLYGON

feature
	area: REAL
	deferred
	end

	perimeter: REAL
	deferred
	end

	n_vertices: INTEGER

	max_edge: REAL
	deferred
	end

	min_edge: REAL
	deferred
	end

invariant
	area > 0.0
	perimeter > 0.0
	min_edge <= max_edge
	min_edge > 0.0
	max_edge > 0.0
	n_vertices >= 3

end
