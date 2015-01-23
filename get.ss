#!/usr/bin/petite --script

(load "base.ss")
(define name "data-01")
;(create-db name '(id name password))
(define db (load-db name))
;(insert-record db (vector 1 "Tom" "123456"))
;(insert-record db (vector 2 "Jerry" "123456"))
;(display (get-record db 0))

(define show
  (lambda (records)
    (display "{\"vocabulary\":[")
    (map
     (lambda (record)
       ;(display "<script>function Play(soundobj) {var thissound=document.getElementById(soundobj);thissound.play();}</script>")
       ;(display "<a href=\"javascript:Play('hello')\">")
       (display "{\"name\":\"")
       (display (vector-ref record 1))
       (display "\",\"sound\":\"")
       ;(display "</a>")
       ;(display "<audio controls='controls' hidden='true' id='hello'><source src='")
       (display (vector-ref record 3))
       (display "\"},")
       ;(display "' type='audio/mpeg'>Your browser does not support the audio element.</audio>")
       ) 
     records)
    (display "{}]}")))

(show (get-records db))
