note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

inherit

	ANY
	redefine
		out
	end

create
	make

feature

	matrix: ARRAY2[SQUARE]

	make
		local
			empty: SQUARE
		do
			create empty
			create matrix.make_filled (empty, 8, 8)
			across
				matrix.lower |..| matrix.height as r
			loop
				across
					matrix.lower |..| matrix.width as c
				loop
					matrix [r.item, c.item] := empty.twin
				end
			end
		end

	to_row_col (code: STRING): TUPLE [r: INTEGER; c: INTEGER]
		require
			is_valid_code (code)
		local
			r, c: INTEGER
		do
			r := code.at (2).difference ('1') + 1
			c := code.at (1).difference ('a') + 1
			Result := [r, c]
		end

	is_available (pos: TUPLE [r: INTEGER; c: INTEGER]): BOOLEAN
		do
			Result := not matrix [pos.r, pos.c].is_occupied
		end
feature

	is_empty (code: STRING): BOOLEAN
		local
			pos: TUPLE [r: INTEGER; c: INTEGER]
		do
			pos := to_row_col (code)
			Result := is_available (pos)
		end

	is_valid_code (code: STRING): BOOLEAN
		local
			r,c: INTEGER
		do
			if not (code.count = 2 and code.at (1).is_alpha and code.at (2).is_digit) then
				Result := False
			else
				r := code.at (2).difference ('1') + 1
				c := code.at (1).difference ('a') + 1
				Result := r >= matrix.lower and r <= matrix.height and c >= matrix.lower and c <= matrix.width
			end
		end

	put (where: STRING; p: PIECE)
		--Punto 3
		require
			-- posizione valida e vuota (per mangiare un pezzo però può non essere vuota!)
			is_valid_code(where)
			-- and is_empty(where)
			-- pezzo valido nulla siccome void safe
		--
		local
			pos: TUPLE [r: INTEGER; c: INTEGER]
		do
			pos := to_row_col (where)
			matrix [pos.r, pos.c].set_presence (p)
		-- Punto 3
		ensure
		--la posizione non è detto fosse già vuota se vi si trovava un pezzo mangiato
			--(old is_empty(where)) and
			not is_empty(where) and get(where) = p
		--
		end

	get (where: STRING): detachable PIECE
		-- Punto 3
		require
			is_valid_code(where)
		--
		local
			pos: TUPLE [r: INTEGER; c: INTEGER]
		do
			pos := to_row_col (where)
			Result := matrix [pos.r, pos.c].get_presence
		-- Punto 3
		-- siccome detachable posso anche ritornare void quindi non garantisco nulla
		--
		end

	remove (where: STRING)
		-- Punto 3
		require
			is_valid_code(where) and not is_empty(where)
		--
		local
			pos: TUPLE [r: INTEGER; c: INTEGER]
		do
			pos := to_row_col (where)
			matrix [pos.r, pos.c].set_presence (Void)
		-- Punto 3
		ensure
			-- rimuovo pezzo e basta
			(old not is_empty(where)) and is_empty(where)
			-- oppure get invece di is_empty
		--
		end

	move (fromw, tow: STRING)
		-- Punto  4
		require
			-- modifica 1
			is_valid_code(fromw) and is_valid_code(tow)
			--
			ok_from: not is_empty (fromw)
			ok_to: is_empty (tow)
			-- modifica 2
			-- da sapere!
			attached get(fromw) as p implies p.is_valid_move (Current, fromw, tow)
			--

		do
			if attached get (fromw) as p then
			remove (fromw)
			put (tow, p)
			end
		ensure
			ok_from: is_empty (fromw)
			ok_to: not is_empty (tow)
		end

	out: STRING
		local
			cname: CHARACTER
			row: INTEGER
		do
			Result := ""
			across
				matrix.lower |..| matrix.height as r
			loop
				row := (matrix.height + matrix.lower) - r.item
				Result := Result + row.out + " "
				across
					matrix.lower |..| matrix.width as c
				loop
					Result := Result + matrix [row, c.item].out + " "
				end
				Result := Result + "%N"
			end
			Result := Result + " "
			across
				matrix.lower |..| matrix.width as c
			loop
				cname := 'a'
				cname := cname.plus (c.item - matrix.lower)
				Result := Result + " "
				Result.append_character (cname)
			end
			Result := Result + "%N"
		end

-- invariant

end
