#lang racket
;; Programming Languages Homework 5 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and, if necessary, change the filename
(require "hw5.rkt")

(require rackunit)

(define tests
  (test-suite
   "Sample tests for Assignment 5"
   
   ;; check racketlist to mupllist with normal list
   (check-equal? (racketlist->mupllist (list (int 3) (int 4)))
                 (apair (int 3) (apair (int 4) (aunit)))
                 "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (var "hi") (var "hello")))
                 (apair (var "hi") (apair (var "hello") (aunit)))
                 "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (var "hi") (list (var "hello") (int 1))))
                 (apair (var "hi") (apair (apair (var "hello")  (apair (int 1) (aunit))) (aunit)))
                 "racketlist->mupllist test")
   
   ;; check mupllist to racketlist with normal list
   (check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (aunit))))
                 (list (int 3) (int 4))
                 "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (apair (var "hi") (apair (var "hello") (aunit))))
                 (list (var "hi") (var "hello"))
                 "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (apair (var "hi")
                                              (apair (apair (var "hello")
                                                            (apair (int 1) (aunit)))
                                                     (aunit))))
                 (list (var "hi") (list (var "hello") (int 1)))
                 "racketlist->mupllist test")
   
   ;; tests if ifgreater returns (int 2)
   (check-equal? (eval-exp (ifgreater (int 3) (int 4) (int 3) (int 2)))
                 (int 2)
                 "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 5) (int 4) (int 3) (int 2)))
                 (int 3)
                 "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 4) (int 4) (int 3) (int 2)))
                 (int 2)
                 "ifgreater test")

   ;; add tests
   (check-equal? (eval-exp (add (int 1) (int 2)))
                 (int 3)
                 "add test")
   (check-equal? (eval-exp (add (int 3) (int 2)))
                 (int 5)
                 "add test")

   ;; int tests
   (check-equal? (eval-exp (int 1))
                 (int 1)
                 "int test")
   (check-equal? (eval-exp (int 0))
                 (int 0)
                 "int test")

   ;; apair tests
   (check-equal? (eval-exp (apair (int 1) (int 2)))
                 (apair (int 1) (int 2))
                 "apair test")
   (check-equal? (eval-exp (apair (int 3) (int 2)))
                 (apair (int 3) (int 2))
                 "apair test")
   
   ;; mlet test
   (check-equal? (eval-exp (mlet "x" (int 1) (add (int 5) (var "x"))))
                 (int 6)
                 "mlet test")
   (check-equal? (eval-exp (mlet "r" (int 6) (add (var "r") (var "r"))))
                 (int 12)
                 "mlet test")
   (check-equal? (eval-exp (mlet "a" (int 1)
                                 (mlet "b" (int 2) (add (var "a") (var "b")))))
                 (int 3)
                 "mlet test")
           
   ;;fst test
   (check-equal? (eval-exp (fst (apair (int 1) (int 2))))
                 (int 1)
                 "fst test")
   (check-equal? (eval-exp (fst (apair (int 3) (int 2))))
                 (int 3)
                 "fst test")
   
   ;;snd test
   (check-equal? (eval-exp (snd (apair (int 1) (int 2))))
                 (int 2)
                 "snd test")
   (check-equal? (eval-exp (snd (apair (int 3) (int 2))))
                 (int 2)
                 "snd test")

   ;; aunit test
   (check-equal? (eval-exp (aunit))
                 (aunit)
                 "aunit test")
   
   ;; isaunit test
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (aunit)))))
                 (int 0)
                 "isaunit test")
   (check-equal? (eval-exp (isaunit (aunit)))
                 (int 1)
                 "isaunit test")

   ;; call test
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x")
                                                               (int 7))))
                                 (int 1)))
                 (int 8)
                 "call test")
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (ifgreater (var "x")
                                                                     (int 5)
                                                                     (int 10)
                                                                     (int 0))))
                                 (int 2)))
                 (int 0)
                 "call test")
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (ifgreater (var "x")
                                                                    (int 5)
                                                                    (int 10)
                                                                    (int 0))))
                                (int 7)))
                (int 10)
                "call test")
   (check-equal? (eval-exp (call (closure (list (cons "x" 2))
                                          (fun #f "x" (add (var "x") (int 7))))
                                 (int 3)))
                 (int 10)
                 "call test")

   (check-equal? (eval-exp (call (closure (list (cons "x" 2))
                                          (fun "sum" "x" (ifgreater (var "x")
                                                                    (int 5)
                                                                    (int 0)
                                                                    (add (var "x")
                                                                         (call (var "sum")
                                                                               (add (var "x")
                                                                                    (int 1)))))))
                                 (int 3)))
                 (int 12)
                 "call test")
                           
   ;; Problem 3
   ;; ifaunit test
   (check-equal? (eval-exp (ifaunit (int 1) (int 2) (int 3)))
                 (int 3)
                 "ifaunit test")
   (check-equal? (eval-exp (ifaunit (aunit) (int 2) (int 3)))
                 (int 2)
                 "ifaunit test")
   
   ;; mlet* test
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10))) (var "x")))
                 (int 10)
                 "mlet* test")
   (check-equal? (eval-exp (mlet* (list (cons "a" (int 4)) (cons "b" (add (int 2)
                                                                          (var "a"))))
                                  (add (var "a") (var "b"))))
                 (int 10)
                 "mlet* test")
   
   ;; ifeq test
   (check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (int 4)))
                 (int 4)
                 "ifeq test")
   (check-equal? (eval-exp (ifeq (int 1) (int 1) (int 2) (int 3)))
                 (int 2)
                 "ifeq test")
   (check-equal? (eval-exp (ifeq (add (int 1) (int 2)) (int 3) (int 4) (int 5)))
                 (int 4)
                 "ifeq test")
   
   ;; mupl-map test
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int 1) (aunit)))) 
                 (apair (int 8) (aunit)) "mupl-map test")
   
   ;; problems 1, 2, and 4 combined test
   ;(check-equal? (mupllist->racketlist
   ;(eval-exp (call (call mupl-mapAddN (int 7))
   ;                (racketlist->mupllist 
   ;                 (list (int 3) (int 4) (int 9)))))) (list (int 10) (int 11) (int 16)) "combined test")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
