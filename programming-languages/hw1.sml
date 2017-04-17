(* type date is int * int * int
   interp. year*month*day   *)

(* date * date -> bool 
   produces true if the first date comes before the second *)
fun is_older (date1 : int*int*int, date2 : int*int*int) =
  if ((#1 date1) < (#1 date2))
  then true
  else if ((#1 date1) > (#1 date2))
  then false
  else if ((#2 date1) < (#2 date2))
  then true
  else if ((#2 date1) > (#2 date2))
  then false
  else if ((#3 date1) < (#3 date2))
  then true
  else false;

(* date list * int -> int
   produces the number of dates in the first argument
   that are in the month given by the second argument. *)
fun number_in_month (dates : (int*int*int) list, month : int) =
  if null dates
  then 0
  else if (#2 (hd dates)) = month
  then 1 + number_in_month((tl dates), month)
  else number_in_month((tl dates), month);

(* date list * int list -> int
   produces the number of dates in the first argument
   that are in any of the months given in the second
   argument  *)
fun number_in_months (dates : (int*int*int) list, months : int list) =
  if null months
  then 0
  else number_in_month(dates, (hd months)) +
       number_in_months(dates, (tl months));

(* date list * int -> date list 
   produces the dates in the given list that fall in
   the given month *)
fun dates_in_month (dates : (int*int*int) list, month : int) =
  if null dates
  then []
  else if number_in_month((hd dates) :: [], month) = 1
  then (hd dates) :: dates_in_month((tl dates), month)
  else dates_in_month((tl dates), month)

(* date list * int list -> date list 
   produces the dates in the given list that fall in
   any of the given months *)
fun dates_in_months (dates : (int*int*int) list, months : int list) =
  [];

(* string list * int -> string
   produce the nth element of the list of strings *)
fun get_nth (strings : string list, index : int) =
  "";

(* date -> string 
   produce a string of the form "January 20, 2013" from
   the given date *)
fun date_to_string (date : int*int*int) =
  "";

(* int * int list -> int 
   produce the nth digit of the int list that occurs
   when summing the int list from head to tail that is
   the final int before the sum is greater than the given
   sum *)
fun number_before_reaching_sum (sum : int, num_list : int list) =
  0;

(* int -> int 
   produce the month that a given day of the year falls in. *)
fun what_month (month : int) =
  0;

(* int * int -> int list 
  produce a list detailing which months the days between start
  and end fall into. *)
fun month_range (start_day : int, end_day : int) =
  [];

(* date list -> SOME date 
   produce the oldest date in a list if the list is non-empty
   and NONE if it is empty *)
fun oldest (dates : (int*int*int) list) =
  SOME (0,0,0);

                                                 
