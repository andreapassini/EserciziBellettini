note
    description: "[
        Eiffel trests that can be executed by testing tool. ]"
    author: "EiffelStudio test wizard"
    date: "$Date$"
    revision: "$Revision$"
    testing: "type/normal"
    
    
class
    BOWLING_TEST_SET
    
inherit
    EQA_TEST_SET
        redefine
            on_prepare
        end
        
feature {NONE}

    g: GAME
    
    on_prepare
        do
            Precursor
            create g
        end
        
    roll_many (n, pins: INTEGER)
        require
            positive_n: n > 0
            valid_pins: 0 <= pins and pins <= 10
        local
            i: INTEGER
        do
            from
                i := 0
            until
                i = n
            loop
                g.roll (pins)
                i := i + 1
            end
        ensure
            g.score >= old g.score
        end
        
    roll_spare
        do
            g.roll (5)
            g.roll (5)
        end
        
feature -- Test routines

    test_gutter_game
        local
            g: GAME
            i: INTEGER
        do
            create g
            from
                i := 0
            until
                i = 20
            loop
                g.roll (0)
                i := i + 1
            end
            assert ("Gutter game has non zero score " + g.score.out, g.score = 0)
        end
        
    test_all_ones
        local
            g: GAME
            i: INTEGER
        do
            create g
            from
                i := 0
            until
                i = 20
            loop
                g.roll (1)
                i := i + 1
            end
            assert ("All-ones game has wrong score " + g.score.out, g.score = 20)
        end
        
    test_one_spare
        do
            roll_spare
            g.roll (3)
            roll_many (17)
            assert ("Wrong sapre bonus. Total score " + g.score.out, g.score = 16)
        end
            
    test_one_strike
        do
            g.roll (10)
            g.roll (3)
            g.roll (4)
            roll_many (16, 0)
            assert ("Wrong strike bonus. Total score " + g.score.out, g.score = 24)
        end
            
    test_perferct_game
        do
            roll_many (20, 10)
            assert ("Wrong score in perfect game " + g.score.out, g.score = 300)
        end
end