#!/usr/bin/petite --script

(load "base.ss")

(define name "data-01")

(define generate-html
  (lambda (field)
    (cond
     ((null? field) (display "<input type='button' value='OK'/>"))
     ((atom? (car field)) (generate-html (cdr field)))
     (else (begin
	     ;(display (cadr (car field)))
	     (if (equal? (cadr (car field)) 'text)
		 (begin
		   (display (caar field)) 
		   (display "<input type='text'/>"))
		 (display "nothing"))
	     (generate-html (cdr field)))))))

(generate-html (get-field (load-db name)))


