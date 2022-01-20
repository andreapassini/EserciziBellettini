note
	description: "ACCOUNT application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			--| Add your code here
			print ("Hello Eiffel World!%N")

			-- a.transfer(-1, b)
			-- Non puo' essere eseguita perche':
			-- Pre-condizione
			-- 		positive_amount: amount > 0

			-- a.transfer(100, b)
			-- e' possibile farlo perche':
			--		amount > 0
			--		il destinatario del transfer e' /= a
			--		ammount < (balance + credit_limit)

			-- a.transfer(100, a)
			-- non e' possibile perche':
			--		il destinatario e' = a

			-- a.transfer(100, a.twin)
			--	DOVREBBE essere possibile perche':
			--		amount < (balance + credit_limit)
			--		amount > 0
			--		a.twin creerebbe un oggetto identico ad a, un gemello,
			-- 		ma non dovrebbe essere lo stesso oggetto
			-- 		a /= a.twin

			-- b.transfer(b.balance, a)
			-- 	NON E' POSSIBILE perche':
			--		amount non e' > 0 
			--			dato che quando inizializzato balance = 0

			-- Punto 2
			-- We need to take in consideration:
			--	Pre
			--	Post
			--	Invariant

			create a.make
			--	by default:
			--		a.balance = 0
			--		a.credit_limit = 1000
			--	invariant:
			--		a.credit_limit > 0
			--		a.balance >= - a.credit_limit

			-- Pre
			--		X >= (0).max (- balance)
			--		cioe': X >= 0
			a.set_credit_limit (X)
			--	a.credit_limit = X
			-- 	a.credit_limit > 0
			--	a.balance >= - a.credit_limit
			--		==>>  X > 0 

			-- Pre
			--		W > 0
			--		W <= a.available_amount
			--		quindi:
			--			W <= a.balance + a.credit_limit
			--			quindi
			--				W <= 0 + X
			a.withdraw (W)
			--	a.balance = balance - W
			--	quindi
			--		a.balance = 0 - W
			-- Invariant
			-- 		a.credit_limit > 0
			--		a.balance >= - a.credit_limit
			--		quindi
			-- 			-W >= -X
			--			quindi
			--				W <= X

			-- Pre
			--		Y >= (0).max (-balance)
			--		quindi
			--			Y >= (0).max (-(-W))
			--			quindi
			--				Y >= W (perche' W > 0)
			a.set_credit_limit (Y)
			--	a.credit_limit = Y
			--	a.credit_limit > 0
			-- 	Invariant
			--		a.balance >= - a.credit_limit
			
			-- Pre
			--		Z > 0
			--		Z <= a.available_amount
			--		quindi
			--			Z <= a.balance + a.credit_limit
			--			quindi
			--				Z <= -W + Y
			a.withdraw (Z)
			--	a.balance = balance - Z
			--	quindi
			--		a.balance = - W - Z
			-- 	Invariant
			-- 		a.credit_limit > 0
			--		a.balance >= - a.credit_limit
			--		quindi
			-- 			- W - Z >= - Y
			--			quindi
			--				W + Z <= Y

			-- 	X > 0
			--	W > 0
			--	W <= X
			-- 	Y >= W
			--	Z > 0
			--	Z <= - W + Y
			--	quindi
			--		W > 0
			--		X >= W
			--		Z > 0
			--		Y >= Z + W
			-- a.balance = - (W + Z)
		end

end
