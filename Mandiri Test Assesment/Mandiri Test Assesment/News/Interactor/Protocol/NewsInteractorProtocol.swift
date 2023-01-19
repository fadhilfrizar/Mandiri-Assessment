//
//  NewsInteractorProtocol.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

protocol NewsInteractorProtocol {
    func fetchNews(completion: @escaping (_ news: [News]?, _ error: Error?) -> ())
}
