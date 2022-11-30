;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname A05_1) (read-case-sensitive #f) (teachpacks ((lib "image.rkt" "teachpack" "deinprogramm" "sdp") (lib "universe.rkt" "teachpack" "deinprogramm" "sdp"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image.rkt" "teachpack" "deinprogramm" "sdp") (lib "universe.rkt" "teachpack" "deinprogramm" "sdp")))))
; Assignment 05

; Aufgabe 2

; Definition record1 
(: make-record1 (natural (mixed record2 natural) natural -> record1 ))
(: record1?  ( any -> boolean ))
(: record1-a ( record1 -> natural ) )
(: record1-b ( record1 -> ( mixed record2 natural ) ) )
(: record1-c ( record1 -> natural ) )
( define-record record1
   make-record1
   record1?
   ( record1-a natural )
   ( record1-b ( mixed record2 natural ) )
   ( record1-c natural ) )


; Definition record2
(: make-record2 ( natural natural -> record2 ) )
(: record2? ( any -> boolean ))
(: record2-d ( record2 -> natural ) )
(: record2-e ( record2 -> natural ) )
( define-record record2
   make-record2
   record2?
   ( record2-d natural )
   ( record2-e natural ) )


; Definition match-Funktion
(: f ( record1  -> integer ) )
( define f
   ( lambda (x)
      ( match x
         (( make-record1 _ ( make-record2 4 2) _) 42)
         (( make-record1 a ( make-record2 d e) _) (- a (* e d)) )
         (( make-record1 a b c) (+ a b c))) ) )

; Testfälle
(define josh ; wirft Signaturverletzung
  (make-record2 2 2))

(define jason ; matches Zweig 1 ==> 42 
  (make-record1 147610576 (make-record2 4 2) 4395613457))

(define ben  ; matches Zweig 2  ==> -2
  (make-record1 2 josh 2))

(define aaron ; matches Zweig 3 ==>  6
  (make-record1 2 2 2))


; --------------------------------------------------------------------------------------------------------------------
; Teilaufgabe a)

; Funktion f* soll Funktion f ohne pattern-matching implementieren
(: f* ((predicate record1?) -> integer))
(check-expect (f* jason) (f jason))
(check-expect (f* ben)   (f ben))
(check-expect (f* aaron) (f aaron))
;(check-expect (f* josh) (f josh)) ; laut Aufgabenstellung wird kein fehlerhafter Input erwartet
(define f*
  (lambda (x)
    (cond
      ((record2? (record1-b x)) 
       (if (and (= (record2-d (record1-b x)) 4) (= (record2-e ( record1-b x)) 2))
           42                                                                          ; if evaluiert zu #t -> Zweig 1
           (- (record1-a x) (* (record2-d (record1-b x)) (record2-e (record1-b x)))))) ; if evaluiert zu #f -> Zweig 2
      (else (+ (record1-a x) (record1-b x) (record1-c x))))))                          ; Zweig 3



; --------------------------------------------------------------------------------------------------------------------
; Teilaufgabe b)

; Prüft, ob f und f* sich tatsächlich gleich verhalten
(check-property
 (for-all ((a natural)
           (b natural)
           (c natural))
   (= (f (make-record1 a b c)) (f* (make-record1 a b c)))))




 


































