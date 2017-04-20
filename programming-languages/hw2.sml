(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* string * string list -> option string list
   produce SOME string list that is the given string list less the
   given string. Produce NONE if the string is not in the list *)
fun all_except_option(s : string, sl : string list) =
  let fun has_string(s, sl) =
        case sl of
            [] => false
          | str::sl' => if same_string(s, str)
                       then true
                       else has_string(s, sl')
      fun remove_string(s, sl) =
        case sl of
            [] => []
          | str::sl' => if same_string(s, str)
                        then remove_string(s, sl')
                        else str :: remove_string(s, sl')
  in
      if has_string(s, sl)
      then SOME (remove_string(s, sl))
      else NONE
  end

               
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
