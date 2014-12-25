(let ((data (get-datum (open-input-file "data.ss"))))
  (display (car data))
  (let ((records (cdr data)))
    (map
     (lambda (record)
       (map
	(lambda (column)
	  (cdr column))
	record))
     records)))

(let ((input-port (open-input-file "data-01.ss")))
  (get-datum input-port))

(let ((out-port (open-output-file "data-01.ss" '(truncate))))
  (put-datum out-port (vector  "dictionary" '(word sound)))
  ;(flush-output-port out-port)
  (close-port out-port))

(let ((out-port (open-file-output-port "data-01.ss" (file-options no-fail no-truncate) (buffer-mode block) (native-transcoder))))
  (put-datum out-port (list 1 2 3))
  ;(port-has-port-position? out-port)
  ;(port-position out-port)
  ;(set-port-position! out-port 1)
  ;(port-position out-port)
  ;(put-char out-port #\b)
  (close-port out-port)
  )
