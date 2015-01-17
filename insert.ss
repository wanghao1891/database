#!/usr/bin/petite --script

;example: petite --script insert.ss data-01 1 Tom 123456

(load "base.ss")

(define name (cadr (command-line)))
(define record (cddr (command-line)))

(set! record (eval (cons 'vector record)))

(define db (load-db name))

(insert-record db record)


