//
//  SourceInteractor.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

class SourceInteractor: SourceInteractorProtocol {
    
    private let newsService: NewsService
    private var newsWithCategories: [Categories] = []
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func fetchNewsWithCategorySource(categories: String, completion: @escaping (_ news: [Categories]?, _ error: Error?) -> ()) {
        newsService.fetchNewsByCategory { (news, error) in
            if let error = error {
                completion(nil, error)
            } else {
                self.newsWithCategories = news ?? []
                completion(self.newsWithCategories, nil)
            }
        }
    }
}
