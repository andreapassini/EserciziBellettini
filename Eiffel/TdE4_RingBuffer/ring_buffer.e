note
	description: "Summary description for {RING_BUFFER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

--FIFO queue implemented as a {RING_BUFFER} of elements of type {G}.
--The ring buffer uses two indexes for the first element and the next free slot of the buffer.
--The "Always keep one slot open" technique is used to distinguish between empty and full buffers.

class
	RING_BUFFER [G]

create
	make

feature --Inizialization

	make (n: INTEGER)
		--Initialize empty buffer with capacity 'n'
		note
			status: creator
		require
			n_positive: n > 0
		do
			create data.make_empty
			data.grow (n + 1) --one slot more
			data.trim
			start := 1
			free := 1
			create model.make (n)
		ensure
			empty_buffer: is_empty
			capacity: capacity = n
		end

feature --Access

	item: G
		--Current item of buffer
		require
			not is_empty
		do
			Result := data[start]
		ensure
			Result = data[start]
		end

	count: INTEGER
		--Number of items in buffer
		require
		    -- può essere attivata in qualsiasi stato valido dell'oggetto
		do
			if free >= start then
				Result := free - start
			else
				Result := data.count - start + free
			end
		ensure
            valid_count: Result >= 0 and Result <= capacity
            implementation_ok: (free >= start implies Result = free - start)
            and (free < start implies Result = data.count - start + free)
		end

	capacity: INTEGER
		--Maximum capacity of buffer
		do
			result := data.count - 1
		ensure
			Result = data.count - 1
		end

feature --Status report

	is_empty: BOOLEAN
		--Is buffer empty?
		require
	        -- può essere chimata in tutti gli stati validi di ring buffer
		do
			Result := (start = free)
		ensure
            -- Se non posso utilizzare start e free
            -- posso usare count
            Result = (count = 0)
		end

	is_full: BOOLEAN
		--Is buffer full?
		do
			if start = 1 then
				Result := (free = data.count)
			else
				Result := (free = start - 1)
			end
		ensure
		    Result = (count = capacity)
		end

feature --Element change

	extend (a_value: G)
		--Add 'a_value' to end of buffer
		require
			not is_full
		do
			data[free] := a_value
			if free = data.count then
				free := 1
			else
				free := free + 1
			end
			model.extend (a_value)
		ensure
		    extended: count = old count + 1
		    data.has (a_value)
		    fifo: item = model.item
		end

	remove
		--Remove current item from buffer
		require
			not is_empty
		do
			if start = data.count then
				start := 1
			else
				start := start + 1
			end
			model.remove
		ensure
		    -- il numero di elementi è diminuito
		    count = old count - 1
		end

	wipe_out
		--Remove all elements from buffer
		do
			start := free
		ensure
			is_empty
		end

feature --Implementation

	data: ARRAY [G]
		-- Array used to store data

	start: INTEGER
		-- Index of first element

	free: INTEGER
		-- Index of next free position
		
    model: BOUNDED_QUEUE[G]
        -- Aggiunto per imporre la politica FIFO

invariant
	data_not_void: data /= void
    -- altri invariant
    -- quello di count
    start_in_bounds: data.valid_index (start)
    free_in_bounds: data.valid_index (free)
    positive_capacity: capacity > 0
    not_both_empty_full: not (is_empty and is_full)
end
