145* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* string list -> string list
   produce a list of strings that filters the given list such that
   only the strings beginning with a capital letter are included *)
fun only_capitals ( xs : string list) =
  List.filter (fn x => Char.isUpper( String.sub(x, 0))) xs;

(* string list -> string
   produce the string from the list that is the longest. 
   Ties favor the beginning of the string. *)
fun longest_string1 ( sl : string list ) =
  List.foldl (fn (acc, x) => if String.size acc > String.size x then acc else x)
             "" sl;

(* string list -> string
   produce the longest string from the given list.
   Ties favor the end of the list. *)
fun longest_string2 ( sl : string list ) =
  List.foldl (fn (acc, x) => if String.size x > String.size acc then x else acc)
             "" sl;

(* (int * int -> bool) -> string list -> string
   If given a comparative function, returns the longest string
   in the given list *)
fun longest_string_helper f sl = List.foldl f "" sl;

(* string list -> string
   Mimic longest_string1 using val bindings and partial
   applications of longest_string_helper *)
val longest_string3 = longest_string_helper ( fn ( acc , x ) =>
                                                 if String.size acc > String.size x
                                                 then acc
                                                 else x)

(* string list -> string
   Mimic longest_string2 using val bindings and partial
   application of longest_string_helper *)
val longest_string4 = longest_string_helper (fn (acc, x) =>
                                                if String.size x > String.size acc
                                                then x
                                                else acc)

(* string list -> string
   produce the longest string in the list that begins with a
   capital letter. Produce "" if there are no such strings. *)
val longest_capital = longest_string3 o only_capitals;

(* string -> string
   produce a string that is the reverse of the given string. *)
fun rev_string ( s : string ) =
  String.implode(List.rev(String.explode(s)));

(* ('a * 'b option) -> 'a list -> 'b
   produce the first occurence of a value in the 'a list that
   creates SOME value when the function is applied. If each 
   'a list element is NONE, raise NoAnswer exception. *)
fun first_answer f xs =
  let
      fun helper (f, xs) =
        case xs of
            [] => raise NoAnswer
          | x::xs' => case f x of
                          NONE => helper( f, xs')
                        | SOME v => v
  in
      helper (f, xs)
  end

(* ('a * 'b option) -> 'a list -> 'b list option
   produce SOME map from 'a list to 'b list if
   the function produces SOME value for all 'a.
   Else produce NONE. *)
fun all_answers f xs = 
  let fun helper (f, acc, xs) =
        case xs of
            [] => SOME acc
          | x::xs' => case f x of
                          NONE => NONE
                        | SOME v => helper(f, v::acc, xs')
  in
      helper(f, [], xs)
  end
                                                             
val count_wildcards =
  let
      fun f1 () = 1
      fun f2 x = 0
  in
      g f1 f2
  end

val count_wild_and_variable_lengths =
  let
      fun f1 () = 1
  in
      g f1 String.size
  end

fun count_some_var (s, p) =
  let
      fun f1 () = 0
      fun f2 x = if x = s then 1 else 0
  in
      g f1 f2 p
  end

(* pattern -> bool
   return true if all Variable type patterns have unique strings *)
fun check_pat p =
  let
      (* pattern -> string list
         take a pattern and return the list of all strings used in 
         variables *)
      fun variable_strings acc p =
        [""];
      (* string list -> bool
         take a list of strings and decide if it has repeats *)
      fun no_repeats (sl : string list)=
        case sl of
            s::t::[] => if s = t
                        then false
                        else true
         | s::(t::sl') => if s = t
                         then false
                          else no_repeats (s::sl') andalso no_repeats (t::sl')
         | _ => true
      val sl = variable_strings [] p
  in
      no_repeats sl
  end

(* (valu * pattern) -> (string * valu) list option 
   *)
fun match v p = NONE;

fun first_match v p = NONE;

  
                       
