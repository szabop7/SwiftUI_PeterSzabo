//
//  Countries.swift
//  Cross Out!
//
//  Created by user207082 on 1/7/22.
//

import Foundation

struct Country: Codable, Identifiable, Hashable {
    let id = UUID()
    var data: [String:[String:String]]
}


class Api : ObservableObject{
    
    @Published var country = [Country]()
    @Published
    private var model = CrossOutGameModel(numberOfRows: 4)
    func loadData(completion:@escaping ([Country]) -> ()) {
        guard let url = URL(string: "https://api.first.org/data/v1/countries") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let countries = try! JSONDecoder().decode(Country.self, from: data!)
            print(countries)
           
            DispatchQueue.main.async {
                self.model.saveCountries(countries)
                completion([countries])
                        }
                    }.resume()
            
        
    }
}
