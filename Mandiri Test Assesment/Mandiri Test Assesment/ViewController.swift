//
//  ViewController.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import UIKit

class ViewController: UIViewController, CategoryViewProtocol  {
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var presenter: CategoryPresenterProtocol?
    var categories: [Categories] = []
    var filterCategory: [String?] = []
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib(nibName: "CategoriesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "categoriesCollectionCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicatorView.startAnimating()
        let interactor = CategoryInteractor(newsService: NewsService(category: "", sources: ""))
        presenter = CategoryPresenter(view: self, interactor: interactor)
        presenter?.fetchNewsWithCategory()
        
        self.navigationItem.title = "Categories"
    }
    
    
    func showNewsWithCategory(news: [Categories]) {
        DispatchQueue.main.async {
            
            self.categories = news
            
            let filterCategory = self.categories.map({$0.category})
            let filteredCategory = filterCategory.removingDuplicates()
            self.filterCategory = filteredCategory
            
            self.indicatorView.stopAnimating()
            self.indicatorView.hidesWhenStopped = true
            
            self.collectionView.reloadData()
        }
        
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCollectionCell", for: indexPath) as! CategoriesCollectionCell
        
        cell.categoriesLabel.text = self.filterCategory[indexPath.row]?.uppercased()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "newsCategoryViewController") as! NewsCategoryViewController
        controller.categories = self.filterCategory[indexPath.row] ?? ""
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
