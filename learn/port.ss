(with-input-from-file "data.ss"
  (lambda () 
    (caaar (cdr (read)))))

format

(get-bytevector-n (open-file-input-port "data.ss") 1)
(get-datum (open-input-file "data.ss"))
(get-line (open-input-file "data.ss"))
(get-char (open-input-file "data.ss"))

(define p (open-input-file "data.ss"))
(define get-char-in-port
  (lambda (port)
    (let ((x (read-char p)))
      (cond
       ((eof-object? x) (close-port p))
       (else (cons x (get-char-in-port p)))
       ))))

(get-char-in-port p)

(let ((p (open-input-file "data.ss")))
  (let f ((x (read p)))
    (if (eof-object? x)
	(close-port p)
	(cons x (read p)))))
