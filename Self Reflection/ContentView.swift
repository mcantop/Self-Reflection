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
    @State var showingSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(journal.entries) { entry in
                        NavigationLink(destination: EntryDetails()) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(entry.title)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                                        .foregroundColor(.secondary)
                                }
                                Text(entry.body)
                                    .lineLimit(2)
                                    .font(.body)
                                
                                HStack {
                                    LinearGradient(colors: [
                                        .green, .green.opacity(0.5), .green.opacity(0.25), .accentColor.opacity(0)
                                    ], startPoint: .leading, endPoint: .trailing)
                                    .frame(height: 5)
                                    .cornerRadius(10)
                                    
                                    Text(entry.feeling)
                                }
                                
                            }
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                        }
                    }
                }
                AddButton(journal: journal, showingSheet: showingSheet)
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
            .navigationTitle("Self Reflection")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(Date.now.formatted(.dateTime.month(.wide).day().year()).uppercased())
                        .foregroundColor(.secondary)
                }
                
                ToolbarItem {
                    NavigationLink(destination: Profile(journal: journal, user: user)) {
                        Image(systemName: "person.crop.circle")
                            .font(.title3)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @ObservedObject var journal = Entries()
    
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct AddButton: View {
    @ObservedObject var journal: Entries
    @State var showingSheet: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .frame(width: 64, height: 64)
                        .foregroundColor(.primary)
                        .background(.blue)
                        .clipShape(Circle())
                        .padding()
                        .shadow(radius: 10)
                }
                .sheet(isPresented: $showingSheet) {
                    NewEntry(journal: journal)
                }
            }
        }
        .ignoresSafeArea()
    }
}
