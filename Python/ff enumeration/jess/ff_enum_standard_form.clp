
(clear)
(deftemplate DECISION (slot name) (multislot options))

(defquery get-decisions
    (DECISION (name ?name))
    )

(deffunction get-decision-names ()
    (bind ?result (run-query* get-decisions))
    (bind ?list (create$ ))
    (while (?result next)
    (bind ?list (insert$ ?list (+ 1 (length$ ?list)) (?result getString name)))
        )
    (return (map eval ?list))
    )


(defrule create-architecture-template
    "This rule creates an architecture template that contains slots for each decision"
    
    ?c <- (accumulate (bind ?list (create$ ))                        ;; initializer
                (bind ?list (insert$ ?list (+ 1 (length$ ?list)) ?n))                    ;; action
                ?list                                        ;; result
                (DECISION (name ?n))) ;; CE
    =>
    (bind ?str "(deftemplate DECISION-ARCH (slot num-decisions) (multislot decision-names) (multislot sequence) (multislot str)")
    (foreach ?dec ?c 
        (bind ?str (str-cat ?str "(slot " ?dec ")")))
    (bind ?str (str-cat ?str ")"))
    (eval ?str)
    )



(reset)
(assert (DECISION (name num-boosters) (options (create$ 1 2 4))))
(assert (DECISION (name propellant1) (options (create$ LH2 CH4 RP1))))
(assert (DECISION (name propellant2) (options (create$ LH2 CH4 RP1))))
(unwatch all)
(focus HARD-CONSTRAINTS)
(run)


(undefrule create-architecture-template)
(bind ?names (get-decision-names))
(bind ?num (count-query-results get-decisions))
(assert (DECISION-ARCH (num-decisions ?num) (decision-names ?names) (sequence (create$ )) (str (create$ ))))



(deffunction rare-randb (?p)  
    (return (< (random) (* ?p 65536)))
    )


(defrule enumerate-some-architectures
    "This rule enumerates all possible assignments of options to decisions"
    ?arch <- (DECISION-ARCH (decision-names $?list) (num-decisions ?n) (sequence $?seq) (str $?str) )
    (DECISION (name ?name) (options $?opt))
    (test (< (length$ ?seq) ?n))
    (test (eq ?name (nth$ (+ 1 (length$ ?seq)) ?list)))
    
    =>
    (retract ?arch)
    (bind ?i 1)
    (foreach ?value ?opt
        (bind ?new-seq (insert$ ?seq (+ 1 (length$ ?seq)) ?i))
        (bind ?new-str (insert$ ?str (+ 1 (length$ ?str)) ?value))
		(printout t ?new-seq crlf)
        (printout t ?new-str crlf)
        (if (rare-randb 0.5) then (assert (DECISION-ARCH (num-decisions ?n) (decision-names ?list) (sequence ?new-seq) 
                (str ?new-str))))
        (++ ?i)
        )
    
    )


(defquery get-OAP-architectures
    (DECISION-ARCH (sequence $?seq))
    )

(deffunction count-OAP-archs ()
    (return (count-query-results get-OAP-architectures))
    )


(watch all)
(focus HARD-CONSTRAINTS)
(run)

;(ppdeftemplate DECISION-ARCH)
(facts)