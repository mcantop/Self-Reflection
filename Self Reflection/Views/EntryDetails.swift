//
//  EntryDetails.swift
//  Self Reflection
//
//  Created by Maciej on 05/09/2022.
//

import SwiftUI

struct EntryDetails: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var journal: Entries
    var entry: Entry
    
    var body: some View {
        VStack {
            HStack {
                Text(entry.title)
                    .lineLimit(1)
                
                Text(entry.feeling)
                
                Spacer()
                
                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            Text(entry.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    let entryInArray = journal.entries.firstIndex(of: entry)
                    journal.entries.remove(at: entryInArray!)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }

            }
        }
    }
}

struct EntryDetails_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetails(journal: Entries(), entry: Entry(title: "title", body: "test", date: Date.now, feeling: "😄", words: 327))
    }
}
