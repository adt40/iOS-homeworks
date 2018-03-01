//
//  GridLocation.swift
//  pedigree
//
//  Created by Austin Toot on 2/28/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import Foundation

struct GridLocation {
    var coord : Coord
    var gridObject : GridObject
    init(coord: Coord, gridObject: GridObject) {
        self.coord = coord
        self.gridObject = gridObject
    }
}
