//
//  NewsService.swift
//  Mandiri Test Assesment
//
//  Created by USER-MAC-GLIT-007 on 19/01/23.
//

import Foundation

class NewsService {
    
    let url = "https://newsapi.org/v2/"
    let apiKey = "b5a4a12ca72c42d699dc22370b84e51c"
    var category = ""
    var sources = ""
    
    init(category: String, sources: String) {
        self.category = category
        self.sources = sources
    }
    
    func fetchNewsCategory(completion: @escaping (_ news: [Categories]?, _ error: Error?) -> ()) {
        let url = URL(string: "\(url)/top-headlines/sources?country=us&apiKey=\(apiKey)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(CategoryResponse.self, from: data)
                    let news = newsResponse.sources
                    completion(news, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func fetchNewsByCategory(completion: @escaping (_ news: [Categories]?, _ error: Error?) -> ()) {
        let url = URL(string: "\(url)/top-headlines/sources?category=\(category)&country=us&apiKey=\(apiKey)")!
        print("url == ", url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(CategoryResponse.self, from: data)
                    let news = newsResponse.sources
                    completion(news, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func fetchNews(completion: @escaping (_ news: [News]?, _ error: Error?) -> ()) {
        let url = URL(string: "\(url)/top-headlines?sources=\(sources)&apiKey=\(apiKey)")!
        print("url == ", url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                    let news = newsResponse.articles
                    completion(news, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
}
