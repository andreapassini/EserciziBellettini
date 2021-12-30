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
	--Punto 2
	--La sostanziale differenza sta nel fatto che con area > 0 come invariante non si possono instanziare oggetti con area negativa
	--mentre come postcondizione della feature area si potrebbero creare oggetti con area negativa ma una volta
	--chiamata la feature area quest'ultima è necessario che renda l'area positiva prima del termine della chiamata
	--altrimenti verrebbe violata la postcondizione
	--
	perimeter > 0.0
	min_edge <= max_edge
	min_edge > 0.0
	max_edge > 0.0
	n_vertices >= 3

end
