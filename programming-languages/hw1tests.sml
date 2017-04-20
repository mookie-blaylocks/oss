use "hw1.sml";

val test1 = is_older ((1,2,3),(2,3,4)) = true;
val test2 = is_older ((1,1,3),(1,2,3)) = true;
val test3 = is_older ((1,1,1),(1,1,2)) = true;
val test4 = is_older ((2,3,4),(1,2,3)) = false;

val test5 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1

val test6 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

val test7 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test8 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test9 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there";

val test10 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test11 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3;
val test12 = number_before_reaching_sum (11, [1,2,3,4,5,6,7]) = 4;

val test13 = what_month 70 = 3;
val test14 = what_month 30 = 1;
val test15 = what_month 31 = 1;
val test16 = what_month 32 = 2;

val test17 = month_range (31, 34) = [1,2,2,2]

val test18 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31);
val test19 = oldest([]) = NONE;

val test20 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3;
val test21 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,2,2,3,4]) = 3;

val test22 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test23 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,3,4,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)];

val test24 = reasonable_date((2012,1,14)) = true;
val test25 = reasonable_date((2015,2,29)) = false;
val test26 = reasonable_date((2000,2,29)) = true;
val test27 = reasonable_date((2004,2,29)) = true;
val test28 = reasonable_date((1986,11,30)) = true;
val test29 = reasonable_date((1900,2,29)) = false;
val test30 = reasonable_date((0,2,3)) = false;
