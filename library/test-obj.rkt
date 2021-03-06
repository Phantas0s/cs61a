#lang racket

(require "obj.rkt" rackunit)

(define-class (counter count)
  (class-vars (num-counters 0) (bloo 'grah))
  (initialize (set! num-counters (add1 num-counters))
              (set! bloo 'bloo))
  (instance-vars (loc-count 0))
  (method (increment incr)
          (set! count (+ incr count))
          (set! loc-count (+ incr loc-count))
          (list loc-count count))
  (method (foo x)
          (ask self 'increment (+ x 2)))
  )

;; (define-class (weird-counter)
;;   (parent (counter 3))
;;   (method (reset)
;;           (set! num-counters 0)
;;           (set! count 0)
;;           (set! loc-count 0))
;;   (method (increment incr)
;;           (usual 'increment (- incr)))
;;   )

;; (define-class (weird-weird-counter blah)
;;   (parent (counter (+ blah 2)) (weird-counter))
;;   (instance-vars (x (+ 2 9)) (y (- 9 2)))
;;   (class-vars (w (+ 4 4)) (z (- 4 4)))
;;   (initialize (set! w z) (set! z 8))
;;   (method (wack . nums)
;;           (car nums))
;;   (default-method
;;     (+ 2 (car args)))
;;   )

(test-case
 "obj.rkt"
 (check-equal? 0 (ask counter 'num-counters))
 (define c1 (instantiate counter 4))
 (check-equal? 1 (ask counter 'num-counters))
 (check-equal? 4 (ask c1 'count))
 (check-equal? 0 (ask c1 'loc-count))
 (check-equal? '(6 10) (ask c1 'increment 6))
 (define c2 (instantiate counter 1))
 (check-equal? '(8 12) (ask c1 'increment 2))
 (check-equal? 2 (ask counter 'num-counters))
 (check-equal? 2 (ask c1 'num-counters))
 (check-equal? 'bloo (ask c2 'bloo))
 (check-equal? '(4 5) (ask c2 'foo 2))
 ;; (define c3 (instantiate weird-counter))
 ;; (check-equal? '(-2 1) (ask c3 'foo 2))
 )
