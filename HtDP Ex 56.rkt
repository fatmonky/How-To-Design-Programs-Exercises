;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP Ex 56|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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
(define (draw y)
               (cond
                 [(string? y)
                  (place-rocket HEIGHT)]
                 [(<= -3 y -1 )
                  (place-image(text (number->string y) 20 "red") 10 (* 3/4 WIDTH)(place-rocket HEIGHT))]
                 [(>= y 0)
                  (place-rocket y)]))

(define (place-rocket y)
  (place-image ROCKET (/ WIDTH 2) (- y CENTER) MTSCN))

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
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))


; LRCD -> LRCD
(define (main2 s) ;s needs to be "resting" in order for program to run properly. 
  (big-bang s
    [on-tick fly] ;control tick rate for troubleshooting purpose
    [to-draw draw]
    [on-key launch]
    [stop-when end?]))


#|
Exercise 56. Define main2 so that you can launch the rocket and watch it lift off. Read up on the on-tick clause to
determine the length of one tick and how to change it.
If you watch the entire launch, you will notice that once the rocket reaches the top something curious happens. Explain.
Add a stop-when clause to main2 so that the simulation of the liftoff stops gracefully when the rocket is out of sight. 
|#


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

;6 Jan notes: this doesn't work, as the error msg is 'expects a real as 1st argument, given "resting"'
;7 Jan: changed to 'if'. Didn't work, because of error. Using cond structure as per above functions. This worked beautifully. 


