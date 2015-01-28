#!/usr/bin/petite --script

(load "base.ss")
(define name "data-01")
(define db (load-db name))

(define show
  (lambda (records)
    (display "{\"vocabulary\":[")
    (map
     (lambda (record)
       (display "{\"name\":\"")
       (display (vector-ref record 1))
       (display "\",\"pronunciation_uk\":\"")
       (display (vector-ref record 2))
       (display "\",\"sound_uk\":\"")
       (display (vector-ref record 3))
       (display "\",\"pronunciation_us\":\"")
       (display (vector-ref record 4))
       (display "\",\"sound_us\":\"")
       (display (vector-ref record 5))
       (display "\"},")
       ) 
     records)
    (display "{}]}")))

(show (get-records db))
