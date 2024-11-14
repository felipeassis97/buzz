//
//  Article.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//

import Foundation

struct Article: Codable, Identifiable {
    let id: Int
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
}
