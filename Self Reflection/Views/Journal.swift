//
//  Journal.swift
//  Self Reflection
//
//  Created by Maciej on 31/08/2022.
//

import SwiftUI

struct Journal: View {
    @ObservedObject var journal: Entries
    @ObservedObject var user: User
    
    var body: some View {
        NavigationView {
                VStack(alignment: .leading) {
                    Text("Welcome back,")
                        .font(.system(.title))
                    Text(user.data.name ?? "User")
                        .font(.system(.title2))
                    
                    Text("Your latest entries")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Divider()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowBackground(Color.primary.opacity(0))
                
                ForEach(journal.entries) { entry in
                    Text(entry.title)
                }
            .navigationTitle("Self Reflection")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        journal.entries.append(Entry(
                            title: "Title",
                            body: "Body",
                            date: Date.now,
                            feeling: "mixed"
                        ))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct Journal_Previews: PreviewProvider {
    static var previews: some View {
        Journal(journal: Entries(), user: User())
    }
}
