
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; int * int * int -> int list
;;  produce a list of ints starting at low and up to and
;;  including high with a step size of stride
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

;; string list * string -> string list
;;  produce the mapping of the suffix onto the end of
;;  each string in the given list
(define (string-append-map xs suffix)
  (
  