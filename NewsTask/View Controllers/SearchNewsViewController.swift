//
//  SearchNewsViewController.swift
//  NewsTask
//
//  Created by ivan on 14.11.2020.
//


import UIKit
import SafariServices

class SearchNewsViewController: UITableViewController {
    
    let constants = Constants()
    var textSearch = ""
    var country = ""
    var category = ""
    var sources = ""
    var page = 1
    var loadItems = false
    
    var articles = [Articles]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let url = constants.urlString + country + category + sources + textSearch + constants.key
        NetworkManager.fetchData(url: url) { (news) in
            self.articles = news
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if news.count == 0 {
                    self.showError(text: "По вашему запросу ничего не найдено")
                }
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
       
        let article = articles[indexPath.row]
        cell.sourceName.text = article.source?.name
        cell.autorLabel.text = article.author
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        cell.spinner.startAnimating()
        
        DispatchQueue.global().async {
            guard let urlToImage = article.urlToImage else { return }
            guard let imageUrl = URL(string: urlToImage) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }

            DispatchQueue.main.async {
                cell.spinner.stopAnimating()
                cell.spinner.removeFromSuperview()
                cell.imageNews.image = UIImage(data: imageData)
            }
        }
        
        //Инфинити скрол
        if indexPath.row == articles.count - 1 {
            
            if loadItems == false {
                loadMoreItems()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let article = articles[indexPath.row]
        guard let urlString = article.url else { return }
        guard let url = URL(string: urlString) else { return }
        
        let svc = SFSafariViewController(url: url)

        self.present(svc, animated: true, completion: nil)
    }
    
    // Данная API по стандарту выдает 20 ответов на запрос, в данной функции реализована подгрузка элементов с следующей страницы
    func loadMoreItems() {
        
        loadItems = true
        page += 1
        
        let listUrlString = constants.urlString + country + category + sources + textSearch + "page=\(page)&" + constants.key
        
        NetworkManager.fetchData(url: listUrlString) { articles in
            self.articles = self.articles + articles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loadItems = false
            }
        }
    }
    
    // Вывод ошибки на экран
    func showError(text:String) {
        let alert = UIAlertController(title: "Упс...", message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}
