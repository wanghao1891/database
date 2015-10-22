#!/usr/bin/petite --script

(load "base.ss")
(define name "data-01")
(define db (load-db name))

(define show-ascend
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

(define my-vector-ref
  (lambda (record number)
    (if (> (vector-length record) number)
        (if (or (string? (vector-ref record number))
                (number? (vector-ref record number)))
            (vector-ref record number)
            "")
        "")))

(define show-descend
  (lambda (records)
    (string-append
     "{\"vocabulary\":["
     (let loop ((ls records))
       (cond
        ((null? ls) "{}]}")
        (else
         (let ((record (car ls)))
           (string-append "{\"name\":\"" (my-vector-ref record 1)
                          "\",\"pronunciation_uk\":\"" (my-vector-ref record 2)
                          "\",\"sound_uk\":\"" (my-vector-ref record 3)
                          "\",\"pronunciation_us\":\"" (my-vector-ref record 4)
                          "\",\"sound_us\":\"" (my-vector-ref record 5)
                          "\",\"definition\":\"" (my-vector-ref record 6)
                          "\"},"
                          (loop (cdr ls))))))))))

(display (show-descend (get-some-records db 20)))
