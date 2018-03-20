//
//  pedigreeView.swift
//  pedigree
//
//  Created by Austin Toot on 3/4/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

extension CGRect{
    init(_ x: Int, _ y : Int, _ w: Int, _ h: Int){
        self.init(x:x, y:y, width: w, height:h)
    }
}

class PedigreeView: UIView {
    
    var pedigree : Pedigree!
    
    private let drawSize = 80
    private let startx = 50
    private let starty = 50
    
    override func draw(_ rect: CGRect) {
        initScreen()
        drawSquare(   x: startx + drawSize * 0, y: starty + drawSize * 0, affected: Bool(truncating: pedigree.getPerson(individualID: 1)!.affected as NSNumber))
        drawConnector(x: startx + drawSize * 1, y: starty + drawSize * 0, down: true)
        drawCircle(   x: startx + drawSize * 2, y: starty + drawSize * 0, affected: Bool(truncating: pedigree.getPerson(individualID: 2)!.affected as NSNumber))
        drawCircle(   x: startx + drawSize * 1, y: starty + drawSize * 1, affected: Bool(truncating: pedigree.getPerson(individualID: 3)!.affected as NSNumber))
        drawConnector(x: startx + drawSize * 2, y: starty + drawSize * 1, down: true)
        drawSquare(   x: startx + drawSize * 3, y: starty + drawSize * 1, affected: Bool(truncating: pedigree.getPerson(individualID: 4)!.affected as NSNumber))
        drawTwoPersonConnector(x: startx + drawSize * 1, y: starty + drawSize * 2)
        drawCircle(   x: startx + drawSize * 1, y: starty + drawSize * 3, affected: Bool(truncating: pedigree.getPerson(individualID: 5)!.affected as NSNumber))
        drawSquare(   x: startx + drawSize * 3, y: starty + drawSize * 3, affected: Bool(truncating: pedigree.getPerson(individualID: 6)!.affected as NSNumber))
    }
    
    private func initScreen() {
        let rect = UIBezierPath(rect: self.bounds)
        UIColor.white.setFill()
        rect.fill()
    }
    
    private func drawTwoPersonConnector(x: Int, y: Int) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x + drawSize / 2, y: y + drawSize))
        path.addLine(to: CGPoint(x: x + drawSize / 2, y: y + drawSize / 2))
        path.addLine(to: CGPoint(x: x + (drawSize * 5) / 2, y: y + drawSize / 2))
        path.addLine(to: CGPoint(x: x + (drawSize * 5) / 2, y: y + drawSize))
        drawConnector(x: x + drawSize, y: y, down: false)
        UIColor.black.setStroke()
        path.lineWidth = 3
        path.stroke()
    }
    
    private func drawConnector(x: Int, y: Int, down: Bool) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: y + drawSize / 2))
        path.addLine(to: CGPoint(x: x + drawSize, y: y + drawSize / 2))
        path.move(to: CGPoint(x: x + drawSize / 2, y: y + drawSize / 2))
        if down {
            path.addLine(to: CGPoint(x: x + drawSize / 2, y: y + drawSize))
        } else {
            path.addLine(to: CGPoint(x: x + drawSize / 2, y: y))
        }
        UIColor.black.setStroke()
        path.lineWidth = 3
        path.stroke()
    }
    
    private func drawCircle(x: Int, y: Int, affected: Bool) {
        let circle = UIBezierPath(ovalIn: CGRect(x, y, drawSize, drawSize))
        if affected {
            UIColor.black.setFill()
        } else {
            UIColor.white.setFill()
        }
        UIColor.black.setStroke()
        circle.lineWidth = 3
        circle.stroke()
        circle.fill()
    }
    
    private func drawSquare(x: Int, y: Int, affected: Bool) {
        let rect = UIBezierPath(rect: CGRect(x, y, drawSize, drawSize))
        if affected {
            UIColor.black.setFill()
        } else {
            UIColor.white.setFill()
        }
        UIColor.black.setStroke()
        rect.lineWidth = 3
        rect.stroke()
        rect.fill()
    }
}
