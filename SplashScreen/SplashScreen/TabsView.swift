//
//  TabsView.swift


import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            NavigationView {
                ScrollView {
                    
                }
                .navigationTitle("Hello World")
            }
            .tabItem {
                Image(systemName: "iphone")
            }
            
            NavigationView {
                ScrollView {
                    
                }
                .navigationTitle("Hello Apple TV")
            }
            .tabItem {
                Image(systemName: "appletv.fill")
            }
            
            NavigationView {
                ScrollView {
                    
                }
                .navigationTitle("Hello Apple Watch")
            }
            .tabItem {
                Image(systemName: "applewatch")
            }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
