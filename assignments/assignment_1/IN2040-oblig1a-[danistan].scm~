;; Innlevering 1a i IN2040 (Høst 2021)


;;******************| Hjelpenotater fra folier |******************
#|Standardrelger for evaluering :

Schemes evalueringsregel:
  1) Evaluer enkelt-utrykkene i sammensetningen
     a) Primitive utrykk (tall, strenger etc): evalueres til seg selv
     b) Variabler: Evalueres til verdien de referer til
     c) Sammensatte uttrykk: anvend 1) igjen.

  2) Anvend operatoren (det første utrykket i lista) på veridene til de andre utrykkene.

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
Special forms: styrer selv om og når argumentene evalueres|#



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
  (if (zero? a);;Basistilfellet som terminerer den rekrusive prosessen                
      b
      (add1 (plus (sub1 a)
                  b))));;Den rekrusive prosedyren. 

#|Kommentar til den rekrusive prosessen:
Her har jeg prøvd å vise prosessen med argumentene a = 5 og b = 5

?(plus 5 5)
(+ 1 (plus 4 5))
(+ 1 (+ 1 (plus 3 5)
(+ 1 (+ 1 (+ 1 (plus 2 5))))
(+ 1 (+ 1 (+ 1 (+ 1 (plus 1 5)))))
(+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (plus 0 5))))))
(+ 1 (+ 1 (+ 1 (+ 1 (+ 1 5)))))
(+ 1 (+ 1 (+ 1 (+ 1 6))))
(+ 1 (+ 1 (+ 1 7)))
(+ 1 (+ 1 8))
(+ 1 9)
->10

|#


;;---------------------------------------------------------------
;; Oppgave 3c

#| Analyse av den rekrusive prosessen i 3b:

En rekrusiv prosess etterlater ventende prosedyrekall.
Disse kallene legges til i minnestacken frem prosessen oppnår basistilfellet (a = 0).
Først da begynner prosessen å regne ut. Dette er tilfellet i prosessen definert i oppgave 3b.

En iterativ prosessen derimot bruker en tellevariabel for å definere basistilfellet
og en akkumulatorvariabel som akkumulerer resultatet fortløpende. Dette gjør at minnestacken ikke vokser.
Det er viktig å merke at en iterativ prosess vil inneholde et rekrusiv prosedyre, men pga tellevariablen
og akkumulatorvariablen kan prosessen til enhver til oppsummere resultatet basert på disse inputene.

|#

(define (iter-plus a b)
  (define (iter prod count)  ;; Definerer iter med akkumulatorvariabelen prod og tellevariabelen count som argumenter.
    (if (> count a)          ;; Definerer basistilfellet, dvs når count > a returneres den akkumulerte verdien prod.
        prod
        (iter (add1 prod)    ;; Her akkumuleres prod. Dette er det rekrusive kallet og står i haleposisjonen.
              (add1 count))));; Her økes tellevariablen med 1, helt til a+1.

  (iter b 1))                ;; Kroppen til "iter-plus". Merk at prod er initiert til verdien b og count til 1.


#|Kommentar til den iterative prosessen
Her har jeg prøvd å vise prosessen med argumentene a = 4 og b = 5

?(iter-plus 4 5)
(iter 5 1)
(iter 6 2)
(iter 7 3)
(iter 8 4)
(iter 9 5)
->9

|#


;;---------------------------------------------------------------
;; Oppgave 3d

;; Under er power-close-to definert med power-iter som blokkstruktur.

(define (power-close-to b n)
  (define (power-iter count)
    (if (> (expt b count) n)
        count
        (power-iter (+ 1 count))))
  (power-iter 1))
        
#|Kommentar til prosedyren:
Ved å definere power-iter som en blokkstruktur av power-close-to slipper man å sende inn
b og n som argumenter i power-iter, da disse nå er globale variabler innenfor power-close-to prosedyren.
Det gjør dem tilgengelig for å kalles på i selve power-iter prosedyren.

I tillegg så fungerer tellevariablen i dette tilfellet også som den akkumulerte variabelen prod. Dermed
kan man forenkle definisjoen til power-iter fra å ta 3 argumenter til kun å ta 1 argument.
|#                    


;;---------------------------------------------------------------
;; Oppgave 3e


(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b)
                  a
                  (- count 1))))
  (fib-iter 1 0 n))


#|
?(fib 7)
(fib-iter 1 0 7)
(fib-iter 1 1 6)
(fib-iter 2 1 5)
(fib-iter 3 2 4)
(fib-iter 5 3 3)
(fib-iter 8 5 2)
(fib-iter 13 8 1)
(fib-iter 21 13 0)
-> 13

Svar:
Nei, man får ikke forenklet hjelpefunksjonen da fibonacci tallene er avhenging av å vite
forrige verdi lagt sammen med "nåverdi", dvs vi er nødt til å ha 2 akkumulator verdier.
I tillegg må hjelpefunksjonen initiere F(0)=b=0 og F(1)=a=1.

Samtidig som man må ha en telleverdi for å vite hvor mange rekrusive kall vi skal utføre/har utført.
|#

































































