//
//  CategoriesModel.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

struct Categories: Codable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
    
}

struct CategoryResponse: Codable {
    let sources: [Categories]
    let status: String?
    // ...
}
