note
	description: "Summary description for {ACCOUNT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACCOUNT

create
	make

feature --Inizialitazion

	make
		--Initialize empty account
		do
			balance := 0
			credit_limit := 1000
		ensure
			balance_set: balance = 0
			credit_limit_set: credit_limit = 1000
		end

	make (b, c_l: INTEGER)
		do	
			balance := b
			credit_limit := c_l
		ensure
			balance_set: balance = b
			credit_limit_set: credit_limit = c_l
		end


feature --Access

	credit_limit: INTEGER
		--Credit limit of this account

	available_amount: INTEGER
		--Amount available on this account
		do
			Result := balance + credit_limit
		end

	balance: INTEGER
		--Balance of this account

feature --Element change

	set_credit_limit (limit: INTEGER)
		--Set 'credit limit' to 'limit'
		require
			limit >= (0).max (- balance)
		do
			credit_limit := limit
		ensure
			credit_limit_set: credit_limit = limit
		end

	deposit (amount: INTEGER)
		-- Deposit 'amount' in this account
		require
			amount_non_negative: amount >= 0
		do
			balance := balance + amount
		ensure
			balance_set: balance = old balance + amount
		end

	withdraw (amount: INTEGER)
		--Withdraw 'amount' from this account
		require
			positive_amount: amount > 0
			may_withdraw: amount <= available_amount
		do
			balance := balance - amount
		ensure
			balance_set: balance = old balance - amount
		end

feature --Basic operations

	transfer (amount: INTEGER; other: ACCOUNT)
		--Transfer 'amount' from this account to 'other' account
		require
			positive_amount: amount > 0
			may_withdraw: amount <= available_amount
			no_aliasing: other /= Current
		do
			balance := balance - amount
			other.deposit (amount)
		ensure
			withdrawal_made: balance = old balance - amount
			deposit_made: other.balance = old other.balance + amount
			same_credit_limit: credit_limit = old credit_limit
			other_same_credit_limit: other.credit_limit = old other.credit_limit
		end

feature

	log_balance
		local
			log: PLAIN_TEXT_FILE
		do
			create log.make_open_append ("account.log")
			log.put_string ("Balance is: " + balance.out + "%N")
			--The next operation fails
			check
				-- failure
				False
			end
		end


feature -- Punto 3

	merge (a, b: ACCOUNT)
	-- balance somma dei balance
	-- credit_limit il > dei 2
	require
		a.credit_limit > 0
		a.balance >= - a.credit_limit
		b.credit_limit > 0
		b.balance >= - b.credit_limit
		a.balance + b.balance >= - (a.credit_limit).max(b.credit_limit)
		a /= b
	local
		_balance: INTEGER
		_credit_limit: INTEGER
	do
		-- mi serve un nuovo costruttore
		_balance := a.balance + b.balance

		if a.credit_limit > b.credit_limit
		then
			_credit_limit := a.credit_limit
		else
			_credit_limit := b.credit_limit

		create c.make(_balance, _credit_limit)
	ensure
		sum_balance: c.balance = (a.balance + b.balance)
		max_credit_limit: c.credit_limit = (a.balance).max(b.balance)
	end


invariant
	credit_limit_not_negative: credit_limit > 0
	balance_not_below_credit: balance >= - credit_limit

end
