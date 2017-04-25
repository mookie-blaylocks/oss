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
                                       
