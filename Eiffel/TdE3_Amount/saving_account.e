deffered class
    SAVING_ACCOUNT

feature {NONE}
    internal: ACCOUNT

    feature -- Access

        available_amount: INTEGER
        -- Amount available on this account.
        
        balance: INTEGER
        -- Balance of this account.

    feature -- Element change

        deposit (amount: INTEGER)
        -- Deposit `amount' in this account.
        require
            amount_non_negative: amount >= 0
        deferred
        ensure
            balance_set: balance = old balance + amount
        end

    withdraw (amount: INTEGER)
        -- Withdraw `amount' from this account.
        require
            positive_amount: amount > 0
            may_withdraw: amount <= available_amount
        deferred
        ensure
            balance_set: balance = old balance - amount
        end

    feature -- Basic operations

        transfer (amount: INTEGER; other:SAVING_ACCOUNT)
        -- Transfer `amount' from this account to `other'.
        require
            positive_amount: amount > 0
            may_withdraw: amount <= available_amount
            no_aliasing: other /= Current
        deferred
        ensure
            withdrawal_made: balance = old balance - amount
            deposit_made: other.balance = old other.balance + amount
        end

        transfer_account (amount: INTEGER; other: ACCOUNT)
            -- Transfer `amount' from this account to `other'.
            require
                positive_amount: amount > 0
                may_withdraw: amount <= available_amount
            deferred
            ensure
                withdrawal_made: balance = old balance - amount
                deposit_made: other.balance = old other.balance + amount
                other_same_credit_limit: other.credit_limit = old other.credit_limit
            end

invariant
    balance >= 0
    available_amount = balance
    end
end