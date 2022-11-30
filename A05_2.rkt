;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname A05_2) (read-case-sensitive #f) (teachpacks ((lib "image.rkt" "teachpack" "deinprogramm" "sdp") (lib "universe.rkt" "teachpack" "deinprogramm" "sdp"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image.rkt" "teachpack" "deinprogramm" "sdp") (lib "universe.rkt" "teachpack" "deinprogramm" "sdp")))))
; Assignment 05

; Aufgabe 2

; -------------------------------------------------------------
; a)

; Erstellt einen Record für Kreis mit den Eigenschaften
; - Radius
; - Farbe
(: make-circle-shape (real image-color -> circle-shape))
(: circle-radius (circle-shape -> real))
(: circle-color (circle-shape -> image-color))
;(check-expect (make-circle-shape 20 "red"))
(define-record circle-shape
  make-circle-shape
  circle-shape?
  (circle-radius   real)
  (circle-color    image-color))

; Erstellt einen Record für Rechtecke mit den Eigenschaften
; - Breite
; - Höhe
; - Farbe
(: make-rectangle-shape (real real image-color -> rectangle-shape))
(: rectangle-width (rectangle-shape -> real))
(: rectangle-height (rectangle-shape -> real))
(: rectangle-color (rectangle-shape -> image-color))
; test
(define-record rectangle-shape
  make-rectangle-shape
  rectangle-shape?
  (rectangle-width    real)
  (rectangle-height   real)
  (rectangle-color    image-color))

; Erstellt einen Record für Dreiecke mit den Eigenschaften
; - Seitenlänge
; - Farbe
(: make-triangle-shape (real image-color -> triangle-shape))
(: triangle-edge-length (triangle-shape -> real))
(: triangle-color (triangle-shape -> image-color))
; test
(define-record triangle-shape
  make-triangle-shape
  triangle-shape?
  (triangle-edge-length   real)
  (triangle-color         image-color))



; -------------------------------------------------------------
; b)

; Signatur für Formen
(define shape
  (signature
   (mixed circle-shape rectangle-shape triangle-shape)))


; -------------------------------------------------------------
; c)

(define π 3.141592654)

; Berechnet die Fläche einer übergebenen Form
(: shape-area (shape -> real))
(check-expect (shape-area my-circle) 1256.6370616)  ;Testfälle sind unten definiert
(check-expect (shape-area my-rectangle) 400)
(check-within (shape-area my-triangle) 173.2050807 0.0001)
(define shape-area
  (lambda (shape)
    (match shape
      ((make-circle-shape    radius _)    (* π radius radius))
      ((make-rectangle-shape width height _)  (* width height))
      ((make-triangle-shape  edge-length _)    (* 0.25 edge-length edge-length (sqrt 3))))))



; -------------------------------------------------------------
; d)

; Zeichnet die in einem Record übergebene Form
(: draw-shape (shape -> image))
; keine Tests
(define draw-shape
  (lambda (shape)
    (match shape
      ((make-circle-shape radius color)          (circle radius "solid" color))
      ((make-rectangle-shape width height color) (rectangle width height "solid" color))
      ((make-triangle-shape edge-length color)   (triangle edge-length "solid" color)))))



; -------------------------------------------------------------
; e)

(: rotation-angle (real real -> real))
(check-expect (rotation-angle (shape-area my-circle) (shape-area my-other-circle)) 0)
(define rotation-angle
  (lambda (weight1 weight2)
    (cond
      ((> weight1 weight2) (- 1 (/ weight1 weight2)))
      (else                (- (/ weight1 weight2) 1)))))


; -------------------------------------------------------------
; f)

(: empty-space image)
(define empty-space
  (empty-scene 40 40))

; Zeichnet die Waage
(: draw-scale (shape shape -> image))
; keine tests
(define draw-scale
  (lambda (shape1 shape2)
    (rotate (- (rotation-angle (shape-area shape1) (shape-area shape2))) (combine-shapes shape1 shape2))))



; Kombiniert die Übergebenen Formen in ein Gesamtbild
(: combine-shapes (shape shape -> image))
; keine tests
(define combine-shapes 
  (lambda (shape1 shape2)
    (overlay/pinhole
     (beside/align "bottom" (draw-shape shape1) empty-space (draw-shape shape2))
     (rectangle 50 2 "solid" "black"))))

 
























; -------------------------------------------------------------
; Testfälle

(define my-circle
  (make-circle-shape 20 "purple"))

(define my-other-circle
  (make-circle-shape 20 "blue"))

(define my-rectangle
  (make-rectangle-shape 20 20 "red"))

(define my-other-rectangle
  (make-rectangle-shape 10 20 "green"))

(define my-triangle
  (make-triangle-shape 20 "orange"))






































