//
//  Grid.swift
//  pedigree
//
//  Created by Austin Toot on 2/28/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import Foundation

class Grid {
    var gridLocations : [GridLocation] = []
    init(pedigree: Pedigree) {
        var generations : [[Int]] = [] //will contain a list of IDs that correspond to each generation
        let tempPedigree = pedigree
        var currentGeneration = 0
        
        while tempPedigree.family.count != 0 {
            generations[currentGeneration] = tempPedigree.getLastGenerationID()
            for individualID in generations[currentGeneration] {
                tempPedigree.removePerson(individualID: individualID)
            }
            currentGeneration += 1
        }
        
        
        generations.reverse() //to iterate through from first gen to last
        
        for gen in generations {
            for individualID in gen {
                let children = pedigree.getChildrenIDs(individualID: individualID)
                //find parent with same children as this one
                
                //oh god there is no way this is what was intended
            }
        }
        
    }
    private func addPersonToGrid(person: Person, location: Coord) {
        if person.gender == 1 {
            if person.affected == 0 {
                addToGrid(type: .square, location: location)
            } else {
                addToGrid(type: .shadedSquare, location: location)
            }
        } else {
            if person.affected == 0 {
                addToGrid(type: .circle, location: location)
            } else {
                addToGrid(type: .shadedCircle, location: location)
            }
        }
    }
    private func addToGrid(type : GridObject, location: Coord) {
        gridLocations.append(GridLocation(coord: location, gridObject: type))
    }
    
}
