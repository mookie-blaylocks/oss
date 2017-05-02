use "hw3.sml";

val test1 = only_capitals(["Chas","Louise","Drew","mouse","Katje"]) =
            ["Chas","Louise","Drew","Katje"];
val test2 = only_capitals(["house","louse","grouse","mouse"]) =
            [];
val test3 = only_capitals(["hello","Jupiter","goodbye"]) =
            ["Jupiter"];

val test4 = longest_string1(["Chas","Drew","Louise","Katje"]) = "Louise";
val test5 = longest_string1(["","",""]) = "";
val test6 = longest_string1(["Chas","Drew","Bill"]) = "Chas";

val test7 = longest_string2(["Chas","Drew","Louise","Snufle"]) = "Snufle";
val test8 = longest_string2(["Chas","Drew","Cole"]) = "Cole";

val test9 = longest_string3(["Chas","Drew","Louise","Katje"]) = "Louise";
val test10 = longest_string3(["","",""]) = "";
val test11 = longest_string3(["Chas","Drew","Bill"]) = "Chas";

val test12 = longest_string4(["Chas","Drew","Louise","Snufle"]) = "Snufle";
val test13 = longest_string4(["Chas","Drew","Cole"]) = "Cole";

val test14 = longest_capital(["Chas","hello","goodbye"]) = "Chas";
val test15 = longest_capital(["Chas","Drew","goobye"]) = "Chas";
val test16 = longest_capital(["hello","goodbye"]) = "";
val test17 = longest_capital(["Chas","Louise","goodbye"]) = "Louise";

val test18 = rev_string("Chas") = "sahC";
val test19 = rev_string("Louise") = "esiuoL";
val test20 = rev_string("Happy little bears") = "sraeb elttil yppaH";

fun helper (s) =
  case s of
      "" => NONE
    | s => SOME s
                
val test22 = first_answer helper ["","",""] = ""
             handle NoAnswer => true;
val test23 = first_answer helper ["","Chas","Louise"] = "Chas";

val test24 = all_answers helper ["Chas","Louise","Drew"] =
             SOME ["Drew","Louise","Chas"];
val test25 = all_answers helper ["Chas","Louise",""] = NONE;
                                       
val test26 = count_wildcards(Wildcard) = 1;
val test27 = count_wildcards(UnitP) = 0;
val test28 = count_wildcards(TupleP [Wildcard,
                                     ConstP 2,
                                     Wildcard]) = 2;
val test29 = count_wildcards(ConstructorP ("SOME", TupleP [Variable "x",
                                                           ConstP 3,
                                                           Wildcard])) = 1;

val test30 = count_wild_and_variable_lengths(Wildcard) = 1;
val test31 = count_wild_and_variable_lengths(Variable "hello") = 5;
val test33 = count_wild_and_variable_lengths(TupleP [Wildcard,
                                                     Variable "hello",
                                                     UnitP,
                                                     ConstP 8]) = 6;
val test34 = count_wild_and_variable_lengths(ConstructorP ("SOME",
                                                           TupleP [Variable "x",
                                                                   ConstP 3,
                                                                   Wildcard])) = 2;
                                             
val test35 = count_some_var("hello", Wildcard) = 0;
val test36 = count_some_var("hello", Variable "hello") = 1;
val test37 = count_some_var("hello", TupleP [Wildcard,
                                             Variable "hello",
                                             Variable "hello",
                                             UnitP,
                                             Variable "hello"]) = 3;
val test38 = count_some_var("hello", ConstructorP ("SOME",
                                                   TupleP [Variable "hello",
                                                           ConstP 3,
                                                           Wildcard])) = 1;

val test39 = check_pat(Wildcard) = true;
val test40 = check_pat(Variable "hello") = true;
val test41 = check_pat(TupleP [Wildcard,
                               Variable "Hello",
                               UnitP,
                               Variable "hello"]) = false;
val test42 = check_pat(TupleP [Wildcard,
                               Variable "Hellope",
                               UnitP,
                               Variable "hello"]) = false;
val test43 = check_pat(ConstructorP ("SOME",
                                     TupleP [Variable "hello",
                                             ConstP 3,
                                             Wildcard,
                                             Variable "hello"])) = false;
val test44 = check_pat(ConstructorP ("SOME",
                                     TupleP [Variable "hello",
                                             ConstP 3,
                                             Wildcard])) = true;
          
                                                     
