(define (disp x) (display x) (display "\n"))

(define (deriv expr var)
  (cond ((constant? expr var) 0)
	((samevar? expr var) 1)
	((sum? expr)
	 (makesum (deriv (a1 expr) var)
		  (deriv (a2 expr) var)))
	((product? expr)
	 (makesum (makeproduct (deriv (m1 expr) var) (m2 expr))
		  (makeproduct (deriv (m2 expr) var) (m1 expr))))))

(define (atom? x) (not (list? x)))
(define (constant? expr var)
  (and (atom? expr)
       (not (eq? expr var))))
(define (samevar? expr var)
  (and (atom? expr) 
       (eq? expr var)))

(define (sum? expr)
  (and (not (atom? expr))
       (eq? (car expr) '+)))
(define (makesum a1 a2)
  (cond ((and (number? a1)
	      (number? a2))
	 (+ a1 a2))
	((and (number? a1) (= a1 0)) a2)
	((and (number? a2) (= a2 0)) a1)
        (else (list '+ a1 a2))))
(define a1 cadr)
(define a2 caddr)

(define (product? expr)
  (and (not (atom? expr))
       (eq? (car expr) '*)))
(define (makeproduct m1 m2)
  (cond ((and (number? m1) (= 0 m1)) 0)
	((and (number? m2) (= 0 m2)) 0)
	((and (number? m1) (= 1 m1)) m2)
	((and (number? m2) (= 1 m2)) m1)
        (else (list '* m1 m2))))
(define m1 cadr)
(define m2 caddr)

(define foo
  '(+ (* a (* x x))
      (+ (* b x)
	 c)))

(disp (deriv foo 'x))
