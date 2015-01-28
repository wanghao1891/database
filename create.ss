#!/usr/bin/petite --script

(load "base.ss")

(define name "data-01")

;The definition of field, '((key html-type) ...)
(create-db name '(id (name text) (pronunciation-uk text) (sound-uk text) (pronunciation-us text) (sound-us text) (definition text) create-time update-time))
