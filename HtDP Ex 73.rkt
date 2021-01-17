;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP Ex 73|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Exercise 73. Design the function posn-up-x, which consumes a Posn p and a Number n. It produces a Posn like p with n in the x field.

A neat observation is that we can define x+ using posn-up-x:

    (define (x+ p)
      (posn-up-x p (+ (posn-x p) 3)))

Note Functions such as posn-up-x are often called updaters or functional setters. They are extremely useful when you write large programs.
|#

;Posn Number -> Posn
; interpretation takes Posn p and Number n, and produces a posn iwth n in the x-field.
(define (posn-up-x p n)
  (make-posn (posn-y p) n))