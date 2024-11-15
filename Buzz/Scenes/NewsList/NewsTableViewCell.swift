//
//  NewsTableViewCell.swift
//  Buzz
//
//  Created by Felipe Assis on 15/11/2024.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - LyfeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "NewsViewCell")
        self.selectionStyle = .none
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupView() {
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(authorLabel)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(descriptionLabel)
        infoStackView.addArrangedSubview(newsImage)
        infoStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            newsImage.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    // MARK: - UI Components
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private let newsImage: UIImageView = {
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
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .label
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
        label.textColor = .label
        label.numberOfLines = 20
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    
    // MARK: - Selectors
    public func updateNewsCell(_ news: NewsListModel.FetchNews.ViewModel.DisplayedArticle) {
        authorLabel.text = news.author
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        dateLabel.text = news.publishedAt
        
        let url = URL(string: news.imageUrl)
        newsImage.kf.setImage(with: url)
    }
}
