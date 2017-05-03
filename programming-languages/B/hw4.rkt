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
  (map (lambda (x) (string-append x suffix)) xs))

;; 'a list * int -> 'a
;;  produce the nth element of the list mod the length of
;;  the list
(define (list-nth-mod xs n)
  (letrec ([f (lambda (xs r)
                (if (= r 0)
                    (car xs)
                    (f (cdr xs) (- r 1))))])
    (cond [(< n 0) (error "list-nth-mod: negative number")]
          [(null? xs) (error "list-nth-mod: empty list")]
          [#t (f xs (remainder n (length xs)))])))

;; produce an infinite stream of ones
(define ones (lambda () (cons 1 ones)))

;; produce the stream of natural numbers
(define nats
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;; 'a stream * int -> 'a list
;;  produce the first n elements in a list of the given stream
(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

;; produce the stream of natural numbers except that all numbers
;; divisible by 5 are negated
(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= (remainder x 5) 0)
                                    (* x -1)
                                    x)
                                (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;; produce a stream that alternates between the strings "dan.jpg"
;; and "dog.jpg" starting with "dan.jpg"
(define dan-then-dog
  (letrec ([f (lambda (x) (if (string=? x "dan.jpg")
                              (cons "dog.jpg" (lambda () (f "dog.jpg")))
                              (cons "dan.jpg" (lambda () (f "dan.jpg")))))])
    (lambda () (f "dog.jpg"))))

;; produce a stream that pairs the given string with zeros
(define (stream-add-zero s)
  (letrec ([f (lambda (s) (cons (cons 0 (car (s))) (lambda () (f (cdr (s))))))])
    (lambda () (f s))))

;; list * list -> stream
;;  produce a stream that pairs the lists, cycling through as necessary
(define (cycle-lists xs ys)
  (letrec ([f (lambda (i xs ys) (cons (cons (list-nth-mod xs i)
                                            (list-nth-mod ys i))
                                      (lambda () (f (+ i 1) xs ys))))])
    (lambda () (f 0 xs ys))))

;; int * (int * int) -> (int * int)
;;  produce the first element of the vector where the car is the given
;;  value.
(define (vector-assoc v vec)
  (letrec ([f (lambda (vec i val)
                (cond [(>= i (vector-length vec)) #f]
                      [(and (pair? (vector-ref vec i))
                            (equal? (car (vector-ref vec i)) val))
                       (vector-ref vec i)]
                      [#t (f vec (+ i 1) val)]))])
    (f vec 0 v)))

;; produce a function that takes a single argument and returns the
;; associated value pair from xs. Produce #f if no such pair exists
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n)]
           [oldest 0]
           [f (lambda (v)
                (if (vector-assoc v memo)
                    (vector-assoc v memo)
                    (let ([val (assoc v xs)])
                      (begin
                        (vector-set! memo oldest val)
                        (set! oldest (if (< (+ oldest 1) n)
                                         (+ oldest 1)
                                         0))
                        (assoc v xs)))))])
    f))
                        