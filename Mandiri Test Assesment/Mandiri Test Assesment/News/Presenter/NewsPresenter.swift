//
//  NewsPresenter.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

class NewsPresenter: NewsPresenterProtocol {
    
    
    private let view: NewsViewProtocol
    private let interactor: NewsInteractorProtocol
    
    init(view: NewsViewProtocol, interactor: NewsInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    
    func fetchNews() {
        interactor.fetchNews { (news, error) in
            if let error = error {
                print(error)
                return
            }
            if let news = news {
                self.view.showNews(news: news)
            }
        }
    }
    
    func showNews(news: [News]) {
        
    }
    
}
