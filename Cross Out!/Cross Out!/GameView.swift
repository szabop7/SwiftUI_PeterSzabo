//
//  GameView.swift
//  Cross Out!
//
//  Created by user207082 on 11/7/21.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: CrossOutViewModel
    var body: some View {

        var x = gameViewModel.rows
        ForEach(gameViewModel.rows) { row in
            rowView(for: row)
        }
        Button(action: {
            gameViewModel.passTurn()
        }
        ){
            Text("Pass Turn!")
                .fontWeight(.bold)
                .font(.subheadline)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.top)
        }
        Spacer()
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

