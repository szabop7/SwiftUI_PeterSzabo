//
//  Cross_Out_App.swift
//  Cross Out!
//
//  Created by user207082 on 10/17/21.
//

import SwiftUI

@main
struct Cross_Out_App: App {
    @AppStorage("isOnDark") private var isOnDark = false
    @State var countries = [Country]()
    private let game = CrossOutViewModel()
    var body: some Scene {
        WindowGroup {
            
            NavigationView{
                StartingPageView(gameViewModel: game)
                    .preferredColorScheme(isOnDark ? .dark : .light)
                    
                    
                    
            }
        }
    }
}
