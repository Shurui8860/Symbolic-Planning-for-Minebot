(define (domain mineBot-world5)
    
    (:requirements :typing :equality :adl :fluents)

    (:types hammer fire_extinguisher detector - tools  
        
        ore tools - phyobj

        mineBot exploreBot - bot 

        cell lift energy_station
    )
    
    (:functions
    (battery-amount ?r - bot)
    (battery-capacity ?r - bot)
    (weight ?obj - phyobj)
    (capacity ?r - bot)
    )

    (:predicates 
        (On ?b - object ?loc - cell)
        (Connected ?x - cell ?y - cell)

        (Blocked ?o - ore)
        (Explored ?o - ore)
        (Free ?r - bot)
        (Holding ?r - bot)
        (Holding_large ?r1 - mineBot ?r2 - mineBot)

        (Holded ?obj - phyobj ?r - bot)
        (Holded_large ?obj - phyobj ?r1 - mineBot ?r2 - mineBot)
        (In ?o - ore ?l - lift)
        (Finished ?o - ore)
        (Fire ?loc - cell)
        
    )

    (:action MOVE
        :parameters (?r - bot ?loc_from - cell ?loc_to - cell)
        :precondition (and  
            (Free ?r) 
            (On ?r ?loc_from) 
            (Connected ?loc_from ?loc_to) 
            (>= (battery-amount ?r) 1) 
            (not (Fire ?loc_to))    
        )
        :effect (and 
            (not (On ?r ?loc_from)) 
            (On ?r ?loc_to) 
            (decrease  (battery-amount ?r) 1)    
        )
    )

    (:action DETECT
        :parameters (?r - exploreBot ?loc - cell ?o - ore ?obj - detector)
        :precondition (and 
            (not (Explored ?o)) 
            (On ?o ?loc) 
            (On ?r ?loc)
            (Holding ?r)
            (Holded ?obj ?r)
        )
        :effect (and (Explored ?o))
    )

    (:action MOVE-HOLDING
        :parameters (?r - bot ?loc_from - cell ?loc_to - cell)
        :precondition (and 
            (Holding ?r) 
            (>= (battery-amount ?r) 3) 
            (On ?r ?loc_from) 
            (Connected ?loc_from ?loc_to) 
            (not (Fire ?loc_to))    
        )
        :effect (and 
            (not (On ?r ?loc_from)) 
            (On ?r ?loc_to) 
            (decrease (battery-amount ?r) 3)    
        )
    )

    (:action MOVE-HOLDING-LARGE
        :parameters (?r1 - mineBot ?r2 - mineBot ?loc_from - cell ?loc_to - cell)
        :precondition (and 
            (Holding_large ?r1 ?r2) 
            (On ?r1 ?loc_from) 
            (On ?r2 ?loc_from) 
            (Connected ?loc_from ?loc_to) 
            (not (Fire ?loc_to)) 
            (>= (battery-amount ?r1) 3) 
            (>= (battery-amount ?r2) 3)    
        )
        :effect (and 
            (not (On ?r1 ?loc_from)) 
            (On ?r1 ?loc_to) 
            (not (On ?r2 ?loc_from)) 
            (On ?r2 ?loc_to) 
            (decrease (battery-amount ?r1) 3) 
            (decrease (battery-amount ?r2) 3)    
        )
    )
    
    (:action CHARGE
        :parameters (?r - bot ?loc - cell ?e - energy_station)
        :precondition (and 
            (On ?e ?loc) 
            (On ?e ?loc)    
        )
        :effect (and 
            (assign (battery-amount ?r) (battery-capacity ?r))    
        )
    )

    (:action EXTINGUISH
        :parameters (?r - mineBot ?f - fire_extinguisher ?loc_from - cell ?loc_to - cell)
        :precondition (and 
            (On ?r ?loc_from) 
            (Holded ?f ?r) 
            (Fire ?loc_to) 
            (Connected ?loc_from ?loc_to)    
        )
        :effect (and 
            (not (Fire ?loc_to))    
        )
    )

    (:action PICK-UP
        :parameters (?r - bot ?obj - tools ?loc - cell)
        :precondition (and 
            (Free ?r) 
            (On ?r ?loc) 
            (On ?obj ?loc) 
        )
        :effect (and 
            (Holding ?r) 
            (not (Free ?r)) 
            (Holded ?obj ?r) 
            (not (On ?obj ?loc))    
        )
    )

    (:action DROP
        :parameters (?r - bot ?obj - phyobj ?loc - cell)
        :precondition (and 
            (Holding ?r) 
            (Holded ?obj ?r) 
            (On ?r ?loc)    
        )
        :effect (and 
            (not (Holded ?obj ?r)) 
            (Free ?r) 
            (not (Holding ?r)) 
            (On ?obj ?loc)    
        )
    )

    (:action BREAK
        :parameters (?r - mineBot ?h - hammer ?o - ore ?loc - cell)
        :precondition (and 
            (Holding ?r) 
            (Holded ?h ?r) 
            (On ?r ?loc) 
            (On ?o ?loc) 
            (Blocked ?o)    
        )
        :effect (and 
            (not (Blocked ?o))    
        )
    )

    (:action MINE-SMALL
        :parameters (?r - mineBot ?o - ore ?loc - cell)
        :precondition (and 
            (On ?r ?loc) 
            (On ?o ?loc) 
            (not (Blocked ?o)) 
            (Free ?r) 
            (Explored ?o)
            (>= (capacity ?r) (weight ?o))  
        )
        :effect (and 
            (Holded ?o ?r) 
            (Holding ?r) 
            (not (Free ?r)) 
            (not (On ?o ?loc))    
        )
    )
    
    (:action MINE-LARGE
        :parameters (?r1 - mineBot ?r2 - mineBot ?o - ore ?loc - cell)
        :precondition (and 
            (not (= ?r1 ?r2)) 
            (On ?r1 ?loc) 
            (On ?r2 ?loc) 
            (On ?o ?loc)
            (Explored ?o) 
            (not (Blocked ?o)) 
            (Free ?r1) 
            (Free ?r2)
            (>= (+ (capacity ?r1) (capacity ?r2)) (weight ?o))   
        )
        :effect (and 
            (not (Free ?r1)) 
            (not (Free ?r2)) 
            (Holding_large ?r1 ?r2) 
            (Holded_large ?o ?r1 ?r2) 
            (not (On ?o ?loc))    
        )
    )
    

    (:action DROP-LARGE
        :parameters (?r1 - mineBot ?r2 - mineBot ?o - ore ?loc - cell)
        :precondition (and 
            (Holding_large ?r1 ?r2) 
            (Holded_large ?o ?r1 ?r2) 
            (On ?r1 ?loc) 
            (On ?r2 ?loc)    
        )
        :effect (and 
            (Free ?r1) 
            (Free ?r2) 
            (not (Holding_large ?r1 ?r2)) 
            (not (Holded_large ?o ?r1 ?r2)) 
            (On ?o ?loc)    
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
        :parameters (?r - bot ?l - lift ?loc - cell )
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
