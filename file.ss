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

#;
(call-with-input-file filename
  (lambda (input-port)
    (let loop ((x (read-char input-port)))
      (if (not (eof-object? x))
          (begin
            (display x)
            (loop (read-char input-port)))))))

;(binary-port? (open-file-input-port "/root/workspace/proxy-node/uk-audio.png"))


(display "new Buffer([")

(let ((input-port (open-file-input-port filename)))
  (let loop ((x (get-u8 input-port)))
    (if (not (eof-object? x))
	(begin
	  (display "0x")
	  (display (number->string x 16))
	  (display ",")
	  (loop (get-u8 input-port))))))

(display "])")

