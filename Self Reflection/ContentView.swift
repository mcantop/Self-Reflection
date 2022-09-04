//
//  ContentView.swift
//  Self Reflection
//
//  Created by Maciej on 31/08/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var journal = Entries()
    @ObservedObject var user = User()
    
    var body: some View {
        TabView {
            Journal(journal: journal, user: user)
                .tabItem {
                    Label("Journal", systemImage: "book.closed")
                }
            
            Profile(journal: journal, user: user)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
