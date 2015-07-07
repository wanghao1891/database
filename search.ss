#!/usr/bin/petite --script

(define search-text (cadr (command-line)))

(load "base.ss")

(define get-vocabulary-json
  (lambda (record)
    (string-append "{\"name\":\""
                   (vector-ref record 1)
                   "\",\"pronunciation_uk\":\""
                   (vector-ref record 2)
                   "\",\"sound_uk\":\""
                   (vector-ref record 3)
                   "\",\"pronunciation_us\":\""
                   (vector-ref record 4)
                   "\",\"sound_us\":\""
                   (vector-ref record 5)
                   "\",\"definition\":\""
                   (vector-ref record 6)
                   "\"}")))

(let* ((db (load-db "data-01"))
       (result (get-record-by-name db search-text))
       (result-length (vector-length result)))
  (if (= result-length 0)
      (system (string-append
	       "cd " (current-directory) "/../parser/; petite --script html-parser.ss "
	       search-text)))
  (display (get-vocabulary-json result)))

(current-directory)
