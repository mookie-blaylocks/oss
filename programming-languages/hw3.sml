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
fun only_capitals(sl : string list) =
  [];

(* string list -> string
   produce the string from the list that is the longest. 
   Ties favor the beginning of the string. *)
fun longest_string1(sl : string list) =
  "";

(* string list -> string
   produce the longest string from the given list.
   Ties favor the end of the list. *)
fun longest_string2(sl : string list) =
  "";

(* (int * int -> bool) -> string list -> string
   If given a comparative function, returns the longest string
   in the given list *)
fun longest_string_helper(f : int * int -> bool, sl : string list) =
  "";

(* string list -> string
   Mimic longest_string1 using val bindings and partial
   applications of longest_string_helper *)
fun longest_string3(sl: string list) =
  "";

(* string list -> string
   Mimic longest_string2 using val bindings and partial
   application of longest_string_helper *)
fun longest_string4(sl : string list) =
  "";

(* string list -> string
   produce the longest string in the list that begins with a
   capital letter. Produce "" if there are no such strings. *)
fun longest_capital(sl : string list) =
  "";

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

