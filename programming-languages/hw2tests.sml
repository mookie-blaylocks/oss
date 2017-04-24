use "hw2.sml";

val test1 = all_except_option("hello", ["hello","my","name","is","Chas"]) =
            SOME ["my","name","is","Chas"];
val test2 = all_except_option("hello", ["my","name","is"]) = NONE;
val test3 = all_except_option("name", ["my","name","is"]) =
            SOME ["my","is"];

val test4 = get_substitutions1([["Fred","Frederick"],
                                ["Elizabeth","Betty"],
                                ["Freddie","Fred","F"]],
                               "Fred") =
            ["Frederick","Freddie","F"];
val test5 = get_substitutions1([["Fred","Frederick"],
                                ["Jeff","Jeffrey"],
                                ["Geoff","Jeff","Jeffrey"]],
                               "Jeff") =
            ["Jeffrey","Geoff","Jeffrey"];
val test6 = get_substitutions1([["Chas","Chuck","Charlie","Charley","Charles"],
                                ["Buckaroo"]],
                               "Chas") =
            ["Chuck","Charlie","Charley","Charles"];
val test7 = get_substitutions1([["Robert","Bobby","Bob","Rob","Robby"],
                                ["Banana","Apple"]],
                               "Nicky") = [];

val test8 = get_substitutions2([["Fred","Frederick"],
                                ["Elizabeth","Betty"],
                                ["Freddie","Fred","F"]],
                               "Fred") =
            ["Frederick","Freddie","F"];
val test9 = get_substitutions2([["Fred","Frederick"],
                                ["Jeff","Jeffrey"],
                                ["Geoff","Jeff","Jeffrey"]],
                               "Jeff") =
            ["Jeffrey","Geoff","Jeffrey"];
val test10 = get_substitutions2([["Chas","Chuck","Charlie","Charley","Charles"],
                                 ["Buckaroo"]],
                                "Chas") =
             ["Chuck","Charlie","Charley","Charles"];
val test11 = get_substitutions2([["Robert","Bobby","Bob","Rob","Robby"],
                                 ["Banana","Apple"]],
                               "Nicky") = [];
                                                                                
val test12 = similar_names([["Fred","Fredrick"],
                            ["Elizabeth","Betty"],
                            ["Freddie","Fred","F"]],
                           {first="Fred",middle="W",last="Smith"}) =
             [{first="Fred",last="Smith",middle="W"},
              {first="Fredrick",last="Smith",middle="W"},
              {first="Freddie",last="Smith",middle="W"},
              {first="F",last="Smith",middle="W"}];
val test13 = similar_names([["Jimmy","James","Jim"],
                            ["Rob","Bob","Bobby"]],
                           {first="Rob",middle="James",last="Richardson"}) =
             [{first="Rob",middle="James",last="Richardson"},
              {first="Bob",middle="James",last="Richardson"},
              {first="Bobby",middle="James",last="Richardson"}];

val test14 = card_color(Clubs, Jack) = Black;
val test15 = card_color(Spades, Queen) = Black;
val test16 = card_color(Diamonds, King) = Red;
val test17 = card_color(Hearts, Ace) = Red;

val test18 = card_value(Clubs, Ace) = 11;
val test19 = card_value(Spades, King) = 10;
val test20 = card_value(Diamonds, Queen) = 10;
val test21 = card_value(Hearts, Jack) = 10;
val test22 = card_value(Clubs, Num 9) = 9;
val test23 = card_value(Spades, Num 2) = 2;

val test24 = remove_card([(Clubs, Ace),
                          (Spades, King),
                          (Diamonds, Queen),
                          (Hearts, Jack)],
                         (Clubs, Ace),IllegalMove) =
             [(Spades, King),(Diamonds, Queen),(Hearts, Jack)];
val test25 = remove_card([(Clubs, Ace),
                          (Spades, King),
                          (Diamonds, Queen),
                          (Hearts, Jack)],
                         (Spades, King),IllegalMove) =
             [(Clubs, Ace),(Diamonds, Queen),(Hearts, Jack)];
val test26 = remove_card([(Clubs, Ace),
                          (Spades, King),
                          (Diamonds, Queen),
                          (Hearts, Jack)],
                         (Hearts, Jack),IllegalMove) =
             [(Clubs, Ace),(Spades, King),(Diamonds, Queen)];

val test27 = remove_card([(Clubs, Ace),
                          (Spades, King),
                          (Diamonds, Queen),
                          (Hearts, Jack)],
                         (Clubs, Num 8), IllegalMove) = []
             handle IllegalMove => true;

val test28 = all_same_color([(Clubs, Ace),
                             (Spades, King),
                             (Clubs, Num 4)]) = true;
val test29 = all_same_color([(Clubs, Ace),
                             (Spades, King),
                             (Hearts, Num 4)]) = false;
val test30 = all_same_color([(Diamonds, Ace),
                             (Diamonds, Queen),
                             (Hearts, Num 4)]) = true;
val test31 = all_same_color([(Diamonds, Ace),
                             (Spades, Jack),
                             (Hearts, Num 5)]) = false;
                                
val test32 = sum_cards([]) = 0;
val test33 = sum_cards([(Clubs, Ace),
                        (Diamonds, King),
                        (Spades, Num 5)]) = 26;
val test34 = sum_cards([(Hearts, Queen),
                        (Hearts, Jack),
                        (Hearts, Num 10)]) = 30;
val test35 = sum_cards([(Clubs, Num 2)]) = 2;

val test36 = score([(Clubs, Queen),
                    (Hearts, King)], 4) = 48;
val test37 = score([(Clubs, Queen),
                    (Hearts, King)], 21) = 1;
val test38 = score([(Clubs, Queen),
                    (Spades, King)], 4) = 24;
val test39 = score([(Hearts, Queen),
                    (Diamonds, King)], 22) = 1;
val test40 = score([(Clubs, Num 2),
                    (Hearts, Num 3)], 5) = 0;

