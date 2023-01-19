//
//  SourcePresenterProtocol.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

protocol SourcePresenterProtocol {
    func fetchNewsWithCategorySource(categories: String)
    func showNewsWithCategorySource(news: [Categories])
}
