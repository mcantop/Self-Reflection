//
//  Entries.swift
//  Self Reflection
//
//  Created by Maciej on 31/08/2022.
//

import Foundation

class Entries: ObservableObject {
    @Published var entries = [Entry]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(entries) {
                UserDefaults.standard.set(encoded, forKey: "Entries")
            }
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Entries") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Entry].self, from: saved) {
                entries = decoded
            }
        }
    }
}
