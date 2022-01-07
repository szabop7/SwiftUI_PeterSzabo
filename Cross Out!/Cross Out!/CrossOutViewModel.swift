//
//  CrossOutViewModel.swift
//  Cross Out!
//
//  Created by user207082 on 11/7/21.
//

import SwiftUI

class CrossOutViewModel: ObservableObject{
    typealias Line = CrossOutGameModel.Line
    typealias Row = CrossOutGameModel.Row
    
    @Published
    private var model = CrossOutGameModel(numberOfRows: 4)
    
    var rows: Array<Row> {
        return model.rows
    }
    
    func createGame(_ rows:Int){
        model = CrossOutGameModel(numberOfRows: rows)
    }
    
    func cross(_ line:CrossOutGameModel.Line){
        model.cross(line)
    }
    func passTurn(){
        model.passTurn()
    }
}
