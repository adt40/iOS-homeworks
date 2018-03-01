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
                family.remove(person)
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
    
    func getAllOfID(idType : IDType) -> [Int] {
        var idArr : [Int] = []
        for person in family {
            idArr.append(person.getID(idType: idType))
        }
        return idArr
    }
    
    func getChildrenIDs(individualID : Int) -> [Int] {
        var idArr : [Int] = []
        for person in family {
            if person.father == individualID || person.mother == individualID {
                idArr.append(person.individual)
            }
        }
        return idArr
    }
    
    func getLastGenerationID() -> [Int] {
        var idArr : [Int] = []
        for person in family {
            if getChildrenIDs(individualID: person.individual).count == 0 {
                idArr.append(person.individual)
            }
        }
        return idArr
    }
}
