//
//  ContentView.swift
//  Cross Out!
//
//  Created by user207082 on 10/17/21.
//

import SwiftUI

struct StartingPageView: View {
    @State private var isOn = false
    var body: some View {
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
                    Text("PvC")
                }
            
            
            }
            HStack{
                Text("Field Size:")
                Picker(selection: $isOn, label: Text("GameMode:")) {
                    Text("4 rows")
                    Text("5 rows")
                    Text("6 rows")
                    Text("7 rows")
                }
            }
            Spacer()
            Button(action: {
                
            }){
                
                Text("Start Game")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(7)
                    
            }
            Spacer()
            Spacer()
            HStack{
                Spacer()
                Toggle("Dark Mode", isOn: $isOn)
                    .toggleStyle(CheckToggleStyle())
                    .padding()
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
                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartingPageView()
    }
}
