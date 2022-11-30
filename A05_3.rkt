;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "vanilla-reader.rkt" "deinprogramm" "sdp")((modname A05_3) (read-case-sensitive #f) (teachpacks ((lib "image.rkt" "teachpack" "deinprogramm" "sdp") (lib "universe.rkt" "teachpack" "deinprogramm" "sdp"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image.rkt" "teachpack" "deinprogramm" "sdp") (lib "universe.rkt" "teachpack" "deinprogramm" "sdp")))))
; Assignment 05

; Aufgabe 3


; -----------------------

;Funktion
(check-expect (f 2) 16)
(define f
  (lambda (x)
    (i (g x) (h (g x)))))


; Beispielfunktionen
(define g
  (lambda (x)
    (* 2 x)))

(define h
  (lambda (x)
    (* 3 x)))

(define i
  (lambda (x y)
    (+ x y)))

; -----------------------

; a)




; -----------------------

; b)


; -----------------------

; c)

; Implementiert f mit let
(check-expect (f** 2) 16)
(define f**
  (lambda (x)
    (let ((a (g x)))
      (i a (h a)))))