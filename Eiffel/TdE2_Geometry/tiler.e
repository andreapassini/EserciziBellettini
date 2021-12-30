note
	description: "Summary description for {TILER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TILER

create
	make

feature --inizialization
	make
		do
			--inizialization for 'Current'.
			create tiles.make
		end

	full: BOOLEAN
		do
			Result := tiles.full
		end

	count: INTEGER
		do
			Result := tiles.count
		end

	add(p: POLYGON)
		require
			not full
		do
			tiles.extend (p)
		ensure
			tiles.count = old tiles.count + 1
		end

	--Punto 5
	--aggiunta per controllo precondizione tiled_square
	check_tiles: BOOLEAN
		local
			i: INTEGER
		do
			if tiles.count = 0 then Result := False
			end
			from
				i := 0
			until
				i = tiles.count - 1
			loop
				if (tiles.at (i).n_vertices /= 4 or tiles.at (i).max_edge /= tiles.at (i).min_edge
						or (tiles.count.to_real / (tiles.count.to_real.power (0.5))) /= 0.) then Result := False
				end
				i := i + 1
			end
			Result := True
		end
	--

	tiled_square: SQUARE
		--Punto 5
		require
			--check_tiles aggiunta per controllo come feature aggiuntiva
			tiles.count > 0 and check_tiles = True
			--infine le precondizioni dovrebbero essere garantite dal client/utente quando crea la lista tiles
		--
		do
			--fake implementation
			create Result.make_with_edge (42)
		ensure
			no_sovrappositions: Result.area = total_area
			tiling: Result.perimeter <= total_perimeter
		end

	total_area: REAL
		do
			across
				tiles as t
			from
				Result := 0
			loop
				Result := Result + t.item.area
			end
		ensure
			Result > 0.
		end

	total_perimeter: REAL
		do
			across
				tiles as t
			from
				Result := 0
			loop
				Result := Result + t.item.perimeter
			end
		ensure
			Result > 0.
		end

	all_squares: BOOLEAN
		do
			Result := across tiles as t all t.item.n_vertices = 4 and t.item.max_edge = t.item.min_edge end
		end

	all_equals: BOOLEAN
		do
			Result := across tiles as t all t.item.is_equal (tiles.first) end
		end

feature
	tiles: LINKED_LIST [POLYGON]

invariant
	count >= 0

end
