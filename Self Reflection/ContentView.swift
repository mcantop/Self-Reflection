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
    @State var navigate = false
    
    func feelingColor(emoji: String) -> [Color] {
        var colors: [Color] = []
        
        switch emoji {
        case "😭":
            colors = [Color(0xA8DADC), Color(0x8233C5), Color(0xE963FD)]
            //        case "😢":
            //            colors = [Color(0xA8DADC), Color(0x), Color(0x)]
        case "😐":
            colors = []
        case "😌":
            colors = []
        case "😄":
            colors = []
        case "🥰":
            colors = []
        case "🤪":
            colors = []
        default:
            colors = []
        }
        
        return colors
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(Date.now.formatted(.dateTime.month(.wide).day().year()).uppercased())
                            .foregroundColor(.secondary)
                        
                            Text("Welcome back, \(user.data.name ?? "User")")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                        
                        if journal.entries.count != 0 {
                            HStack(alignment: .bottom) {
                                Text("Latest entries:")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text("\(journal.entries.count) written entries")
                                    .font(.system(.footnote))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .font(.system(.body, design: .rounded))
                    .listRowSeparator(.hidden, edges: .top)
                    
                    if journal.entries.count == 0 {
                        VStack(spacing: 30) {
                            Text("Your entries seem... empty? How about writing a new one?")
                                .multilineTextAlignment(.center)
                            
                            Button {
                                showingSheet.toggle()
                            } label: {
                                Label("New entry", systemImage: "pencil")
                            }
                            .sheet(isPresented: $showingSheet) {
                                NewEntry(journal: journal)
                            }
                            .buttonStyle(.bordered)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .listRowSeparator(.hidden)
                    } else {
                        ForEach(journal.entries) { entry in
                            VStack(alignment: .leading, spacing: 0) {
                                NavigationLink(destination: EntryDetails(journal: journal, entry: entry), isActive: $navigate) { }
                                    .hidden()
                                    .frame(width: 0, height: 0)
                                
                                Button {
                                    navigate.toggle()
                                } label: {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                                            .foregroundColor(.secondary)
                                            .font(.system(.footnote))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text(entry.title)
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                        
                                        Text(entry.body)
                                            .lineLimit(3)
                                            .font(.body)
                                        
                                        Text("\(entry.words) words")
                                            .font(.system(.footnote))
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                        
                                    }
                                }
                            }
                            
                        }
                        .onDelete { journal.entries.remove(atOffsets: $0) }
                    }
                }
                AddButton(journal: journal, showingSheet: showingSheet)
            }
            .listStyle(.plain)
            .navigationBarTitle("Self Reflection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
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
    static var previews: some View {
        ContentView()
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

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
