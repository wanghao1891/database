#!/usr/bin/petite --script

#;
(define get-file
  (lambda (name)
    (call-with-input-file "proxy.js"
      (lambda (input-port)
	(let loop ((x (read-char input-port)))
	  (if (not (eof-object? x))
	      (begin
		(display x)
		(loop (read-char input-port)))))))))

(define filename (cadr (command-line)))

(call-with-input-file filename
  (lambda (input-port)
    (let loop ((x (read-char input-port)))
      (if (not (eof-object? x))
          (begin
            (display x)
            (loop (read-char input-port)))))))
