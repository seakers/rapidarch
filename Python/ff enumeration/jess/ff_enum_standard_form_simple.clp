(clear)
(defmodule TEST)
(deftemplate TEST::architecture (multislot assignments))

(defrule TEST::enumerate-all-archs-standard-form-naive
    "This grammar generates all valid architectures for a generic problem 
	with decisions in standard form"
    
    ?arch <- (TEST::architecture (assignments $?ass))
	(test (< (length$ $?ass) 5))
    =>
    (retract ?arch)
    (bind ?d1-opt (create$ 1 2 3))
    (bind ?d2-opt (create$ yes no))
    (bind ?d3-opt (create$ Moon Mars NEO L1))
    (bind ?d4-opt (create$ none 1 2))
    (bind ?d5-opt (create$ 5 10 15))
    (bind ?n (length$ $?ass))
    (bind ?list (eval (str-cat "?d" (+ ?n 1) "-opt")))
    (bind ?nel (length$ ?list))
    (for (bind ?i 1) (<= ?i ?nel) (++ ?i) 
        (bind ?new-ass (insert$ ?ass (+ ?n 1) (nth$ ?i ?list)))
        (assert (TEST::architecture (assignments ?new-ass)))
        )
    )

(reset)
(assert (TEST::architecture (assignments (create$ ))))
(watch all)
(focus TEST)
(run)