#!/usr/bin/petite --script

(load "base.ss")
(define name "data-01")
(create-db name '(id name password))
(define db (load-db name))
(insert-record db (vector 1 "Tom" "123456"))
;(insert-record db (vector 2 "Jerry" "123456"))
(display (get-record db 0))
