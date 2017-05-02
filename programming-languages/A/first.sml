(* This is a comment. This is our first program *)

val x = 34;
(* static environment: x : int *)
(* dynamic environment: x --> 34 *)

val y = 17;
(* static environment: x : int, y : int *)
(* dynamic environment: x --> 34, y --> 17 *)

val z = (x + y) + (y + 2);
(* static environment: x : int, y : int, z : int *)                      
(* dynamic environment: x --> 34, y --> 17, z --> 70 *)

val q = z + 1;
(* static environment: x : int, y : int, z : int, y : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70, w --> 71 *)

val abs_of_z = if z < 0 then 0 - z else z; (* bool *)
(* static environment: abs_of_z: int *)
(* dynamic environment: ... abs_of_z ---> 70 *)

val a = 10;

(* a : int
   a -> 10 *)

val b = a * 2;
(* b -> 20 *)

val a = 5; (* not an assignment statement *)
(* a -> 5, b -> 20  *)

val c = b;
(* a -> 5, b -> 20, c -> 20 *)

val d = a;
(* ... d -> 5 *)

val a = a + 1;
(**)
