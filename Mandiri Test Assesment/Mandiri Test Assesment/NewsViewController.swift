//
//  NewsViewController.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import UIKit

class NewsViewController: UIViewController, NewsViewProtocol {
    

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib(nibName: "NewsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "newsCollectionCell")
        }
    }
    
    var presenter: NewsPresenterProtocol?
    var news: [News] = []
    
    var sources: String = ""
    var sourcesName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.indicatorView.startAnimating()
        let interactor = NewsInteractor(newsService: NewsService(category: "", sources: sources))
        presenter = NewsPresenter(view: self, interactor: interactor)
        presenter?.fetchNews()
        
        self.navigationItem.title = sourcesName
    }
    
    func showNews(news: [News]) {
        DispatchQueue.main.async {
            self.news = news
            
            self.indicatorView.stopAnimating()
            self.indicatorView.hidesWhenStopped = true
            
            self.collectionView.reloadData()
        }
    }
    
    
}


extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCollectionCell", for: indexPath) as! NewsCollectionCell
        
        cell.newsImageView.loadImageUsingCacheWithUrlString(self.news[indexPath.row].urlToImage ?? "")
        cell.newsTitleLabel.text = self.news[indexPath.row].title ?? "-"
        cell.newsAuthorLabel.text = self.news[indexPath.row].author ?? "-"
        cell.newsPublishedDateLabel.text = self.news[indexPath.row].publishedAt?.convertStringToDateString() ?? "-"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "detailNewsController") as! DetailNewsController
        controller.news = self.news[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}


extension String {
    func convertStringToDateString() -> String{
        var dateString = ""
        
        //get user's timezone. If nil, default to UTC/GMT
        var userTimezone: String { return TimeZone.current.abbreviation() ?? "UTC" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(identifier: userTimezone)
        var date = dateFormatter.date(from: self)
        
        if date == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone(identifier: userTimezone)
            date = dateFormatter.date(from: self)
        }
        
        let newDateFormatter  = DateFormatter()
        newDateFormatter.dateFormat = "dd MMMM YYYY"

        dateString = newDateFormatter.string(from: date ?? Date())
        
        return dateString
    }
    
    var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return nil }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return nil
            }
        }
        var htmlToString: String {
            return htmlToAttributedString?.string ?? ""
        }
}
