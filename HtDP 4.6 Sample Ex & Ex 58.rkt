;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |HtDP 4.6 Sample Ex & Ex 58|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
    Sample Problem The state of Tax Land has created a three-stage sales tax to cope with its budget deficit.
Inexpensive items, those costing less than $1,000, are not taxed.
Luxury items, with a price of more than $10,000, are taxed at the rate of eight percent (8.00%).
Everything in between comes with a five percent (5.00%) markup.

    Design a function for a cash register that, given the price of an item, computes the sales tax.

Exercise 58. Introduce constant definitions that separate the intervals for low prices and luxury prices
from the others so that the legislators in Tax Land can easily raise the taxes even more. 
|#

;Price is defined as
; -<1000
; 1000 - 10000
; > 10000
;interpretation - price
(define LUXURY-PRICE 10000)
(define LOW-PRICE 1000)

;Price-> Number
; interpretation - calculates amount of sales tax for p
; -<1000
(check-expect (sales-tax 0) 0)
; 1000 - 10000
(check-expect(sales-tax 1000) (* 0.05 1000))
(check-expect(sales-tax 9999) (* 0.05 9999))
; > 10000
(check-expect(sales-tax 10000) (* 0.08 10000))
(define (sales-tax p)
  (cond
    [(< p LOW-PRICE) 0]
    [(and(< p LUXURY-PRICE)(>= p LOW-PRICE)) (* 0.05 p)]
    [(>= p LUXURY-PRICE) (* 0.08 p)]))