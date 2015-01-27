#!/usr/bin/petite --script

(call/cc
 (lambda (k)
   (* 5 4)))

(call/cc
 (lambda (k)
   (* 5 (k 4))))

(+ 2
   (call/cc
    (lambda (k)
      (* 5 (k 4)))))

(define product
  (lambda (ls)
    (call/cc
     (lambda (break)
       (let f ((ls ls))
	 (cond
	  ((null? ls) 1)
	  ((= (car ls) 0) (break 0))
	  (else (* (car ls) (f (cdr ls))))))))))

(product '())
(product '(1 2 3 4 5))
(product '(7 3 8 0 1 9 5))

(let ((x (call/cc (lambda (k) k))))
  (x (lambda (ignore) "hi")))

(((call/cc (lambda (k) k)) (lambda (x) x)) "HEY!")

(define retry #f)
(define factorial
  (lambda (x)
    (if (= x 0)
	(call/cc (lambda (k) (set! retry k) 1))
	(* x (factorial (- x 1))))))

(factorial 4)
(retry 1)
(retry 2)
(retry 5)
retry

(define lwp-list '())
(define lwp
  (lambda (thunk)
    (set! lwp-list (append lwp-list (list thunk)))))
(define start
  (lambda ()
    (let ((p (car lwp-list)))
      (display "start 1")
      (newline)
      (display "start 1: lwp-list is")
      (display lwp-list)
      (newline)
      (set! lwp-list (cdr lwp-list))
      (display "start 2")
      (newline)
      (display "start 2: lwp-list is ")
      (display lwp-list)
      (newline)
      (p)
      (display "start 3"))))
(define pause
  (lambda ()
    (call/cc
     (lambda (k)
       (lwp (lambda () (k)))
       (display "pause: lwp-list is")
       (display lwp-list)
       (newline)
       (start)
       ))))

(lwp (lambda () (let f () (pause) (display "######") (f))))
(lwp (lambda () (let f () (pause) (display "******") (f))))
;(lwp (lambda () (let f () (pause) (display "y") (f))))
;(lwp (lambda () (let f () (pause) (display "!") (f))))
;(lwp (lambda () (let f () (pause) (newline) (f))))
(start)
;lwp-list

(define tmp-list '())
(define pause-test
  (lambda ()
   (call/cc
    (lambda (k)
      (set! tmp-list (append tmp-list (list (lambda () (* 5 (k 1))))))
      (display "test")))))

(let () 
  (pause-test) 
;  (display "321")
  (+ 1 2)
  )

tmp-list

((car tmp-list))

