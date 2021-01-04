;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP Ex 54-55|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|Sample Problem
Design a program that launches a rocket when the user presses the space bar.
At that point, the simulation starts a countdown for three ticks, before it
 displays the scenery of a rising rocket. The rocket should move upward at
 a rate of three pixels per clock tick.
|#

(define WIDTH 200)
(define HEIGHT 300)
(define YDELTA 3) ;speed of rocket
(define MTSCN (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 20 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))


; A LRCD (Launch Rocket Count Down) consists of
; - "resting"
;- "A number from -3 to -1
; Non-negative number
;interpretation ->
; grounded rocket in countdown mode
; Number represents no of pixels between rocket and top of canvas
; PJ note - rocket goes from HEIGHT to 0
; given:      , expect:



;Wishlist of functions:
; render function, to show image as resting or flying rocket
; LRCD -> Image
; given y = "resting", expect: (place-image ROCKET (/ WIDTH 2) HEIGHT MTSCN)
; given y = -2, expect: (place-image(text "-2" 20 "red") 10 (* 3/4 WIDTH)(place-image ROCKET (/ WIDTH 2) HEIGHT MTSCN)
; given: y = 53    , expect: (place-image ROCKET (/ WIDTH 2) 53 MTSCN)
(check-expect (draw "resting") (place-image ROCKET (/ WIDTH 2) (- HEIGHT CENTER) MTSCN))
(check-expect (draw -2) (place-image(text "-2" 20 "red") 10 (* 3/4 WIDTH)(place-image ROCKET (/ WIDTH 2) (- HEIGHT CENTER) MTSCN)))
(check-expect (draw 53) (place-image ROCKET (/ WIDTH 2) (- 53 CENTER) MTSCN))


#|
Exercise 55. Take another look at show. It contains three instances of an expression with the approximate shape:

    (place-image ROCKET 10 (- ... CENTER) BACKG)

This expression appears three times in the function: twice to draw a resting rocket and once to draw a flying rocket.
Define an auxiliary function that performs this work and thus shorten show.
Why is this a good idea? You may wish to reread Prologue: How to Program. 
|#
(define (draw y)
               (cond
                 [(string? y)
                  (place-rocket HEIGHT)]
                 [(< -3 y -1 )
                  (place-image(text (number->string y) 20 "red") 10 (* 3/4 WIDTH)(place-rocket HEIGHT))]
                 [(>= y 0)
                  (place-rocket y)]))

(define (place-rocket y)
  (place-image ROCKET (/ WIDTH 2) (- y CENTER) MTSCN))




#|
PJ note: Earlier version of draw ("show") in book. 
(define (draw y)
  (cond
    [(string? y)
     (place-image ROCKET (/ WIDTH 2) (- HEIGHT CENTER) MTSCN)]
    [(< -3 y -1 )
     (place-image(text "y" 20 "red") 10 (* 3/4 WIDTH)(place-image ROCKET (/ WIDTH 2) (- HEIGHT CENTER) MTSCN))]
    [(>= y 0)
     (place-image ROCKET (/ WIDTH 2) (- y CENTER) MTSCN)])
|#


; key event handler, to trigger count-down [PJ note: additional condition in book "if rocket still resting"]
; LRCD ke -> number
; given:     , expect: 
;(define (launch y ke) (...y...))

; tick, to move image by YDELTA ticks i.e. for rocket to fly
; LRCD -> LRCD
; given:      , expect:   
;(define (fly y) (...y...))



