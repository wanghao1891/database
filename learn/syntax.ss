#!/usr/bin/petite --script

(define-syntax nil!
  (syntax-rules ()
    ((_ x)
     (set! x '(a b c)))))

(define (f-nil! x)
  (set! x '()))

(define a 1)

(f-nil! a)

a

(nil! a)

a

(define-syntax when
  (syntax-rules ()
    ((_ pred b1 ...)
     (if pred (begin b1 ...)))))

(let ((i 0))
  (when (= i 0)
    (display "i == 0")
    (newline)))

(define-syntax while
  (syntax-rules ()
    ((_ pred b1 ...)
     (let loop () (when pred b1 ... (loop))))))

(define-syntax for
  (syntax-rules ()
    ((_ (i from to) b1 ...)
     (let loop ((i from))
       (when (< i to)
	       b1 ...
	         (loop (1+ i)))))))

(let ((i 0))
  (while (< i 10)
    (display i)
    (display " ")
    (set! i (+ i 1))))

(for (i 0 10)
  (display i)
  (display " "))

(define-syntax incf
  (syntax-rules ()
    ((_ x) (begin (set! x (+ x 1)) x))
    ((_ x i) (begin (set! x (+ x i)) x))))

(let ((i 0) (j 0))
  (incf i)
  (incf j 3)
  (display (list 'i '= i))
  (newline)
  (display (list 'j '= j)))

(define i 0)
(define j 0)
(begin (set! i (+ i 1)) i)

(define-syntax test
  (syntax-rules ()
    ((_) `(begin (define a "b") (display a)))))

(test)

(define a "b")

(display a)

(define-syntax test
  (syntax-rules ()
    ((_ name) 
     (let ((+name-s name))
       `(begin
       (define ,(string->symbol (string-append "a" +name-s "-table*"))
         '())))
     )))

(test "c")

(ac-table*)

;;define my-if as a macro
(define-syntax my-if
  (lambda (x)
    ;;establish that "then" and "else" are keywords
    (syntax-case x (then else)
      (
        ;;pattern to match
        (my-if condition then yes-result else no-result)
        ;;transformer
        (syntax (if condition yes-result no-result))))))

(define a 1)
(define b 2)
(my-if  (> a b)  then     a      else    b)

;;Define a new macro
(define-syntax swap!
  (lambda (x)
    ;;we don't have any keywords this time
    (syntax-case x ()
        (
	 (swap! a b)
          (syntax
	   (let ((c a))
              (set! a b)
              (set! b c)))))))

(define a 1)
(define b 2)
(swap! a b)
(display "a is now ") (display a) (newline)
(display "b is now ") (display b) (newline)

;;Define our macro
(define-syntax at-compile-time
   ;;x is the syntax object to be transformed
   (lambda (x)
      (syntax-case x ()
         (
            ;;Pattern just like a syntax-rules pattern
            (at-compile-time expression)
            ;;with-syntax allows us to build syntax objects
            ;;dynamically
            (with-syntax
               (
                  ;this is the syntax object we are building
                  (expression-value
                     ;after computing expression, transform it into a syntax object
                     (datum->syntax-object
                        ;syntax domain
                        (syntax k)
                        ;quote the value so that its a literal value
                        (list 'quote
                        ;compute the value to transform
                           (eval
                              ;;convert the expression from the syntax representation
                              ;;to a list representation
                              (syntax-object->datum (syntax expression))
                              ;;environment to evaluate in
                              (interaction-environment))))))
               ;;Just return the generated value as the result
               (syntax expression-value))))))

(define a
   ;;converts to 5 at compile-time
   (at-compile-time (+ 2 3)))

(display a)

(define sqrt-table
   (at-compile-time
      (list->vector
         (let build
            (
               (val 0))
            (if (> val 20)
               '()
               (cons (sqrt val) (build (+ val 1))))))))

(display (vector-ref sqrt-table 5))

(display sqrt-table)

(define-syntax build-compiled-table
   (syntax-rules ()
      (
         (build-compiled-table name start end default func)
         (define name
            (at-compile-time
               (list->vector
                  (let build
                     (
                        (val 0))
                     (if (> val end)
                        '()
                        (if (< val start)
                           (cons default (build (+ val 1)))
                           (cons (func val) (build (+ val 1))))))))))))

(build-compiled-table sqrt-table 5 20 0.0 sqrt)

(display (vector-ref sqrt-table 5))

(define-syntax swap
  (syntax-rules ()
	      ( 
	       (swap a b)
		(let ([tmp a])
		  (set! a b)
		  (set! b tmp)))))


(define-syntax rotate
   (syntax-rules ()
     [(rotate a b) (swap a b)]
     [(rotate a b c) (begin
                       (swap a b)
                       (swap b c))]))

(define-syntax rotate
  (syntax-rules ()
    [(rotate a) (void)]
    [(rotate a b c ...) (begin
                          (swap a b)
                          (rotate b c ...))]))

(define-syntax display-number
  (syntax-rules ()
    ((display-number a b c ...) (display (string-append (number->string a) (number->string b) (number->string c) ...)))))

(let ((a 1) (b 2) (c 3) (d 4) (e 5))
 (rotate a b c)
 (display-number a b c d e))

(let ([tmp 100] [b 200])
  (swap tmp b)
  (printf "~a\n" (list tmp b)))

(let ([set! 100] [b 200])
  (swap set! b)
  (printf "~a\n" (list set! b)))

(syntax (+ 1 2))

(define-syntax swap
 (lambda (stx)
  (syntax-case stx ()
    [(swap x y)
     (if (and (identifier? #'x)
              (identifier? #'y))
         #'(let ([tmp x])
             (set! x y)
             (set! y tmp))
         (raise-syntax-error #f
                             "not an identifier"
                             stx
                             (if (identifier? #'x)
                                 #'y
                                 #'x)))])))

(swap a b)

(define-syntax a
  (lambda (stx)
    #'(printf "zh\n")))

(a)

(define-syntax create-table
  (syntax-rules ()
     (
       (create-table name a b func)
         (define name
           (func a b)))))

(create-table english 1 2 +)

(display cd)
