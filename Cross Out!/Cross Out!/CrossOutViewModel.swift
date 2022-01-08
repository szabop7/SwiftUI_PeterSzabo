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
    
    @Published var countries2: Country = Country(data: [:])
    var rows: Array<Row> {
        return model.rows
    }
    var countries: Array<String> {
        return model.countries
    }
    var gameFinished: Bool {
        return model.gameFinished
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
    
    func fetch(completion:@escaping ([Country]) -> ()) {
        guard let url = URL(string: "https://api.first.org/data/v1/countries") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let countries = try! JSONDecoder().decode(Country.self, from: data!)
            print(countries)
           
            DispatchQueue.main.async {
                self.model.saveCountries(countries)
                completion([self.countries2])
                        }
                    }.resume()
    }
}
