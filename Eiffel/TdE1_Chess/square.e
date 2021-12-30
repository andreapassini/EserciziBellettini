note
	description: "Summary description for {SQUARE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SQUARE

inherit
		ANY
		redefine
			out
		end

feature {NONE} -- Access
	presence: detachable PIECE assign set_presence
	-- `presence'

feature -- Element change
	set_presence (a_presence: like presence)
	do
		presence := a_presence
	ensure
		presence_assigned: presence = a_presence
	end

	get_presence: like presence
	do
		Result := presence
	end

feature
	is_occupied: BOOLEAN
	do
		Result := presence /= Void
	end

	out: STRING
	do
		Result := "_"
		if attached presence as p then
		Result := p.out
		end
	end

end
