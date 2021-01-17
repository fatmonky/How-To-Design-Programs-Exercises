;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP Ch 5.6 Sample Problem & Ex 74|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
Sample Problem Your team is designing an interactive game program that moves a red dot across a image canvas and allows players to use the mouse to reset the dot. Here is how far you got together:

    (define MTS (empty-scene 100 100))
    (define DOT (circle 3 "solid" "red"))
     
    ; A Posn represents the state of the world.
     
    ; Posn -> Posn 
    (define (main p0)
      (big-bang p0
        [on-tick x+]
        [on-mouse reset-dot]
        [to-draw scene+dot]))

Your task is to design scene+dot, the function that adds a red dot to the empty canvas at the specified position.


Exercise 74. Copy all relevant constant and function definitions to DrRacket’s definitions area.
 Add the tests and make sure they pass. Then run the program and use the mouse to place the red dot. 
|#

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.
 
; Posn -> Posn 
(define (main p0) ;in interaction area, type (main (make-posn 0 0)) to start
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

; Posn -> Image
; adds a red spot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))

#|Exercise 73. Design the function posn-up-x, which consumes a Posn p and a Number n. It produces a Posn like p with n in the x field.
|#

;Posn n -> Posn
; updater/functional setter
(define (posn-up-x p n)
  (make-posn n (posn-y p)))

; Posn Number Number MouseEvt -> Posn 
; for mouse clicks, (make-posn x y); otherwise p
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-down")
  (make-posn 29 31))
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-up")
  (make-posn 10 20))
(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))