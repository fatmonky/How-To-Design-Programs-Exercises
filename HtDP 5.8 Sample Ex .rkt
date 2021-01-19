;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP 5.8 Sample Ex |) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Sample Problem Design a function that computes the distance of objects in a 3-dimensional space to the origin

My results:

All 5 tests passed!
> (r3-distance-to-0 (make-r3 5 5 5))
#i8.660254037844387
> (sqrt 75)
#i8.660254037844387
> 


|#

(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))
(define ex3 (make-r3 3 0 0)) ;checking for x=3
(define ex4 (make-r3 3 3 0));checking for addition of y=3 to ex 3
(define ex5 (make-r3 3 3 3));checking for addition of z=3 to ex 4

; R3 -> Number 
; determines the distance of p to the origin
(check-within (r3-distance-to-0 ex1) (sqrt(+(sqr 1)(sqr 2)(sqr 13))) 3) ;need to use check-within, due to inexact decimals. 
(check-within (r3-distance-to-0 ex2) (sqrt 10) 3)
(check-within (r3-distance-to-0 ex3) (sqrt 9) 3)
(check-within (r3-distance-to-0 ex4) (sqrt (+ 9 9))3)
(check-within(r3-distance-to-0 ex5) (sqrt (+ 9 9 9))3)
(define (r3-distance-to-0 p)
  (sqrt(+ (sqr(r3-x p)) (sqr(r3-y p)) (sqr(r3-z p)))))