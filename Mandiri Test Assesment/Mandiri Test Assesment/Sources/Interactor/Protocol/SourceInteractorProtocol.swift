//
//  SourceInteractorProtocol.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

protocol SourceInteractorProtocol {
    func fetchNewsWithCategorySource(categories: String, completion: @escaping (_ news: [Categories]?, _ error: Error?) -> ())
}
