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
fun similar_names(substitutions, full_name:{first:string,middle:string,last:string}) =
  let
      fun helper(first_subs, m, l) =
        case first_subs of
            [] => []
          | f::first_subs' => {first=f, middle=m, last=l}::(helper(first_subs',m,l))
  in
      case full_name of

          {first=f, middle=m, last=l} => let
           val first_subs = f::get_substitutions2(substitutions, f)
       in
           helper(first_subs, m, l)
       end
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

(* card -> color
   produce the color of the given card *)
fun card_color(c : card) =
  case c of
      (Clubs, _) => Black
    | (Spades, _) => Black
    | (Hearts, _) => Red
    | (Diamonds, _) => Red;

(* card -> int
   produce the value of the given card *)
fun card_value(c : card) =
  case c of
      (_, Num i) => i
    | (_, Ace) => 11
    | (_, _) => 10;

(* card list * card * exn -> card list
   produces the card list with the given card removed. If the
   card is not present, the exception is thrown. *)
fun remove_card(cs : card list, c : card, e : exn) =
  let fun helper(cards, rc, found, acc) =
        case cards of
            [] => if found
                  then acc
                  else raise IllegalMove
          | c'::cards' => if c' = rc
                          then helper(cards', (Spades, Num 1), true, acc)
                          else helper(cards', rc, found, acc @ [c'])
  in
      helper(cs, c, false, [])
  end;

(* card list -> bool
   produces true if all cards in the list are of the same color *)
fun all_same_color(cs : card list) =
  case cs of
      [] => true
    | _::[] => true
    | head::(neck::tail) => if card_color(head) = card_color(neck)
                            then all_same_color(neck::tail)
                            else false;

(* card list -> int
   produces the sum of the values of the cards in the list *)
fun sum_cards(cs : card list) =
  let fun helper(cl, acc) =
        case cl of
            [] => acc
          | c::cl' =>  helper(cl', acc + card_value(c))
  in
      helper(cs, 0)
  end;

(* card list * int -> int
   produces the score given the current card list and goal *)
fun score(cs : card list, goal : int) =
  let val cs_value = sum_cards(cs)
      val preliminary = if cs_value > goal
                        then 3 * (cs_value - goal)
                        else goal - cs_value
  in
      if all_same_color(cs)
      then preliminary div 2
      else preliminary
  end;

(* card list * move list * int -> int
   produce the score of a game that starts with the cards ordered
   in card list and the given goal score. The moves in move list
   occur and then the score is calculated. *)
fun officiate(cs : card list, ms : move list, goal : int) =
  let fun draw(deck: card list, hand: card list) =
        case deck of (* can ignore empty case as it is handle by if below *)
          c::deck' => (deck', c::hand)
      fun play (dl : card list, hl : card list, ml : move list, g : int) =
        case ml of
            [] => score(hl, g)
          | (Discard c)::ml' => play(dl, remove_card(hl, c, IllegalMove),
                                     ml', g)
          |  Draw::ml' => if dl = []
                          then score(hl, g)
                          else let val (dl', hl') = draw(dl, hl)
                               in if sum_cards(hl) > goal
                                  then score(hl, g)
                                  else play(dl', hl', ml', g)
                               end
  in
      play(cs, [], ms, goal)
  end
