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
                if line.id==0 || line.id==1 || line.id==3 || line.id==6 || line.id==10 || line.id==15 || line.id==21{
                    LineView(line: line, id: line.id, isAvailable: true)
                }
                else {
                    LineView(line: line, id: line.id, isAvailable: false)
                }
            }
            
        }
    }
}

struct LineView : View{
    let line: CrossOutViewModel.Line
    let id:Int
    let isAvailable:Bool
    @State var isChecked:Bool = false
    
    func toggle(){isChecked = !isChecked}
    
    var body: some View{
        Button(action: toggle){
            Image(systemName: isChecked ? "square.fill": "square")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                
        }
        .disabled(isAvailable == false)
        
    }
}

