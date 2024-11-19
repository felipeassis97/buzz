//
//  ViewController.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//

import UIKit

protocol NewsListDisplayLogic: AnyObject {
    func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel)
    func displayError(error: String)
}

class NewsListViewController: UIViewController {
    // MARK: - Variables
    var router: NewsListRoutingLogic?
    var interactor: NewsListBusineesLogic?
    var displayedArticles: [NewsListModel.FetchNews.ViewModel.DisplayedArticle] = []
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchNews()
        setupView()
        setupConstraints()
    }
    
    // MARK: - UI Components
    private lazy var newsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .onNeutral
        view.addSubview(newsListTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Bindings
    private func configure() {
        router = NewsListRouter()
        let viewController = self
        let interactor = NewsListInteractor()
        let presenter = NewsListPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router?.viewController = viewController
    }
    
    private func fetchNews() {
        interactor?.loadNews(request: NewsListModel.FetchNews.Request())
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(displayedArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = displayedArticles[indexPath.row]
        self.router?.routeToNewsDetails(articleId: article.id)
    }
}

extension NewsListViewController: NewsListDisplayLogic {
    func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel) {
        self.displayedArticles = viewModel.displayedArticles
        newsListTableView.reloadData()
    }
    
    func displayError(error: String) {
        let alert = UIAlertController(title: "Erro!", message: error  , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
