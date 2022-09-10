//
//  Entry.swift
//  Self Reflection
//
//  Created by Maciej on 31/08/2022.
//

import Foundation
import SwiftUI

struct Entry: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let body: String
    let date: Date
    let feeling: String
    let words: Int
}
