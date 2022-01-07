//
//  ContentView.swift
//  Cross Out!
//
//  Created by user207082 on 10/17/21.
//

import SwiftUI

struct StartingPageView: View {
    @State private var isOn = 4
    @State private var isOnDark = false
    @State private var action: Int? = 0
    @ObservedObject var gameViewModel: CrossOutViewModel
    var body: some View {
        NavigationView {
            VStack{
                Text("Cross Out!")
                    .font(.custom("Marker Felt", size: 35))
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                HStack{
                    Text("Game Mode:")
                    Picker(selection: $isOn, label: Text("GameMode:")) {
                        Text("PvP")
                        Text("PvC (not ready yet)")
                            .disabled(true)
                    }
                }
                HStack{
                    Text("Field Size:")
                    Picker(selection: $isOn, label: Text("GameMode:")) {
                        Text("4 rows").tag(4)
                        Text("5 rows").tag(5)
                        Text("6 rows").tag(6)
                        Text("7 rows").tag(7)
                    }
                }
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
                HStack{
                    Spacer()
                    Toggle("Dark Mode", isOn: $isOnDark)
                        .toggleStyle(CheckToggleStyle())
                        .padding()
                }
            
            }
        }
    }
}

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}




