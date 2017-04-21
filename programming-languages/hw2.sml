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
fun all_except_option(s, sl) =
  let fun helper(s, sl, found, acc) =
      case sl of
          [] => if found
                then SOME acc
                else NONE
        | str::sl' => if same_string(s, str)
                     then helper(s, sl', true, acc)
                     else helper(s, sl', found, acc @ [str])
  in
      helper(s, sl, false, [])
  end

(* string list list * string -> string list
   produces a list of strings that has all strings that co-occur with the given
   string within sublists of the first argument. *)
fun get_substitutions1(substitutions, s) =
  case substitutions of
      [] => []
    | sl::subs => (case all_except_option(s, sl) of
                        SOME li => li @ get_substitutions1(subs, s)
                      | NONE => get_substitutions1(subs, s));

(* string list list * string -> string list
   produces a list of strings that has all strings that co-occur with the given
   string within any sublist of the first argument. *)
fun get_substitutions2(substitutions, s) =
  let fun helper (subs, s, acc) =
        case subs of
            [] => acc
          | sl::subs' => (case all_except_option(s, sl) of
                              SOME li => helper(subs', s, acc @ li)
                            | NONE => helper(subs', s, acc))
  in
      helper(substitutions, s, [])
  end;

(* string list list * (string * string * string) -> (string * string * string) list
   produces a list of full name records {first, middle, last} using the given
   string list list of substitutions and the given full name record. *)
fun similar_names(substitutions, full_name) =
  let fun helper(firsts, middle, last, acc) =
        case firsts of
            [] => acc
          | first::firsts' => helper(firsts', middle, last,
                                     {first=first, middle=middle, last=last}::acc)
  in
      case full_name of
          {a, b, c} =>
          let
              val first_subs = get_substitutions2(substitutions, a)
              val acc = full_name
          in
              case first_subs of
                  s::firsts => acc :: {first=s, middle=b, 
          end
  end;
                      
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
