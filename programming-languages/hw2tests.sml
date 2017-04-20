use "hw2.sml";

val test1 = all_except_option("hello", ["hello","my","name","is","Chas"]) = SOME ["my","name","is","Chas"];
val test2 = all_except_option("hello", ["my","name","is"]) = NONE;
                                                                                
