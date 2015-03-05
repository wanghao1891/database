#!/usr/bin/petite --script

(load "base.ss")

(define name "data-01")

;The definition of field, '((key html-type) ...)
;The sample, #("data-01" (id (name text) (pronunciation-uk text) (sound-uk text) (pronunciation-us text) (sound-us text) (definition text) create-time update-time) (#(1 "hello" "%68%C9%99%CB%88%6C%C9%99%CA%8A" "file?media/english/uk_pron/h/hel/hello/hello__gb_1.mp3" "%68%C9%99%CB%88%6C%6F%CA%8A" "file?media/english/us_pron/h/hel/hello/hello__us_1.mp3" "definition")))
(create-db name '(id (name text) (pronunciation-uk text) (sound-uk text) (pronunciation-us text) (sound-us text) (definition text) create-time update-time))
