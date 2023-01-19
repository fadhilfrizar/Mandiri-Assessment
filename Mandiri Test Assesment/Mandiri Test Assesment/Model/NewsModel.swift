//
//  NewsModel.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

struct News: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
}

struct NewsSource: Codable {
    let id: String?
    let name: String?
}

struct NewsResponse: Codable {
    let articles: [News]
    let status: String?
    let totalResults: Int?
    // ...
}
