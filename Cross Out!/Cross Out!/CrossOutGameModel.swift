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
            var r = Row(id: rowIndex, lines: Array<Line>(), allCrossedOut: false)
            rows.append(r)
            for lineIndex in 0..<rowIndex+1 {
                rows[rowIndex].lines.append(Line(id: counter, isCrossed: false))
                counter = counter+1
            }
        }
    }
    
    mutating func cross(_ line: Line) {
        //if let chosenIndex = index(of: card){
        //this replaces the finding Index function!
        for var row in rows {
            if let chosenIndex = row.lines.firstIndex(where: { $0.id == line.id}),
               !row.lines[chosenIndex].isCrossed{
                row.allCrossedOut=true
                
                   for var l in row.lines {
                    if l.isCrossed==false {
                        row.allCrossedOut = false
                    }
                       if l.id==line.id{
                           l.isCrossed=true;
                       }
               }
            }
        }
            
        
    }
}
