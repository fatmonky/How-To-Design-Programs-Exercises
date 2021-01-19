;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP Ex 81|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Exercise 81. Design the function time->seconds, which consumes instances of time structures (see exercise 77) and produces the number of seconds that have passed since midnight.
For example, if you are representing 12 hours, 30 minutes, and 2 seconds with one of these structures and if you then apply time->seconds to this instance, the correct result is 45002. 

|#

(define-struct time [hours minutes seconds])

; A time is a structure:
;(make-time Number Number Number)
; hours is an interval from 0 to 23
; minutes is an interval from 0 to 60
; seconds is an interval from 0 to 60
(define ex1 (make-time 0 0 59))
(define ex2 (make-time 0 1 1))
(define ex3 (make-time 0 1 59))
(define ex4 (make-time 0 59 59))
(define ex5 (make-time 1 59 59))
(define book-ex (make-time 12 30 2))

(check-expect (time->seconds ex1) 59)
(check-expect (time->seconds ex2) (+ 60 1))
(check-expect (time->seconds ex3)(+ 60 59))
(check-expect (time->seconds ex4)(+(* 59 60) 59))
(check-expect (time->seconds ex5)(+ (* 60 60) (* 59 60) 59))
(check-expect (time->seconds book-ex) 45002)
(define (time->seconds p)
  (+ (* 60 60 (time-hours p)) (* 60 (time-minutes p)) (time-seconds p)))