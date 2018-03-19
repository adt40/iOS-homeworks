//
//  Pedigree.swift
//  pedigree
//
//  Created by Austin Toot on 2/28/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import Foundation

class Pedigree {
    var family : [Person]
    init(people : [Person]) {
        family = people
    }
    
    func getPerson(individualID : Int) -> Person? {
        for person in family {
            if person.individual == individualID {
                return person
            }
        }
        return nil
    }
    
    func removePerson(individualID : Int) {
        for person in family {
            if person.individual == individualID {
                family.remove(at: person.individual)
                break
            }
        }
    }
    
    func getID(individualID : Int, idType : IDType) -> Int? {
        for person in family {
            if person.individual == individualID {
                return person.getID(idType: idType)
            }
        }
        return nil
    }
}
