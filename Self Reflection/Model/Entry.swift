//
//  Entry.swift
//  Self Reflection
//
//  Created by Maciej on 31/08/2022.
//

import Foundation

struct Entry: Identifiable, Codable {
    var id = UUID()
    let title: String
    let body: String
    let date: Date
    let feeling: String
}
