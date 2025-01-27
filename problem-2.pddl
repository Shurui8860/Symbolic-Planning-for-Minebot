(define (problem mineBot-world2)

    (:domain mineBot-world2)
    (:objects 
        r - mineBot
        c1 - cell
        c2 - cell
        c3 - cell
        c4 - cell
        c5 - cell
        c6 - cell
        c7 - cell
        c8 - cell
        c9 - cell
        c10 - cell
        c11 - cell
        c12 - cell
        c13 - cell
        c14 - cell
        c15 - cell
        c16 - cell
        c17 - cell
        c18 - cell
        c19 - cell
        c20 - cell
        c21 - cell
        c22 - cell
        c23 - cell
        oreA - ore
        oreB - ore
        oreC - ore
        h - hammer
        l - lift
        e - energy_station
    )
    
    (:init
        (On r c17)
        (= (battery-capacity r) 40)
        (= (battery-amount r) 40)
        (On e c12)
        (On h c8)
        (On l c23)
        (On oreA c1)
        (On oreB c3)
        (On oreC c10)
        (Blocked oreB)
        (Blocked oreC)
        
        (Connected c1 c5)
        (Connected c2 c3)
        (Connected c2 c7)
        (Connected c3 c2)
        (Connected c4 c5)
        (Connected c4 c9)
        (Connected c5 c1)
        (Connected c5 c4)
        (Connected c5 c6)
        (Connected c6 c5)
        (Connected c6 c10)
        (Connected c7 c2)
        (Connected c7 c11)
        (Connected c8 c9)
        (Connected c9 c4)
        (Connected c9 c8)
        (Connected c9 c13)
        (Connected c10 c6)
        (Connected c10 c15)
        (Connected c11 c7)
        (Connected c11 c12)
        (Connected c11 c17)
        (Connected c12 c11)
        (Connected c13 c9)
        (Connected c13 c14)
        (Connected c14 c13)
        (Connected c14 c15)
        (Connected c15 c14)
        (Connected c15 c10)
        (Connected c15 c16)
        (Connected c15 c18)
        (Connected c16 c15)
        (Connected c16 c17)
        (Connected c17 c11)
        (Connected c17 c16)
        (Connected c17 c19)
        (Connected c18 c15)
        (Connected c18 c20)
        (Connected c19 c17)
        (Connected c19 c22)
        (Connected c20 c18)
        (Connected c20 c21)
        (Connected c21 c20)
        (Connected c21 c22)
        (Connected c21 c23)
        (Connected c22 c21)
        (Connected c22 c19)
        (Connected c23 c21)
    )
    
    (:goal (
        forall (?o - ore) (Finished ?o)
    ))
)