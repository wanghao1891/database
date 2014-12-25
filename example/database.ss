(use-modules (ice-9 format))
 
(define-macro (create-table name columns)
  (let ((+name-s (symbol->string name)))
    `(begin
       (define ,(string->symbol (string-append "*" +name-s "-table*"))
         '())
 
       (define ,(string->symbol (string-append "make-" +name-s "-record"))
         (lambda +cols
           (map cons ,columns +cols)))
 
       (define ,(string->symbol (string-append "add-" +name-s "-record"))
         (lambda (+record)
           (set! ,(string->symbol (string-append "*" +name-s "-table*"))
                 (cons +record
                       ,(string->symbol (string-append "*" +name-s "-table*"))))))
 
       (define ,(string->symbol (string-append "dump-" +name-s "-table"))
         (lambda ()
           (format #t "~{~{~a~^~%~}~^~2%~}"
                   ,(string->symbol (string-append "*" +name-s "-table*")))))
 
       (define ,(string->symbol (string-append "save-" +name-s "-table"))
         (lambda (+filename)
           (with-output-to-file +filename
             (lambda ()
               (write ,(string->symbol (string-append "*" +name-s "-table*")))))))
 
       (define ,(string->symbol (string-append "load-" +name-s "-table"))
         (lambda (+filename)
           (with-input-from-file +filename
             (lambda ()
               (set! ,(string->symbol (string-append "*" +name-s "-table*"))
                     (read))))))
 
       (define ,(string->symbol (string-append "where-" +name-s))
         (lambda +pairs
           (lambda (+cd)
             (let +loop ((+ls +pairs))
               (if (null? +ls)
                   #t
                   (let ((+key (car +ls))
                         (+value (cadr +ls)))
                     (if (equal? +value
                                 (cdr (assq +key +cd)))
                         (+loop (cddr +ls))
                         #f)))))))
 
       (define ,(string->symbol (string-append "select-" +name-s))
         (lambda (+select-fn)
           (filter +select-fn ,(string->symbol (string-append "*" +name-s "-table*")))))
 
       (define ,(string->symbol (string-append "update-" +name-s))
         (lambda (+selector-fn . +pairs)
           (for-each (lambda (+cd)
                       (if (+selector-fn +cd)
                           (let loop ((+ls +pairs))
                             (if (not (null? +ls))
                                 (let ((+key (car +ls))
                                       (+value (cadr +ls)))
                                   (let ((+temp (assq +key +cd)))
                                     (if (not (pair? +temp))
                                         (error "Wrong arguments in update function!")
                                         (set-cdr! +temp +value))
                                     (loop (cddr +ls))))))))
                     ,(string->symbol (string-append "*" +name-s "-table*"))))))))

(create-table cd '(title artist rating ripped))
(add-cd-record (make-cd-record "Roses" "Kathy Mattea" 7 #t))
(add-cd-record (make-cd-record "Fly" "Dixie Chicks" 8 #t))
(add-cd-record (make-cd-record "Home" "Dixie Chicks" 9 #t))
(dump-cd-table)
,pp (select-cd (where-cd 'artist "Dixie Chicks"))
(update-cd (where-cd 'artist "Dixie Chicks")
                                'artist "Abc")
(dump-cd-table)
,pp (select-cd (where-cd 'artist "Abc" 'rating 9))

(save-cd-table "cd.db")

(create-table cd '(title artist rating ripped))
(load-cd-table "cd.db")
(dump-cd-table)
