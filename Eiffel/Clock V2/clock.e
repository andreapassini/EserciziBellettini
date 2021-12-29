note
	description: "Summary description for {CLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLOCK

inherit

	ANY
	redefine
		out
	end

create
	make

feature

	hours, minutes: INTEGER

	make (hh, mm: INTEGER)
		do
			hours := hh
			minutes := mm
		ensure
			0 <= hours and hours < 24
			0 <= minutes and minutes < 60
		end

feature

	set_hours (hh: INTEGER)
		require
			0 <= hh and hh < 24
		do
			hours := hh
		ensure
			hours = hh
		end

	set_minutes (mm: INTEGER)
		require
			0 <= mm and mm < 60
		do
			minutes := mm
		ensure
			minutes = mm
		end

feature

	out: STRING
	local
		hh, mm: STRING
	do
	-- twin crea una copia identica
		hh := hours.out.twin
		if hh.count < 2 then hh.prepend ("0")
		end
		mm := minutes.out.twin
		if mm.count < 2 then mm.prepend ("0")
		end
		Result := hh + ":" + mm
	ensure then
		-- Result.count = 5
		check_tokens(Result)
	end

feature
	check_tokens (time_format: STRING): BOOLEAN
	local
		splitted: LIST[STRING]
	do
		splitted := time_format.split (':')
		from
			splitted.start
			Result := True
		until
			splitted.after or Result = False
		loop
			Result := Result and splitted.item.count = 2
			splitted.forth
		end
	end

invariant
	valid_hours: 0 <= hours and hours < 24
	valid_minutes: 0 <= minutes and hours < 60

end
