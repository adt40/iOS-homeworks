//
//  ViewController.swift
//  MatrixSquare
//
//  Created by Austin Toot on 2/18/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var InputTextField: UITextField!
    @IBOutlet weak var OutputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func SquareButtonPressed(_ sender: UIButton) {
        if let matrixStr = InputTextField.text {
            let squaredMatrix = squareMatrix(matrixStr)
            OutputTextField.text = squaredMatrix
        }
    }
    
    func squareMatrix(_ matrixStr: String) -> String {
        let size = getSize(matrixStr: matrixStr)
        let matrix = stringMatToDoubleMat(matrixStr: matrixStr, size: size)
        let squareMat = square(matrix: matrix)
        return doubleMatToStringMat(matrix: squareMat)
    }
    
    func doubleMatToStringMat(matrix: [[Double]]) -> String {
        var matrixStr = ""
        let size = matrix.count
        for i in 0..<size {
            for j in 0..<size {
                matrixStr += String(matrix[i][j])
                if j < size - 1 {
                    matrixStr += " "
                } else if i < size - 1{
                    matrixStr += ";"
                }
            }
        }
        return matrixStr
    }
    
    
    func square(matrix: [[Double]]) -> [[Double]]{
        let size = matrix.count
        var squareMat = initMatrix(size: size)
        for i in 0..<size {
            for j in 0..<size {
                var dotProduct = 0.0
                for k in 0..<size {
                    dotProduct += matrix[i][k] * matrix[k][j]
                }
                squareMat[i][j] = dotProduct
            }
        }
        return squareMat
    }
    
    func getSize(matrixStr: String) -> Int {
        var mutMat = matrixStr
        var size = 1
        var currentChar = ""
        while currentChar != ";" {
            currentChar = String(mutMat.removeFirst())
            if currentChar == " " {
                size += 1
            }
        }
        return size
    }
    
    func stringMatToDoubleMat(matrixStr: String, size: Int) -> [[Double]] {
        var matrix = initMatrix(size: size) //fix size
        var mutMat = matrixStr
        var currentPos = (0, 0)
        var currentChar = ""
        var workingStr = ""
        while !mutMat.isEmpty {
            print(currentPos)
            currentChar = String(mutMat.removeFirst())
            switch (currentChar) {
            case " ":
                if let value = Double(workingStr) {
                    matrix[currentPos.0][currentPos.1] = value
                } else {
                    matrix[currentPos.0][currentPos.1] = 0
                }
                workingStr = ""
                currentPos.0 += 1
                break
            case ";":
                if let value = Double(workingStr) {
                    matrix[currentPos.0][currentPos.1] = value
                } else {
                    matrix[currentPos.0][currentPos.1] = 0
                }
                workingStr = ""
                currentPos.1 += 1
                currentPos.0 = 0
                break
            default:
                workingStr += currentChar
                break
            }
        }
        return matrix
    }
    
    func initMatrix(size: Int) -> [[Double]] {
        var matrix = [[Double]](repeatElement([Double](repeatElement(0, count: size)), count: size))
        for i in 0..<size {
            for j in 0..<size {
                matrix[i][j] = 0
            }
        }
        return matrix
    }



}

