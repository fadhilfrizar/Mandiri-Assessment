//
//  DetailNewsController.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import UIKit

class DetailNewsController: UIViewController {

    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var publishedDateTitleLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    var news: News?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        self.navigationItem.title = ""
        
        self.newsImageView.loadImageUsingCacheWithUrlString(news?.urlToImage ?? "")
        self.newsTitleLabel.text = news?.title ?? ""
        self.authorTitleLabel.text = news?.author ?? ""
        self.publishedDateTitleLabel.text = news?.publishedAt?.convertStringToDateString() ?? ""
        self.contentTitleLabel.attributedText = news?.content?.htmlToAttributedString
    }
    

}
