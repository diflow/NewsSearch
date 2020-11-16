//
//  SearchTableViewCell.swift
//  NewsTask
//
//  Created by ivan on 15.11.2020.
//

import UIKit

// кастомные ячейки таблицы для таблицы поиска
class SearchTableViewCell: UITableViewCell {
    
    let spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.contentMode = .scaleAspectFill
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        //activityIndicator.clipsToBounds = true
        return activityIndicator
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let sourceName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let autorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.numberOfLines = 0
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageNews: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imageNews)
        self.contentView.addSubview(spinner)
        
        containerView.addSubview(sourceName)
        containerView.addSubview(autorLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        self.contentView.addSubview(containerView)
        
        
        
        spinner.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:45).isActive = true
        spinner.widthAnchor.constraint(equalToConstant:50).isActive = true
        spinner.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        imageNews.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        imageNews.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        imageNews.widthAnchor.constraint(equalToConstant:140).isActive = true
        imageNews.heightAnchor.constraint(equalToConstant:100).isActive = true

        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.imageNews.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:160).isActive = true

        sourceName.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        sourceName.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        sourceName.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true

        autorLabel.topAnchor.constraint(equalTo:self.sourceName.bottomAnchor).isActive = true
        autorLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        autorLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo:self.autorLabel.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}
