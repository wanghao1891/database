#!/usr/bin/petite --script

o(define _table 
  '((p (pro (proce (process))
	    (produ (product))
	    (progr (progress))
	    (proje (project))
	    (promi (promise))
	    (prono (pronounce))))
    (r (rea (reall (really)))
       (rel (relat (relative)))
       (rep (repre (represent)))
       (rom (roman (romania))))))

#;
(define relative
  (lambda (key table)
    (cond
     ((null? table) '())
     ((atom? (car table))
      )
     (else
      (if (equal? key (car table)))))))

(define _key (cadr (command-line)))

(define autocomplete
  (lambda (key)
    (system (string-append "curl http://www.oxfordlearnersdictionaries.com/autocomplete/english/?q=" key))))

(autocomplete _key)
