#!/usr/bin/petite --script

(load "base.ss")

(define name "data-01")
;(create-db name '(id name password))
(create-db name '(id name pronunciation sound definition create-time update-time))
