#!/usr/bin/petite --script

(define create-db
  (lambda (name field)
    (let ((db (vector name field '()))
	  (filename (string-append name ".ss")))
      (save-db db)
      )))

(define get-rw-out-port
  (lambda (db)
    (let* ((filename (get-filename db))
	   (fo (file-options no-fail no-truncate))
	   (bm (buffer-mode block))
	   (nt (native-transcoder)))
      (open-file-output-port filename fo bm nt))))

(define get-truncate-out-port
  (lambda (db)
    (let ((filename (get-filename db)))
      (open-output-file filename '(truncate)))))

(define save-db
  (lambda (db)
    (let ((out-port (get-truncate-out-port db)))
     (put-datum out-port db)
     (close-port out-port))))

(define get-filename
  (lambda (db)
    (string-append (vector-ref db 0) ".ss")))

(define load-db
  (lambda (name)
    (let ((in-port (open-input-file (string-append name ".ss"))))
      (get-datum in-port))))

(define insert-record
  (lambda (db record)
    (vector-set! db 2 (cons record (get-records db)))
    (save-db db)))

(define get-records
  (lambda (db)
    (vector-ref db 2)))

(define get-record
  (lambda (db id)
    (list-ref (get-records db) id)))
