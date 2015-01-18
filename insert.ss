#!/usr/bin/petite --script

;example: petite --script insert.ss data-01 1 Tom 123456

(load "base.ss")

(define name (cadr (command-line)))
(define record (cddr (command-line)))

;'list, because need to eval record. 
(define-syntax get-current-date
  (syntax-rules ()
    ((_ e1 ...)
     (let ((d (current-date)))
       (list 'list (e1 d) ...)))))

(define create-time (get-current-date 
		     date-year date-month date-day date-hour date-minute date-second))

(define db (load-db name))
(define id (+ 1 (get-latest-id db)))
(set! record (append 
	      (cons 'vector 
		    (cons id record)) 
	      (list create-time create-time)))
(insert-record db (eval record))


