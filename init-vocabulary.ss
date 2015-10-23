#!/usr/bin/petite --script

(load "base.ss")
#;
(define vocabulary-list
  '("hello"
    "vancouver"
    "dynamic"
    "represent"
    "behalf"
    "examination"
    "electroencephalogram"
    "guarantee"
    "extremely"
    "romania"
    "process"
    "promise"
    "exit"
    "exist"
    "descend"
    "ascend"
    "common"
    "various"
    "accurate"
    "data"
    "product"
    "project"
    "advance"
    "pronounce"
    "date"
    "progress"
    "congress"
    "formal"
    "behaviour"
    "aggressive"))

(define vocabulary-list
  (get-record-names
   (get-records
    (load-db "data-01"))))

(let loop ((ls vocabulary-list))
  (cond
   ((null? ls)
    (display "done!"))
   (else
    (system (string-append "petite --script search.ss " (car ls)))
    (loop (cdr ls)))))
