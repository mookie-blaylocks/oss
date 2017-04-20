use "hw2.sml";

val test1 = all_except_option("hello", ["hello","my","name","is","Chas"]) = SOME ["my","name","is","Chas"];
val test2 = all_except_option("hello", ["my","name","is"]) = NONE;
val test3 = all_except_option("name", ["my","name","is"]) = SOME ["my","is"];

val test4 = get_substitutions1([["Fred","Frederick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
                               "Fred") = ["Frederick","Freddie","F"];
val test5 = get_substitutions1([["Fred","Frederick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],
                               "Jeff") = ["Jeffrey","Geoff","Jeffrey"];
val test6 = get_substitutions1([["Chas","Chuck","Charlie","Charley","Charles"],["Buckaroo"]],
                               "Chas") = ["Chuck","Charlie","Charley","Charles"];
val test7 = get_substitutions1([["Robert","Bobby","Bob","Rob","Robby"],["Banana","Apple"]],
                               "Nicky") = [];

val test8 = get_substitutions2([["Fred","Frederick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
                               "Fred") = ["Frederick","Freddie","F"];
val test9 = get_substitutions2([["Fred","Frederick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],
                               "Jeff") = ["Jeffrey","Geoff","Jeffrey"];
val test10 = get_substitutions2([["Chas","Chuck","Charlie","Charley","Charles"],["Buckaroo"]],
                               "Chas") = ["Chuck","Charlie","Charley","Charles"];
val test11 = get_substitutions2([["Robert","Bobby","Bob","Rob","Robby"],["Banana","Apple"]],
                               "Nicky") = [];

                                                                                
