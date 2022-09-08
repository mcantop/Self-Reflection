//
//  Profile.swift
//  Self Reflection
//
//  Created by Maciej on 31/08/2022.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var journal: Entries
    @ObservedObject var user: User
    @State private var name = ""
    @State private var birthday = Date()
    
    var body: some View {
        List {
            Section {
                TextField("Your name", text: $name)
                    .onAppear {
                        let savedName = user.data.name
                        name = savedName ?? "User"
                    }
                
                    .onChange(of: name, perform: { newName in
                        user.data.name = newName
                    })
            } header: {
                Text("Name")
            }
            
            Section {
                DatePicker("Your birthday", selection: $birthday, displayedComponents: .date)
                    .onAppear {
                        let savedBirthday = user.data.birthday
                        birthday = savedBirthday ?? Date.now
                    }
                
                    .onChange(of: birthday) { newBirthday in
                        user.data.birthday = newBirthday
                    }
            } header: {
                Text("Birthday")
            }
            
            Section {
                Text("\(journal.entries.count)")
                
            } header: {
                Text("Entries")
            }
        }
        .navigationTitle("Your Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                journal.entries = []
            } label: {
                Image(systemName: "trash.circle.fill")
            }

        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(journal: Entries(), user: User())
    }
}
