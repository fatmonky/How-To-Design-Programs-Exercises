;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP Ex 53|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH 200)
(define HEIGHT 300)
(define MTSCN (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 20 "solid" "red"))

;A LR (launch rocket: is one of
; - "resting". y = 0
; - Non-negative number. y >0, < HEIGHT
(check-expect (lr 0) (place-image ROCKET (/ WIDTH 2) 0 MTSCN))
(check-expect (lr HEIGHT) (place-image ROCKET (/ WIDTH 2) HEIGHT MTSCN))
(define (lr y)
  (place-image ROCKET (/ WIDTH 2)
               (cond
                 [(= y 0) y]
                 [(and(> y 0)(< y HEIGHT))y]
                 [else y])MTSCN))