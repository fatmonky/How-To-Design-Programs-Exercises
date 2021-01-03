;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP 4.4 Sample Ex|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (circle 20 "solid" "blue")))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render/status]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image UFO (/ WIDTH 2) 11 MTSCN))
(define (render y)
  (place-image UFO (/ WIDTH 2) y MTSCN))

#|
Figure 27 code
;WorldState-> Image
; Adds text declaration to the UFO simulation
; given: UFO height <= CLOSE -> "descending"
; given: UFO height > CLOSE -> "closing in"
; given: UFO height bottom -> "landed"
(check-expect (render/status 10) (place-image(text "descending" 10 "green")20 20 (render 10)))
(check-expect (render/status 40) (place-image(text "closing in" 10 "orange")20 20 (render 40)))

(define (render/status y)
  (cond
    [(<= 0 y CLOSE)(place-image(text "descending" 10 "green")20 20 (render y))]
    [(and(> y CLOSE)(<= y HEIGHT))(place-image(text "closing in" 10 "orange")20 20 (render y))]
    [(> y HEIGHT)(place-image (text "landed" 10 "red")20 20 (render y))]))

|#

; WorldState -> Image
; adds a status line to the scene created by render  
 
(check-expect (render/status 42)
              (place-image (text "closing in" 11 "orange")
                           20 20
                           (render 42)))
 
(define (render/status y)
  (place-image
    (cond
      [(<= 0 y CLOSE)
       (text "descending" 11 "green")]
      [(and (< CLOSE y) (<= y HEIGHT))
       (text "closing in" 11 "orange")]
      [(> y HEIGHT)
       (text "landed" 11 "red")])
    20 20
    (render y)))