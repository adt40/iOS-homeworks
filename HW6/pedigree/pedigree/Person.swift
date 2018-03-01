//
//  Person.swift
//  pedigree
//
//  Created by Austin Toot on 2/28/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import Foundation

struct Person {
    var family : Int
    var individual : Int
    var father : Int
    var mother : Int
    var gender : Int //oooh controvertial variables, my favorite
    var affected : Int
    init (familyID : Int, individualID : Int, fatherID : Int, motherID : Int, genderID : Int, affectedStatus : Int) {
        family = familyID
        individual = individualID
        father = fatherID
        mother = motherID
        gender = genderID
        affected = affectedStatus
    }
    func getID(idType: IDType) -> Int {
        switch idType {
        case .familyID :
            return family
        case .fatherID :
            return father
        case .motherID :
            return mother
        case .individualID :
            return individual
        case .genderID :
            return gender
        case .affectedStatus :
            return affected
        }
    }
}
