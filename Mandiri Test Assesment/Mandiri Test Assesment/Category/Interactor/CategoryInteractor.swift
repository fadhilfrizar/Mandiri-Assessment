//
//  CategoryInteractor.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

class CategoryInteractor: CategoryInteractorProtocol {
    
    private let newsService: NewsService
    private var newsWithCategories: [Categories] = []
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func fetchNewsWithCategory(completion: @escaping (_ news: [Categories]?, _ error: Error?) -> ()) {
        newsService.fetchNewsCategory { (news, error) in
            if let error = error {
                completion(nil, error)
            } else {
                self.newsWithCategories = news ?? []
                completion(self.newsWithCategories, nil)
            }
        }
    }
}
