//
//  SourcePresenter.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

class SourcePresenter: SourcePresenterProtocol {
    func showNewsWithCategorySource(news: [Categories]) {
        
    }
    
    
    private let view: SourceViewProtocol
    private let interactor: SourceInteractorProtocol
    
    init(view: SourceViewProtocol, interactor: SourceInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func fetchNewsWithCategorySource(categories: String) {
        interactor.fetchNewsWithCategorySource(categories: categories) { (news, error) in
            if let error = error {
                print(error)
                return
            }
            if let news = news {
                self.view.showNewsWithCategorySource(news: news)
            }
        }
    }
}
