//
//  NewEntry.swift
//  Self Reflection
//
//  Created by Maciej on 04/09/2022.
//

import SwiftUI

struct NewEntry: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var journal: Entries
    @State private var title = ""
    @State private var content = ""
    @State private var date = Date.now
    @State private var wordCount = 0
    @State private var selectedSection = "Write"
    @State private var feeling = 3.0
    @State private var isEditing = false
    @State private var entryColor = Color.accentColor
    
    var emoji: String {
        var userEmoji: String = "😊"
        
        switch feeling {
        case 0.00...0.99:
            userEmoji = "😭"
        case 1...1.99:
            userEmoji = "😢"
        case 2...2.99:
            userEmoji = "😐"
        case 3...3.99:
            userEmoji = "😌"
        case 4...4.99:
            userEmoji = "😄"
        case 5...5.99:
            userEmoji = "🥰"
        case 6.00:
            userEmoji = "🤪"
        default:
            userEmoji = "💀"
        }
        
        return userEmoji
    }
    
    let sections = ["Write", "Feeling"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .padding(.top, -15)
                    .foregroundColor(.secondary)
                
                if selectedSection == "Write" {
                    TextField("Title", text: $title)
                        .padding(5)
                    
                    Divider()
                    
                    TextEditor(text: $content)
                        .onChange(of: content) { value in
                            let words = value.split { $0 == " " || $0.isNewline }
                            wordCount = words.count
                        }
                    
                } else {
                    Slider(
                        value: $feeling,
                        in: 0...6,
                        step: 0.02
                    ) {
                        Text("Feeling")
                    } minimumValueLabel: {
                        Text("Sad")
                    } maximumValueLabel: {
                        Text(feeling == 6.0 ? "Crazy" : "Happy")
                    } onEditingChanged: { editing in
                        isEditing = editing
                    }
                    
                    Divider()
                    
                    Spacer()
                    
                    Text(emoji)
                        .font(.system(size: 150))
                    
                    Spacer()
                    
                }
                Text("\(wordCount) words")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.secondary)
                Divider()
                
                Picker("", selection: $selectedSection) {
                    ForEach(sections, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .foregroundColor(entryColor)

                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newEntry = Entry(
                            title: title,
                            body: content,
                            date: date,
                            feeling: emoji,
                            words: wordCount
                        )
                        
                        journal.entries.insert(newEntry, at: 0)
                        
                        dismiss()
                        
                        print(journal.entries.count)
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(entryColor)
                    }
                }
            }
            
        }
    }
}

struct NewEntry_Previews: PreviewProvider {
    static var previews: some View {
        NewEntry(journal: Entries())
    }
}
