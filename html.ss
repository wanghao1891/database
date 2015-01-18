#!/usr/bin/petite --script

(load "base.ss")

(define name "data-01")

(define generate-html
  (lambda (field)
    (cond
     ((null? field) (display "<input type='submit' value='Submit'/>"))
     ((atom? (car field)) (generate-html (cdr field)))
     (else
	   (if (equal? (cadr (car field)) 'text)
	       (begin
		 (display (caar field)) 
		 (display "<input type='text' name='")
		 (display (caar field))
		 (display "' />"))
	       (display "nothing"))
	   (generate-html (cdr field))))))

(display "<html><body><form action='test' method='post'>")
(generate-html (get-field (load-db name)))
(display "</form></body></html>")


