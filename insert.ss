#!/usr/bin/petite --script

;example: petite --script insert.ss data-01 1 Tom 123456

(load "base.ss")

(define name (cadr (command-line)))
(define record (cddr (command-line)))

(define-syntax get-current-date
  (syntax-rules ()
    ((_ e1 ...)
     (let ((d (current-date)))
       (list 'list (e1 d) ...)))))

(define create-time (get-current-date 
		     date-year date-month date-day date-hour date-minute date-second))

(set! record (append (cons 'vector record) (list create-time create-time)))
(insert-record (load-db name) (eval record))

#;
(let* ((d (current-date))
       (year (number->string (date-year d)))
       (month (number->string (date-month d)))
       (day (number->string (date-day d)))
       (hour (number->string (date-hour d)))
       (minute (number->string (date-minute d)))
       (second (number->string (date-second d)))
       (create-time (list 'list year month day hour minute second))
       (db (load-db name)))

  (set! record (append (cons 'vector record) (list create-time create-time)))
  (display record)
					;(eval record)
					;  (define db (load-db name))
  (insert-record db (eval record)))
;(set! record (cons))
;(set! record (eval (cons 'vector (cons record (list create-time create-time)))))

;(define db (load-db name))

;(insert-record db record)



