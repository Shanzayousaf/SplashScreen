//
//  ContentView.swift
//  SplashScreen
//
//  Created by Macbook on 31/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var IsSplashScreenActive = true
    
    var body: some View {
        TabsView()
            .overlay{
                SplashScreen(isActive: $IsSplashScreenActive, 
                             content: {
                    Image("logo")
                        .resizable()
                        .frame(width: 150, height: 150)
                },
                             background: {
                    Color.gray
                })
                
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 4 ) {
                    IsSplashScreenActive.toggle()
                }
            }
    }
    
}

#Preview {
    ContentView()
}
