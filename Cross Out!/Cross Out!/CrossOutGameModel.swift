//
//  CrossOurGameModel.swift
//  Cross Out!
//
//  Created by user207082 on 11/7/21.
//

import Foundation
import SwiftUI

struct CrossOutGameModel{
    
    private(set) var rows: Array<Row>
    private(set) var gameFinished = false
    
    
    struct Line: Identifiable {
        let id: Int
        var isCrossed = false
        var isAvailable = false
    }
    
    struct Row: Identifiable {
        let id: Int
        var lines: Array<Line>
        var allCrossedOut = false
        
    }
    
    init(numberOfRows: Int){
        rows=Array<Row>()
        var counter = 0
        for rowIndex in 0..<numberOfRows{
            rows.append(Row(id: rowIndex, lines: Array<Line>(), allCrossedOut: false))
            for lineIndex in 0..<rowIndex+1 {
                rows[rowIndex].lines.append(Line(id: counter, isCrossed: false))
                counter = counter+1
            }
        }
        for row in rows {
            for var line in row.lines {
                if line.id==0 || line.id==1 || line.id==3 || line.id==6 || line.id==10 || line.id==15 || line.id==21
                {
                    let index = rows.firstIndex(where: { $0.id == row.id })!
                    let indexLine = rows[index].lines.firstIndex(where: { $0.id == line.id })
                    rows[index].lines[indexLine!].isAvailable = true
                }
            }
        }
        
    }
    
    mutating func cross(_ line: Line) {
        for row in rows {
            let index = rows.firstIndex(where: { $0.id == row.id })!
            let indexLine = rows[index].lines.firstIndex(where: { $0.id == line.id })
            if indexLine != nil{
                rows[index].lines[indexLine!].isCrossed = true
            }
        }
        evaluatePossibleMoves()
    }
    
    mutating func evaluatePossibleMoves()
    {
        for row in rows {
            for line in row.lines
            {
                if line.isAvailable == true, line.isCrossed == true {
                    let index = rows.firstIndex(where: { $0.id == row.id })!
                    let indexLine = rows[index].lines.firstIndex(where: { $0.id == line.id })
                    if line.id != 0, line.id != 2, line.id != 5, line.id != 9, line.id != 14, line.id != 20, line.id != 27{
                        
                        rows[index].lines[indexLine!+1].isAvailable = true
                    }
                    rows[index].lines[indexLine!].isAvailable = false
                }
                else if line.isAvailable == true, line.isCrossed == false {
                    let index = rows.firstIndex(where: { $0.id == row.id })!
                    let indexLine = rows[index].lines.firstIndex(where: { $0.id == line.id })
                    rows[index].lines[indexLine!].isAvailable = false
                }
            }
        }
        
    }
    
    mutating func passTurn() {
        
        for row in rows {
            for line in row.lines {
                if line.isCrossed == false {
                    let index = rows.firstIndex(where: { $0.id == row.id })!
                    let indexLine = rows[index].lines.firstIndex(where: { $0.id == line.id })
                    rows[index].lines[indexLine!].isAvailable = true
                    break
                }
            }
        }
    }
}
