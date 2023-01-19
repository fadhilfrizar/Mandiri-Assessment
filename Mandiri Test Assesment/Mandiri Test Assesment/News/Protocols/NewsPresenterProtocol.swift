//
//  NewsPresenterProtocol.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

protocol NewsPresenterProtocol {
    func fetchNews()
    func showNews(news: [News])
}
