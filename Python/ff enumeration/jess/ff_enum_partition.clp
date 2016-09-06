(clear)
(defmodule TEST)
(deftemplate TEST::partitioning-architecture (multislot assignments))


(defrule TEST::enumerate-all-partitions
    "This grammar generates all valid architectures for a generic set partitioning problem, 
    plus many invalid architectures that are then filtered out"
    
    ?arch <- (TEST::partitioning-architecture (assignments $?ass))
	(test (< (length$ ?ass) 6))
    =>
    (retract ?arch)
    (bind ?n (length$ ?ass))
    (bind ?mx (max$ ?ass)) ; index of current last subset
    (for (bind ?i 1) (<= ?i (+ ?mx 1)) (++ ?i) ; add new archs so that next element is assigned every possible subset created so far plus a new one
        (bind ?new-ass (insert$ ?ass (+ ?n 1) ?i))
        (assert (TEST::partitioning-architecture (assignments ?new-ass)))
        )
    )

(deffunction max$ (?list)
    (bind ?size (length$ ?list))
    (bind ?mx 0)
    (for (bind ?i 1) (<= ?i ?size) (++ ?i)
        (bind ?el (nth$ ?i ?list))
    	(if (> ?el ?mx) then (bind ?mx ?el))
        )
    (return ?mx))
	
(deffunction random_int (?min ?max)
    (bind ?rnd (* (/ (random) 65536) (- (+ 0.5 ?max) (- ?min 0.5)))); random real between 0 and max - min + 1
    (bind ?x (+ (- ?min 0.5) ?rnd)); random real between min - 0.5 and max + 0.5
    (return (round ?x))
    )
	
;(defrule TEST::grammar-B-set-partitioning-random-enum
;    "This grammar generates some valid architectures for a generic set partitioning problem"
;    
;    ?arch <- (TEST::partitioning-architecture (assignments $?ass));
	;(test (< (length$ ?ass) 13))
    ;=>
    ;(bind ?N 4)
    ;(retract ?arch)
    ;(bind ?n (length$ ?ass))
    ;(bind ?mx (max$ ?ass)) ; index of current last element of form
    ;(for (bind ?i 1) (<= ?i ?N) (++ ?i) ; only loop N times
    ;    (bind ?new-ass (insert$ ?ass (+ ?n 1) (random_int 1 (+ ?mx 1)))); insert random number between 1 and max + 1
    ;    (assert (TEST::partitioning-architecture (assignments ?new-ass)))
    ;    )
    ;)
	
(defquery TEST::count-SPP-architectures
    (TEST::partitioning-architecture (assignments $?ass))
    )


(reset)
(focus TEST)
(unwatch all)
(assert (TEST::partitioning-architecture (assignments (create$ 1))))


