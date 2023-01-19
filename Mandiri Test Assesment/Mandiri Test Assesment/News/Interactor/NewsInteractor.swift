//
//  NewsInteractor.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

class NewsInteractor: NewsInteractorProtocol {
    
    private let newsService: NewsService
    private var news: [News] = []
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func fetchNews(completion: @escaping ([News]?, Error?) -> ()) {
        newsService.fetchNews { (news, error) in
            if let error = error {
                completion(nil, error)
            } else {
                self.news = news ?? []
                completion(self.news, nil)
            }
        }
    }
//
//    func fetchNewsWithCategory(completion: @escaping (_ news: [Categories]?, _ error: Error?) -> ()) {
//        newsService.fetchNewsCategory { (news, error) in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                self.newsWithCategories = news ?? []
//                completion(self.newsWithCategories, nil)
//            }
//        }
//    }
}
