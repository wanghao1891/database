#!/usr/bin/petite --script

(define create-db
  (lambda (name field)
    (let ((db (vector name field '()))
	  (filename (string-append name ".ss")))
      (save-db db filename))))

(define save-db
  (lambda (db)
    (let ((out-port (open-file-output-port (get-filename db) (file-options no-fail no-truncate) (buffer-mode block) (native-transcoder))))
      (put-datum out-port db)
      (close-port out-port))))

(define get-filename
  (lambda (db)
    (string-append (vector-ref db 0) ".ss")))

(define load-db
  (lambda (filename)
    (let ((in-port (open-input-file (string-append filename ".ss"))))
      (get-datum in-port))))

(define insert-record
  (lambda (db record)
    (vector-set! db 2 (cons record (get-records db)))
    (save-db db)))

(define get-records
  (lambda (db)
    (vector-ref db 2)))



(create-db "data-04" '(id name password))

(insert-record (load-db "data-04") (vector 1 "mike" 123456))
