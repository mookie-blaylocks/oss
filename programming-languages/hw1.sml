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
  if null months
  then []
  else let fun append (xs : (int*int*int) list, ys : (int*int*int) list) =
             if null xs
             then ys
             else (hd xs) :: append(tl xs, ys)
       in
           append(dates_in_month(dates, (hd months)),
                  dates_in_months(dates, (tl months)))
       end;

(* string list * int -> string
   produce the nth element of the list of strings *)
fun get_nth (strings : string list, index : int) =
  if index = 1
  then (hd strings)
  else get_nth((tl strings), (index - 1));

(* date -> string 
   produce a string of the form "January 20, 2013" from
   the given date *)
fun date_to_string (date : int*int*int) =
  let val months = ["January","February","March","April","May","June","July","August","September","Octobar","November","December"]
  in
      let val month = get_nth(months, (#2 date))
      in
          month ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
      end
  end;
          
(* int * int list -> int 
   produce the nth digit of the int list that occurs
   when summing the int list from head to tail that is
   the final int before the sum is greater than or equal to the given
   sum *)
fun number_before_reaching_sum (sum : int, num_list : int list) =
  if sum > (hd num_list)
  then 1 + number_before_reaching_sum(sum - (hd num_list), (tl num_list))
  else 0;

(* int -> int 
   produce the month that a given day of the year falls in. *)
fun what_month (day : int) =
  let val firsts = [31,28,31,30,31,30,31,31,30,31,30,31]
  in
      1 + number_before_reaching_sum(day, firsts)
  end;

(* int * int -> int list 
  produce a list detailing which months the days between start
  and end fall into. *)
fun month_range (start_day : int, end_day : int) =
  if start_day > end_day
  then []
  else what_month(start_day) :: month_range(start_day + 1, end_day);

(* date list -> date option
   produce the oldest date in a list if the list is non-empty
   and NONE if it is empty *)
fun oldest (dates : (int*int*int) list) =
  if null dates
  then NONE
  else let val tl_dates = oldest(tl dates)
       in if isSome tl_dates andalso is_older(valOf tl_dates, (hd dates))
          then tl_dates
          else SOME (hd dates)
       end;

(* int list -> int list
   produce the given int list with all duplicates removed. *)
fun remove_duplicates( months : int list) =
  let fun is_duplicate(i : int, l : int list) =
        if null l
        then false
        else if (hd l) = i
        then true
        else is_duplicate(i, (tl l))
  in
      if null months
      then []
      else if is_duplicate((hd months), (tl months))
      then remove_duplicates((tl months))
      else (hd months) :: remove_duplicates((tl months))
  end

(* date list * int list -> int
   produces the number of dates in the first argument
   that are in any of the months given in the second
   argument. Duplicated months are not counted. *)
fun number_in_months_challenge(dates : (int*int*int) list, months : int list) =
  number_in_months(dates, remove_duplicates(months));
      
(* date list * int list -> date list 
   produces the dates in the given list that fall in
   any of the given months. Duplicated months will not
   be counted *)
fun dates_in_months_challenge(dates : (int*int*int) list, months : int list) =
  dates_in_months(dates, remove_duplicates(months));

(* date -> bool
   produce true if the given date is a valid date in the
   common era Gregorian calendar *)
fun reasonable_date(date : int*int*int) =
  let val normal_months = [31,28,31,30,31,30,31,31,30,31,30,31];
      val leap_months = [31,29,31,30,31,30,31,31,30,31,30,31];
      fun is_leap_year(year : int) =
        year mod 4 = 0 andalso (year mod 400 = 0 orelse (not (year mod 100 = 0)));
      fun is_month (month : int) =
        month > 0 andalso month < 13;
      fun is_day_in_month(day : int, month : int, months : int list) =
        if month = 1
        then day > 0 andalso day < ((hd months) + 1)
        else is_day_in_month(day, month - 1, (tl months));
  in
      if #1 date < 1
      then false
      else if is_leap_year (#1 date)
      then is_month(#2 date) andalso
           is_day_in_month(#3 date, #2 date, leap_months)
      else is_month(#2 date) andalso
           is_day_in_month(#3 date, #2 date, normal_months)
  end
