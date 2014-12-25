#!/usr/bin/petite --script

(define create-db
  (lambda (name field)
    (let ((db (vector name field '()))
	  (filename (string-append name ".ss")))
      (save-db db filename))))

(define save-db
  (lambda (db filename)
    (let ((out-port (open-file-output-port filename (file-options no-fail no-truncate) (buffer-mode block) (native-transcoder))))
      (put-datum out-port db)
      (close-port out-port))))

(define insert-record
  (lambda (db filed)
    ()))

(create-db "data-04" '(id name password))

