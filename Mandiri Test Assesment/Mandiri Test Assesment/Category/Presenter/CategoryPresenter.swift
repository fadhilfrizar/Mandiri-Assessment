//
//  CategoryPresenter.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

class CategoryPresenter: CategoryPresenterProtocol {
    func showNewsWithCategory(news: [Categories]) {
        
    }
    
    private let view: CategoryViewProtocol
    private let interactor: CategoryInteractorProtocol
    
    init(view: CategoryViewProtocol, interactor: CategoryInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func fetchNewsWithCategory() {
        interactor.fetchNewsWithCategory { (news, error) in
            if let error = error {
                print(error)
                return
            }
            if let news = news {
                self.view.showNewsWithCategory(news: news)
            }
        }
    }
}
