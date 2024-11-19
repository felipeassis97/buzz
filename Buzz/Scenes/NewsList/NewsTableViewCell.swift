//
//  NewsTableViewCell.swift
//  Buzz
//
//  Created by Felipe Assis on 15/11/2024.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    // MARK: - Variables
    static let identifier: String = "NewsTableViewCell"
    
    // MARK: - LyfeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private let newsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .neutral
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .neutral
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .primaryAqua
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .neutral
        label.numberOfLines = 20
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    // MARK: - UI Setup
    private func setupView() {
        contentView.addSubview(newsStackView)
        newsStackView.addArrangedSubview(authorLabel)
        newsStackView.addArrangedSubview(titleLabel)
        newsStackView.addArrangedSubview(descriptionLabel)
        newsStackView.addArrangedSubview(image)
        newsStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            image.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    // MARK: - Bindings
    public func configure(_ news: NewsListModel.FetchNews.ViewModel.DisplayedArticle) {
        authorLabel.text = news.author
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        dateLabel.text = news.publishedAt
        
        let url = URL(string: news.imageUrl)
        image.kf.setImage(with: url)
    }
}
