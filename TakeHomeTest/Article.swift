//
//  Article.swift
//  TakeHomeTest
//
//  Created by Cory Steers on 9/14/25.
//

import Foundation

struct Article: Codable, Hashable, Identifiable {
    let id: String
    var title: String
    var text: String
}
