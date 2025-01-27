(define (domain mineBot-world2)
    
    (:requirements :typing :equality :adl :fluents)

    (:types ore hammer - phyobj
        mineBot cell lift energy_station
    )
    
    (:functions
    (battery-amount ?r - mineBot)
    (battery-capacity ?r - mineBot)
    )

    (:predicates 
        (On ?b - object ?loc - cell)
        (Connected ?x - cell ?y - cell)
        (Blocked ?o - ore)
        (Holding ?r - mineBot)
        (Holded ?obj - phyobj)
        (In ?o - ore ?l - lift)
        (Finished ?o - ore)
    )

    (:action MOVE
        :parameters (?r - mineBot ?loc_from - cell ?loc_to - cell)
        :precondition (and  
            (not (Holding ?r)) 
            (On ?r ?loc_from) 
            (Connected ?loc_from ?loc_to) 
            (>= (battery-amount ?r) 1)    
        )
        :effect (and 
            (not (On ?r ?loc_from)) 
            (On ?r ?loc_to) 
            (decrease  (battery-amount ?r) 1)    
        )
    )

    (:action MOVE-HOLDING
        :parameters (?r - mineBot ?loc_from - cell ?loc_to - cell)
        :precondition (and 
            (Holding ?r) 
            (>= (battery-amount ?r) 3) 
            (On ?r ?loc_from) 
            (Connected ?loc_from ?loc_to)    
        )
        :effect (and 
            (not (On ?r ?loc_from)) 
            (On ?r ?loc_to) 
            (decrease (battery-amount ?r) 3)    
        )
    )

    (:action CHARGE
        :parameters (?r - mineBot ?loc - cell ?e - energy_station)
        :precondition (and 
            (On ?e ?loc) 
            (On ?e ?loc)    
        )
        :effect (and 
            (assign (battery-amount ?r) 
            (battery-capacity ?r))    
        )
    )

    (:action PICK-UP
        :parameters (?r - mineBot ?h - hammer ?loc - cell)
        :precondition (and 
            (not (Holding ?r)) 
            (On ?r ?loc) 
            (On ?h ?loc)     
        )
        :effect (and 
            (Holding ?r) 
            (Holded ?h) 
            (not (On ?h ?loc))    
        )
    )

    (:action DROP
        :parameters (?r - mineBot ?obj - phyobj ?loc - cell)
        :precondition (and 
            (Holding ?r) 
            (Holded ?obj) 
            (On ?r ?loc)    
        )
        :effect (and 
            (not (Holded ?obj)) 
            (not (Holding ?r)) 
            (On ?obj ?loc)    
        )
    )

    (:action BREAK
        :parameters (?r - mineBot ?h - hammer ?o - ore ?loc - cell)
        :precondition (and
            (Holding ?r) 
            (Holded ?h) 
            (On ?r ?loc) 
            (On ?o ?loc) 
            (Blocked ?o)    
        )
        :effect (and 
            (not (Blocked ?o))
        )
    )

    (:action MINE
        :parameters (?r - mineBot ?o - ore ?loc - cell)
        :precondition (and 
            (On ?r ?loc) 
            (On ?o ?loc) 
            (not (Blocked ?o)) 
            (not (Holding ?r))    
        )
        :effect (and 
            (Holded ?o) 
            (Holding ?r) 
            (not (On ?o ?loc))    
        )
    )
    
    (:action PUT-IN-LIFT
        :parameters (?r - mineBot ?o - ore ?l - lift ?loc - cell)
        :precondition (and 
            (On ?r ?loc) 
            (On ?o ?loc) 
            (On ?l ?loc)    
        )
        :effect (and 
            (In ?o ?l) 
            (not (On ?o ?loc))    
        )
    )
    
    (:action TURN-LIFT
        :parameters (?r - mineBot ?l - lift ?loc - cell)
        :precondition (and 
            (On ?r ?loc) 
            (On ?l ?loc)     
        )
        :effect (forall (?o - ore) 
                (when (In ?o ?l) 
                (and 
                    (not (In ?o ?l)) 
                    (Finished ?o)))
                )
    )
)  