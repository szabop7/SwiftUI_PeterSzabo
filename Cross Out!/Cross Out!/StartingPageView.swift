//
//  ContentView.swift
//  Cross Out!
//
//  Created by user207082 on 10/17/21.
//

import SwiftUI

struct StartingPageView: View {
    @State private var isOn = 4
    @AppStorage("isOnDark") private var isOnDark = false
    @State private var action: Int? = 0
    @StateObject var gameViewModel: CrossOutViewModel
    @State var selectedCountry: String?
    @State var countries = [Country]()
    var body: some View {
        NavigationView {
            VStack{
                Text("Cross Out!")
                    .font(.custom("Marker Felt", size: 30))
                    .fontWeight(.bold)
                    .padding()
                    
               
                
                VStack{
                    Picker("Mode", selection: $isOnDark){
                        Text("Light")
                            .tag(false)
                        Text("Dark")
                            .tag(true)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                    
                }
                HStack{
                    Text("Field Size:")
                    Picker(selection: $isOn, label: Text("Field Size:")) {
                        Text("4 rows").tag(4)
                        Text("5 rows").tag(5)
                        Text("6 rows").tag(6)
                        Text("7 rows").tag(7)
                    }
                }
                
                HStack{
                    Spacer()
                    Text("Country P1:")
                    Picker("Country", selection: $selectedCountry) {
                                
                        Group{
                            ForEach(countries) { country in
                                var keyArray = Array(country.data.keys)
                                ForEach(keyArray, id: \.self) { c in
                                    var dict = country.data[c]
                                    Text(dict!["country"]!)
                                }
                            }
                            Text("<choose>")
                        }
                                
                            }.onChange(of: selectedCountry) { selected in
                                if let cntry = selected {
                                    print("--> store country id:")
                                }
                            }.pickerStyle(.menu)
                                .onChange(of: selectedCountry) { selected in
                                    if let cntry = selected {
                                        print("--> store country id:")
                                    }
                                }
                    Spacer()
                    Text("Country P2:")
                    
                        Picker("Country", selection: $selectedCountry) {
                            
                            Group{
                                ForEach(countries) { country in
                                    var keyArray = Array(country.data.keys)
                                    ForEach(keyArray, id: \.self) { c in
                                        var dict = country.data[c]
                                        Text(dict!["country"]!)
                                    }
                                }
                                Text("<choose>")

                            }
                        }.onChange(of: selectedCountry) { selected in
                            if let cntry = selected {
                                print("--> store country id:")
                            }
                        }.pickerStyle(.menu)
                            .onAppear{
                                Api().loadData { (countries) in
                                        self.countries = countries
                                }
                            }
                    
                    Spacer()
                }
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                Spacer()
                NavigationLink(destination: GameView(gameViewModel: gameViewModel), tag: 1, selection: $action){}
                Button(action: {
                    gameViewModel.createGame(isOn)
                    self.action = 1
                    
                }
                ){
                    Text("Start Game")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(7)
                }
            }
            
        }
        
    }
}

