;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1
;; a) Write a Racket function racketlist->mupllist that takes a Racket list
;;    and  produces an analogous MUPL list with the same elements in the
;;    same order.
(define (racketlist->mupllist xs)
  (cond [(null? xs) (aunit)]
        [(list? (car xs)) (apair (racketlist->mupllist (car xs))
                                 (racketlist->mupllist (cdr xs)))]
        [(apair (car xs)
                (racketlist->mupllist (cdr xs)))]))

;; b) Write a Racket function mupllist->racketlist that takes a MUPL list
;;    and produces an analogous Racket list with the same elements in the
;;    same order
(define (mupllist->racketlist exp)
  (cond [(aunit? exp) null]
        [(apair? exp) (cons (mupllist->racketlist (apair-e1 exp))
                            (mupllist->racketlist (apair-e2 exp)))]
        [#t exp]))

;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; CHANGE add more cases here
        [(int? e) e]
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (if (> (int-num v1)
                      (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater expected ints to compare")))]
    
        [(fst? e)
         (let ([exp (eval-under-env (fst-e e) env)])
           (if (apair? exp)
               (apair-e1 exp)
               (error "Expected a MUPL pair in fst call")))]
        [(snd? e)
         (let ([exp (eval-under-env (snd-e e) env)])
           (if (apair? exp)
               (apair-e2 exp)
               (error "Expected a MUPLE pair in snd call")))]
        [(apair? e)
         (let ([e1 (eval-under-env (apair-e1 e) env)]
               [e2 (eval-under-env (apair-e2 e) env)])
           (apair e1 e2))]
        [(aunit? e) e]
        [(isaunit? e)
         (let ([unitexp (eval-under-env (isaunit-e e) env)])
           (if (aunit? unitexp) (int 1) (int 0)))]
        [(closure? e) e]
        [(fun? e)
         (closure env e)]
        [(call? e)
         (let ([funexp (eval-under-env (call-funexp e) env)]
               [actual (eval-under-env (call-actual e) env)])
           (if (closure? funexp)
               (let* ([inner-env (closure-env funexp)]
                      [func (closure-fun funexp)]
                      [nameopt (fun-nameopt func)]
                      [formal (fun-formal func)]
                      [body (fun-body func)])
                 (if nameopt
                     (eval-under-env body (cons (cons formal actual)
                                                (cons (cons nameopt funexp)
                                                      inner-env)))
                     (eval-under-env body (cons (cons formal actual) inner-env))))
               (error "MUPL call expected MUPL fun")))]
        [(mlet? e)
         (let ([ext (cons (mlet-var e)
                          (eval-under-env (mlet-e e) env))])
                (eval-under-env (mlet-body e) (cons ext env)))]
        [#t (error (format "bad MUPL expression: ~v" e))]
        ))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3)
  (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst)
      e2
      (mlet (car (car lstlst))
            (cdr (car lstlst))
            (mlet* (cdr lstlst) e2))))

(define (ifeq e1 e2 e3 e4)
  (mlet "_x" e1
        (mlet "_y" e2
              (ifgreater (var "_x") (var "_y") e4
                         (ifgreater (var "_y") (var "_x")
                                    e4
                                    e3)))))
         
;; Problem 4

(define mupl-map
  (fun "mupl-map" "mupl-fun"
       (fun "inner-map" "mupls"
            (ifaunit (var "mupls")
                     (aunit)
                     (apair (call (var "mupl-fun") (fst (var "mupls")))
                            (call (var "inner-map") (snd (var "mupls"))))))))


;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
