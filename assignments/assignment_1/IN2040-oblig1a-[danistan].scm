;; Innlevering 1a i IN2040 (Høst 2021)


;; ******************| Hjelpenotater |*********************************************
#|Standardrelger for evaluering:

Først evalueres alle enkelt-uttrykkene, så kalles prosedyren på argumentverdiene
 - Symboler evalueres til bundet verdi
 - Primitive uttrykk evaluers til seg selv, type tall
 - Sammensatte utrykk: Som over.

NB! Unntak fra disse reglene er såkalte "special forms"
 - define
 - and, or, not
 - if, cond

Kort fortalt:
Prosedyrer: Først evalueres alle argumentene, så anvendes prosedyren
Special forms: styrer selv om og når argumentene evalueres

Schemes evalueringsregel:
  1) Evaluer enkelt-utrykkene i sammensetningen
     a) Primitive utrykk (tall, strenger etc): evalueres til seg selv
     b) Variabler: Evalueres til verdien de referer til
     c) Sammensatte uttrykk: anvend 1) igjen.

  2) Anvend operatoren (det første utrykket i lista) på veridene til de andre utrykkene.|#

;;******************| Oppgave 1 |******************
;; Oppgave 1a

(* (+ 4 2) 5)

#|Svar:
Et sammensatt utrykk.
Først evalueres prosedyre "+" med argumentene 4 og 2
      -> (+ 4 2) = 6
Deretter evalueres prosedyren "*" med argumentene 6 og 5
      -> (* 6 5) = 30|#

;;-------------------------------------------------
;; Oppgave 1b

;; (* (+ 4 2) (5))

#|Svar:
(5) gi feilmelding.
Første element i en liste er prefikset en operator.
Her kalles prosedyren 5, som ikke finnes.|#

;;-------------------------------------------------
;; Oppgave 1c

;; (* (4 + 2) 5)

#|Svar:
(4 + 2) vil gi feilmelding.
Her kalles prosedyre 4, som ikke finnes, med argumentene + og 2|#

;;-------------------------------------------------
;; Oppgave 1d

(define bar (/ 44 2))
bar

#| Svar:
define er såkalt "special form".
define gir oss mulighet å introdusere en variabel samt binder en verdi eller prosedyre til variablen.
først evalueres prosedyre "/" med argumentene 44 og 2
      -> (/ 44 2) = 22
deretter bindes verdien 22 til variablen "bar".|#

;;-------------------------------------------------
;; Oppgave 1e

(- bar 11)

#| Svar:
Først evalueres bar, dvs bar = 22
Deretter kalles prosedyre "-" med argumentene 22 og 11.
      -> (- 22 11) = 11|#

;;-------------------------------------------------
;; Oppgave 1f

(/ (* bar 3 4 1) bar)

#| Svar:
Først evalueres symbolet i indre utrykket.
      -> (* bar 3 4 1) = (* 22 3 4 1)
Deretter evalueres prosedyren "*" med argumentene 22, 3, 4 og 1.
      -> (* 22 3 4 1) = 264
Så evalueres symbolet i ytre utrykk.
      -> (/ 264 bar) = (/ 264 22)
Til slutt så evalueres prosedyre "/" med argumentene 264 og 22.
      -> (/ 264 22) = 12|#

;;******************| Oppgave 2 |******************
;; Oppgave 2a

#|Special form:
  Styrer selv om og når argumentene evalueres
     - if og cond: utfallet av testene avgjør hvilke uttrykk som skal evalueres
     - or og and: evaluerer utrykkene én av gangen, fra venstre til høyre
     - Alt utenom #f teller som sant.|#

(or (= 1 2)
    "paff"
    "piff"
    (zero? (1 - 1)))

#|Kommentar til prosedyren:
Selv om det er en syntax feil i siste linje, vil det ikke gi en feilmelding.
Dette er fordi siste linje ikke blir evaluert, da "paff" = #t.
or-prosedyren vil stoppe evaluering av utrykk ved første tilfelle av sant.
Dette gjør or-prosedyren til "special form", da den selv velger hvilke utrykk som skal evalueres.
Her vil (= 1 2) = #f, men "paff" = #t, dermed blir ikke "piff" og (zero? (1 - 1)) evaluert.
Verdien som returneres er "paff".
|#

(and (= 1 2)
     "paff"
     "piff"
     (zero? (1 - 1)))
#|Kommentar til prosedyren:
Dette vil være omtrent samme tilfellet som or-prosedyre, forskjellen er at den stopper å evaluere ved første #f.
Første uttrykk (= 1 2) = #f, dermed vil de resterende uttrykkene ikke evalueres.
Dette gjør and-prosedyren til en "special form".
Verdien som returneres er #f
|#

(if (positive? 42)
    "poff"
    (i-am-undef))
#|Kommentar til prosedyren:
42 er alltid positiv i dette tilfellet. Dermed vil if-prosedyren stoppe
ved første test og ikke evaluere else-casen.
|# 
 
;;---------------------------------------------------------------
;; Oppgave 2b

(define (if-sign x)
  (if (> x 0)    ;; første sjekk, (x > 0)
      1          ;; dersom sant, returner 1
      (if (< x 0);; dersom usant, sjekk (x < 0)
          -1     ;; dersom sant, returner -1
          0)))   ;; dersom usant, returner 0

(define (cond-sign x)
  (cond ((> x 0) 1) ;; returner 1 dersom x > 0
        ((< x 0) -1);; returner -1 dersom x < 0
        (else 0)))  ;; returner 0 for alle andre tilfeller, dvs x = 0

;;---------------------------------------------------------------
;; Oppgave 2c

#|Husk:
or-prosedyren evaluerer frem til første #t
and-prosedyren evaluerer frem til første #f
|#

(define (pred-sign x)
  (or (and (> x 0) ;;Dersom x > 0 = #t evalueres 1 (som er #t) og returneres 
            1)     ;;Dersom x > 0 = #f evalueres ikke 1, og or-prosedyren fortsetter til neste utrykk
      (and (< x 0) ;;Dersom x < 0 = #t evalueres -1 (som er #t) og returneres 
           -1)     ;;Dersom x < 0 = #f evalueres ikke -1, og or-prosedyren fortsetter til neste utrykk
      0))          ;;Evaluerer 0 = #t, dermed finner or-prosedyren første #t og returner den

;;******************| Oppgave 3 |******************
;; Oppgave 3a

(define (add1 x)
  (+ x 1))

(define (sub1 x)
  (- x 1))

;;---------------------------------------------------------------
;; Oppgave 3b

(define (plus a b)
  (if (zero? a)                
      b
      (add1 (plus (sub1 a) b))))

#|Kommentar til den rekrusive prosessen:
Her har jeg prøvd å vise hvordan prosessen med argumentene a = 5 og b = 5

(plus 5 5)
(add1 (plus 4 5))
(add1 (add1 (plus 3 5)
(add1 (add1 (add1 (plus 2 5))))
(add1 (add1 (add1 (add1 (plus 1 5)))))
(add1 (add1 (add1 (add1 (add1 (plus 0 5))))))
(add1 (add1 (add1 (add1 (+ 5 1)))))
(add1 (add1 (add1 (+ 6 1))))
(add1 (add1 (+ 7 1)))
(add1 (+ 8 1))
(+ 9 1)
10

|#
