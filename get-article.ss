#!/usr/bin/petite --script

(load "base.ss")
(define name "article")
(define db (load-db name))

(define show-descend
  (lambda (records)
    (string-append "{\"article\":["
		   (let loop ((ls records))
		     (cond
		      ((null? ls) "{}]}")
		      (else
		       (let ((record (car ls)))
			 (string-append "{\"name\":\"" (vector-ref record 1)
					"\",\"path\":\"" (vector-ref record 2)
					"\"},"
					(loop (cdr ls))))))))))

(display (show-descend (get-records db)))
