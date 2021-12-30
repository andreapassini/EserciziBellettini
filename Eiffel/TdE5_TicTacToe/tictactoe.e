note
	description: "Summary description for {TICTACTOE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TICTACTOE

inherit

	ANY
		redefine
			out, is_equal
		end

create
	make, make_ongoing

feature {NONE} --Inizialization

	make
		do
			create board.make_filled ('.', DIM, DIM)
		ensure
			x_starts: is_turn ('X')
			ongoing: not is_finished
		end

	make_ongoing (b: ARRAY [CHARACTER])
		do
			create board.make_filled ('.', DIM, DIM)
			across
				b as c
			loop
				board.enter (c.item, c.cursor_index)
				if c.item = 'X' or c.item = 'O' then
					turn := turn + 1
				end
			end
		end

feature {TICTACTOE}

	board: MATRIX_WITH_SYMMETRIES [CHARACTER]

	turn: INTEGER

	DIM: INTEGER
		once
			Result := 3
		end

feature {TTT_TEST_SET}

	h_full (row: INTEGER; c: CHARACTER): BOOLEAN
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				Result = False or else not is_valid_index (i)
			loop
				if board [row, i] /= c then
					Result := False
				end
				i := i + 1
			end
		end

	v_full (col: INTEGER; c: CHARACTER): BOOLEAN
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				Result = False or else not is_valid_index(i)
			loop
				if board [i, col] /= c then
					Result := False
				end
				i := i + 1
			end
		end

	d_dx_full (start_col: INTEGER; c: CHARACTER): BOOLEAN
		local
			i, j: INTEGER
		do
			Result := True
			from
				i := start_col
				j := 1
			until
				Result = False or else not is_valid_index(i) or else not is_valid_index(j)
			loop
				if board[i, j] /= c then
					Result := False
				end
				i := i + 1
				j := j + 1
			end
		end

	d_sx_full (start_col: INTEGER; c: CHARACTER): BOOLEAN
		local
			i, j: INTEGER
		do
			Result := True
			from
				i := start_col
				j := 1
			until
				Result = False or else not is_valid_index (i) or else not is_valid_index (j)
			loop
				if board [i, j] /= c then
					Result := False
				end
				i := i - 1
				j := j + 1
			end
		end

feature

	restart
		do
			board.clear_all
			board.fill_with ('.')
		ensure
			x_starts: is_turn ('X')
			ongoing: not is_finished
		end

	is_turn (c: CHARACTER): BOOLEAN
		do
			if c = 'X' then
				Result := turn.integer_remainder (2) = 0
			else
				Result := turn.integer_remainder (2) = 1
			end
		end

	is_winner (who: CHARACTER): BOOLEAN
		do
			Result := across 1 |..| board.width as col some v_full (col.item, who) end
			Result := Result or else across 1 |..| board.height as row some h_full (row.item, who) end
			Result := Result or else d_dx_full (1, who) or else d_sx_full (board.width, who)
		end

	is_tie: BOOLEAN
		do
			Result := turn = board.count and not (is_winner ('X') or is_winner ('O'))
		end

	is_finished: BOOLEAN
		do
			Result := is_winner ('X') or else is_winner ('O') or else is_tie
		end

	play (row, col: INTEGER)
		do
			if is_turn ('X') then
				board [row, col] := 'X'
			else
				board [row, col] := 'O'
			end
			turn := turn + 1
		end

	is_available (row, col: INTEGER): BOOLEAN
		do
			Result := board [row, col] = '.'
		end

	is_valid_index (i: INTEGER): BOOLEAN
		-- True if i can be used as an index to select a row or a column of the board
		do
			Result := board.valid_index (i) and i <= DIM
		end

	is_equal(other: like Current): BOOLEAN
		do
			Result := board.is_equal (other.board)
		end

	out: STRING
		local
			hline: STRING
		do
			Result := ""
			hline := "-"
			hline.multiply (board.width * 2 - 1)
			across
				1 |..| board.height as row
			loop
				across
					1 |..| board.width as col
				loop
					if col.item /= 1 then
						Result.append_character ('|')
					end
					Result.append_character (board[row.item, col.item])
				end
				if row.item /= board.height then
					Result.append_string ("%N" + hline + "%N")
				end
			end
		end

invariant
	two_players: not (is_turn ('X') and is_turn ('O'))
	square_board: board.width = board.height
	turns: board.occurrences ('X') + board.occurrences ('O') = turn

end
