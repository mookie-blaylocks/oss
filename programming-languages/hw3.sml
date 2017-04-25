(* Coursera Programming Languages, Homework 3, Provided Code *)

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
fun only_capitals(xs : string list) =
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
val longest_string_helper =
  fn f => fn sl => List.foldl f "" sl;

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
fun rev_string(s : string) =
  "";

(* ('a * 'b option) -> 'a list -> 'b
   produce the first occurence of a value in the 'a list that
   creates SOME value when the function is applied. If each 
   'a list element is NONE, raise NoAnswer exception. *)
fun first_answer(f : 'a * 'b option, xs : 'a list) =
  [];

(* ('a * 'b option) -> 'a list -> 'b list option
   produce SOME map from 'a list to 'b list if
   the function produces SOME value for all 'a.
   Else produce NONE. *)
fun all_answers(f : 'a * 'b option, xs : 'a list) =
  [];
