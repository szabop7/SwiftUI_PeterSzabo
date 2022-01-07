//
//  GameView.swift
//  Cross Out!
//
//  Created by user207082 on 11/7/21.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: CrossOutViewModel
    @State var gameFinished = false
    var body: some View {
        
        var x = gameViewModel.rows
        ForEach(gameViewModel.rows) { row in
            rowView(for: row)
        }
        Spacer()
        Text(endText())
            .font(.subheadline)
            .fontWeight(.bold)
        Spacer()
        NavigationLink(destination: StartingPageView(gameViewModel: gameViewModel),isActive: $gameFinished){
        Button(action: {
            

            gameViewModel.passTurn()
            gameFinished=gameViewModel.gameFinished
        }
        ){
            Text(buttonText())
                .fontWeight(.bold)
                .font(.subheadline)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                
        }
        .disabled(gameViewModel.gameFinished)
        }
        Spacer()
    }
    
    func buttonText() -> String{
        if gameViewModel.gameFinished == false{
            
            return "Pass Turn!"
        }
        else{
            return "Return to Menu"
        }
            
    }
    func endText() -> String{
        if gameViewModel.gameFinished == true{
            return "Game is over, Congrat to the winner!"
        }
        return ""
    }
        
    
    @ViewBuilder
    private func rowView (for row: CrossOutViewModel.Row) -> some View {
        let r = row
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 20))]){
            Spacer()
            Spacer()
            ForEach(r.lines){line in
                LineView(gameViewModel: gameViewModel, line: line)
            }
        }
    }
}

struct LineView : View{
    @ObservedObject var gameViewModel: CrossOutViewModel
    let line: CrossOutViewModel.Line
    func toggle(){
        gameViewModel.cross(line)
    }
    
    var body: some View{
        Button(action: toggle){
            Image(systemName: line.isCrossed ? "square.fill": "square")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
        }
        .disabled(line.isAvailable == false)
        
    }
}

