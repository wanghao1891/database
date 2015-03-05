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
    (let* ((in-port (open-input-file (string-append name ".ss")))
	   (data (get-datum in-port)))
      (close-port in-port)
      data)))

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

(define get-latest-id
  (lambda (db)
    (let ((records (get-records db)))
      (if (null? records)
	  0
	  (vector-ref 
	   (car (get-records db))
	   0)))))

(define get-field
  (lambda (db)
    (vector-ref db 1)))

(define get-record-by-name
  (lambda (db name)
    (let loop ((reocrds (get-records db)))
      (cond
       ((null? records) (vector))
       (else
	(let* ((record (car records))
	       (_name (vector-ref record 1)))
	  (if (equal? name _name)
	      record
	      (loop (cdr reocrds)))))))))

(define get-id
  (lambda (record)
    (vector-ref record 0)))

(define delete-record-by-id
  (lambda (db id)
    (vector-set! 
     db 2
     (let loop ((records (get-records db)))
       (cond
	((null? records) '())
	(else
	 (let* ((record (car records))
		(_id (get-id record)))
	   (cond
	    ((equal? id _id) (loop (cdr records)))
	    (else
	     (cons record (loop (cdr records))))))))))
    (save-db db)))

;(cons (cons (vector 1 2 3) (cons '() '())) '())

;(delete-record-by-id (load-db "data-01") 72)



