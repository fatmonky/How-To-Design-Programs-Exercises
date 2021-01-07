;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP Ex 57|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; 7 Jan 21: Countdown works fine on spacebar, then images all disappear. 

#|
Exercise 57. Recall that the word “height” forced us to choose one of two possible interpretations.
Now that you have solved the exercises in this section, solve them again using the first interpretation of the word.
Compare and contrast the solutions.

"While the interpretation of "resting" is obvious, the interpretation of numbers is ambiguous in its notion of height:

   1. the word “height” could refer to the distance between the ground and the rocket’s point of reference, say, its center; or

   2. it could mean the distance between the top of the canvas and the reference point."

|#
 
; if height refers to dist bet ground (top of canvas) and center of rocket, then height = canvasHeight - y-coordinate
(define WIDTH 200)
(define CANVAS-HEIGHT 300)
(define YDELTA 3) ;speed of rocket
(define MTSCN (empty-scene WIDTH CANVAS-HEIGHT))
(define ROCKET (rectangle 5 20 "solid" "red"))
(define CENTER (/ (image-height ROCKET) 2))



; A LRCD (Launch Rocket Count Down) consists of
; - "resting"
;- "A number from -3 to -1
; Non-negative number
;interpretation ->
; grounded rocket in countdown mode
; Number represents canvasHeight-y-coordinate
; PJ note - rocket goes from HEIGHT to 0
; given:      , expect:
(check-expect (rocket-height 10) (- CANVAS-HEIGHT 10))
(check-expect (rocket-height 100) (- CANVAS-HEIGHT 100))
(define (rocket-height y)
  (- CANVAS-HEIGHT y))


;Wishlist of functions:
; render function, to show image as resting or flying rocket
; LRCD -> Image
; given y = "resting", expect: (place-image ROCKET (/ WIDTH 2) HEIGHT MTSCN)
; given y = -2, expect: (place-image(text "-2" 20 "red") 10 (* 3/4 WIDTH)(place-image ROCKET (/ WIDTH 2) HEIGHT MTSCN)
; given: y = 53    , expect: (place-image ROCKET (/ WIDTH 2) 53 MTSCN)
(check-expect (draw "resting") (place-image ROCKET (/ WIDTH 2) (- CANVAS-HEIGHT CENTER) MTSCN))
(check-expect (draw -2) (place-image(text "-2" 20 "red") 10 (* 3/4 WIDTH)(place-image ROCKET (/ WIDTH 2) (- CANVAS-HEIGHT CENTER) MTSCN)))
(check-expect (draw 53) (place-image ROCKET (/ WIDTH 2) (- (rocket-height 53) CENTER) MTSCN))
(define (draw y)
               (cond
                 [(string? y)
                  (place-rocket 0)]
                 [(<= -3 y -1 )
                  (place-image(text (number->string y) 20 "red") 10 (* 3/4 WIDTH)(place-rocket 0))]
                 [(>= y 0)
                  (place-rocket y)]))

(define (place-rocket y)
  (place-image ROCKET (/ WIDTH 2) (- (rocket-height y) CENTER) MTSCN))

; key event handler, to trigger count-down [PJ note: additional condition in book "if rocket still resting"]
; LRCD ke -> number
; given:     , expect: 
;given: press any key, expect: remain at -3
;given: press spacebar, expect: -3
; given:
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)
(define (launch y ke)
  (cond
    [(string? y) (if (string=? " " ke) -3 y)]
    [(<= -3 y -1) y]
    [(>= y 0) y]))



; tick, to move image by YDELTA ticks i.e. for rocket to fly
; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) (rocket-height 0))
(check-expect (fly 10) (+ (rocket-height 10) YDELTA))
(check-expect (fly 22) (+ (rocket-height 22) YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) CANVAS-HEIGHT (+ x 1))]
    [(>= x 0) (+ (rocket-height x) YDELTA)])) ;sign change


;LRCD -> LRCD
; interpretation end state of world
(check-expect (end? "resting") #false)
(check-expect (end? -3) #false)
(check-expect (end? 100) #false)
(check-expect (end? 10) #true)

(define (end? y)
  (cond
    [(string? y) #false]
    [(<= -3 y -1) #false]
    [(> (- y CENTER) 0) #false]
    [(<=(- y CENTER) 0) #true]))

; LRCD -> LRCD
(define (main3 s) ;s needs to be "resting" in order for program to run properly. 
  (big-bang s
    [on-tick fly 1] ;control tick rate for troubleshooting purpose
    [to-draw draw]
    [on-key launch]
    [stop-when end?]))



