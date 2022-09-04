//
//  User.swift
//  Self Reflection
//
//  Created by Maciej on 31/08/2022.
//

import Foundation

struct UserData: Codable {
    var name: String?
    var birthday: Date?
}

class User: ObservableObject {
    @Published var data = UserData() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(data) {
                UserDefaults.standard.set(encoded, forKey: "User")
            }
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "User") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(UserData.self, from: saved) {
                data = decoded
            }
        }
    }
}
