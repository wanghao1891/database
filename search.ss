#!/usr/bin/petite --script

(define search-text (cadr (command-line)))

(load "base.ss")

(let* ((db (load-db "data-01"))
       (result (get-record-by-name db search-text))
       (result-length (vector-length result)))
  (if (= result-length 0)
      (system (string-append 
	       "cd " (current-directory) "/../parser/; petite --script html-parser.ss "
	       search-text)))
  (display result-length))

(current-directory)
