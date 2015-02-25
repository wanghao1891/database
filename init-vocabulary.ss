#!/usr/bin/petite --script

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

(let loop ((ls vocabulary-list))
  (cond
   ((null? ls)
    (display "done!"))
   (else
    (system (string-append "petite --script search.ss " (car ls)))
    (loop (cdr ls)))))
