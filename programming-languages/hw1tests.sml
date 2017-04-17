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

val test11 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val test12 = what_month 70 = 3

val test13 = month_range (31, 34) = [1,2,2,2]

val test14 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
