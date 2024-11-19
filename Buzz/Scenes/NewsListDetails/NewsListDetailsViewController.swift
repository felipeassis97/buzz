//
//  NewsListDetailsViewController.swift
//  Buzz
//
//  Created by Felipe Assis on 15/11/2024.
//

import UIKit
import Kingfisher

protocol NewsListDetailsVCDisplayedLogic: AnyObject {
    func diplayFetchedNews(viewModel: NewsListDetailsModel.ViewModel)
    func displayError(message: String)
}

class NewsListDetailsViewController: UIViewController {
    // MARK: - Variables
    var articleId: Int
    var interactor: NewsListDetailsInteractor?
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
        fetchNewsDetailsById()
    }
    
    init(articleId: Int) {
        self.articleId = articleId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsDetails: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var articleDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .ultraLight)
        label.numberOfLines = 0
        label.textColor = .neutral
        label.textAlignment = .left
        return label
    }()
    
    private lazy var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = .primaryAqua
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var articleAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .neutral
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .neutral
        return label
    }()
    
    private lazy var articleContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .neutral
        return label
    }()
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .onNeutral
        title = "Artigo"
        
        let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 16, weight: .bold),
                .foregroundColor: UIColor.primaryAqua
            ]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        let shareButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"), // Ícone do SF Symbols
            style: .plain,
            target: self,
            action: #selector(shareButtonTapped)
        )
        
        // Adicionar o botão na app bar
        navigationItem.rightBarButtonItem = shareButton

        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(newsDetails)
        
        // Adicione os elementos ao StackView
        newsDetails.addArrangedSubview(image)
        newsDetails.addArrangedSubview(articleDateLabel)
        newsDetails.addArrangedSubview(articleTitleLabel)
        newsDetails.addArrangedSubview(articleAuthorLabel)
        newsDetails.addArrangedSubview(articleDescriptionLabel)
        newsDetails.addArrangedSubview(articleContentLabel)
        
        //Custom spacing
        newsDetails.setCustomSpacing(16, after: image)
        newsDetails.setCustomSpacing(24, after: articleDateLabel)
        newsDetails.setCustomSpacing(24, after: articleTitleLabel)
        newsDetails.setCustomSpacing(8, after: articleAuthorLabel)
        newsDetails.setCustomSpacing(24, after: articleDescriptionLabel)
        
        setupConstraints()
    }
    
    @objc private func shareButtonTapped() {
        let itemsToShare = ["Texto para compartilhar"]
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

        // Apresenta o controller
        present(activityVC, animated: true)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView Constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView Constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // NewsDetails (StackView) Constraints
            newsDetails.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            newsDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            newsDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            newsDetails.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            // Image Constraints (máximo de 250)
            image.heightAnchor.constraint(lessThanOrEqualToConstant: 250),
            image.widthAnchor.constraint(equalTo: newsDetails.widthAnchor)
            
            
        ])
    }
    
    private func fetchNewsDetailsById() {
        let request = NewsListDetailsModel.Request(articleid: self.articleId)
        interactor?.loadNewsFromId(request: request)
    }
    
    // MARK: - Bindings
    private func configure() {
        let viewController = self
        let interactor = NewsListDetailsInteractor()
        let presenter = NewsListDetailsPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension NewsListDetailsViewController: NewsListDetailsVCDisplayedLogic {
    func diplayFetchedNews(viewModel: NewsListDetailsModel.ViewModel) {
        articleTitleLabel.text = viewModel.displayedAritcle.title
        articleDateLabel.text = viewModel.displayedAritcle.publishedAt
        articleAuthorLabel.text = viewModel.displayedAritcle.author
        articleDescriptionLabel.text = viewModel.displayedAritcle.description
        articleContentLabel.text = viewModel.displayedAritcle.content
        let url = URL(string: viewModel.displayedAritcle.imageUrl)
        image.kf.setImage(with: url)
    }
    
    func displayError(message: String) {
        print(message)
    }
}
