//
//  TableViewController.swift
//  NewsTask
//
//  Created by ivan on 14.11.2020.
//

import UIKit
import SafariServices

class TableViewController: UITableViewController {
    
    let constants = Constants()
    let countryUA = "country=ua&"
    var articles = [Articles]()
    var loadItems = false
    var page = 1
    

    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = constants.urlString + countryUA + constants.key
        
        NetworkManager.fetchData(url: url) { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let article = articles[indexPath.row]
        
        if let author = article.author {
            cell.autorLabel?.text = author
        }
        
        cell.descriptionLabel.text = article.description
        cell.titleLabel.text = article.title
        cell.titleLabel.textColor = .white
        cell.titleLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cell.sourceLabel.text = article.source?.name
        cell.spinner.startAnimating()
        
        DispatchQueue.global().async {
            guard let urlToImage = article.urlToImage else { return }
            guard let imageUrl = URL(string: urlToImage) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            

            DispatchQueue.main.async {
                cell.spinner.stopAnimating()
                cell.spinner.isHidden = true
                cell.imageNews.image = UIImage(data: imageData)
            }
        }
        
        // Infinite scroll
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
        
        let listUrlString = constants.urlString + countryUA + "page=\(page)&" + constants.key
        
        NetworkManager.fetchData(url: listUrlString) { articles in
            self.articles = self.articles + articles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loadItems = false
            }
        }
    }
}
