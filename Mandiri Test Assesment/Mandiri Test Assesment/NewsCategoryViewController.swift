//
//  NewsCategoryViewController.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import UIKit

class NewsCategoryViewController: UIViewController, SourceViewProtocol {
   
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: "SourcesCollectionCell", bundle: nil), forCellReuseIdentifier: "sourcesCollectionCell")
        }
    }
    
    var presenter: SourcePresenterProtocol?
    var sources: [Categories] = []
    
    var categories: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.indicatorView.startAnimating()
        let interactor = SourceInteractor(newsService: NewsService(category: categories, sources: ""))
        presenter = SourcePresenter(view: self, interactor: interactor)
        presenter?.fetchNewsWithCategorySource(categories: categories)
        
        self.navigationItem.title = self.categories
    }
    
    func showNewsWithCategorySource(news: [Categories]) {
        DispatchQueue.main.async {
            self.sources = news
            
            self.indicatorView.stopAnimating()
            self.indicatorView.hidesWhenStopped = true
            
            self.tableView.reloadData()
        }
    }
    

    
}

extension NewsCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourcesCollectionCell", for: indexPath) as! SourcesCollectionCell
        
        cell.sourcesLabel.text = self.sources[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "newsViewController") as! NewsViewController
        controller.sources = self.sources[indexPath.row].id ?? ""
        controller.sourcesName = self.sources[indexPath.row].name ?? ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
