(clear)
(defmodule TEST)
(deftemplate TEST::PERMUTING-ARCH (multislot sequence))

(defrule TEST::enumerate-all-permutations
    "This rule enumerates all possible permutations of a set of m elements"
    ?arch <- (TEST::PERMUTING-ARCH (sequence $?seq))
    (test (< (length$ ?seq) 4))
    =>
    (retract ?arch)
    (bind ?n (length$ ?seq))
    (for (bind ?i 1) (<= ?i 4) (++ ?i) 
        (if (eq (member$ ?i ?seq) FALSE) then 
            (bind ?new-seq (insert$ ?seq (+ ?n 1) ?i))
        (assert (TEST::PERMUTING-ARCH (sequence ?new-seq)))
            )
        )
    )

;(deffunction rare-randb (?p)  
;    (return (< (random) (* ?p 65536)))
;    )

;(defrule TEST::enumerate-some-permutations
;    "This rule enumerates some random permutations of a set of m elements"
;    ?arch <- (TEST::PERMUTING-ARCH (sequence $?seq))
;    (test (< (length$ ?seq) 5))
;    =>
;    (retract ?arch)
;    (bind ?n (length$ ?seq))
;    (for (bind ?i 1) (<= ?i 5) (++ ?i) 
;        (if (eq (member$ ?i ?seq) FALSE) then 
;            (bind ?new-seq (insert$ ?seq (+ ?n 1) ?i))
;        (if (rare-randb 0.1) then (assert (TEST::PERMUTING-ARCH (sequence ?new-seq))))
;            )
;        )
;    )

(defquery TEST::count-EPP-architectures
    ?arch <- (TEST::PERMUTING-ARCH (sequence $?seq))
    )
(reset)
(assert (TEST::PERMUTING-ARCH (sequence (create$ ))))
(focus TEST)
(watch all)
;(run)
;(facts TEST)
;(bind ?n (count-query-results TEST::count-EPP-architectures))
;(printout t "there are " ?n " architectures" crlf)