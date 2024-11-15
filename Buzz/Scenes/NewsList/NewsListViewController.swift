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
    var interactor: NewsListBusineesLogic?
    var displayedArticles: [NewsListModel.FetchNews.ViewModel.DisplayedArticle] = []
    
    // MARK: - UI Components
    private lazy var newsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        
    }()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchNews()
        addSubViews()
        setupConstraints()
    }
    
    private func setup() {
        let viewController = self
        let interactor = NewsListInteractor()
        let presenter = NewsListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: - UI Setup
    private func addSubViews() {
        view.backgroundColor = .primaryAqua
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
    
    private func fetchNews() {
        interactor?.loadNews(request: NewsListModel.FetchNews.Request())
    }
    

}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedArticles.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsTableViewCell()
        cell.updateNewsCell(displayedArticles[indexPath.row])
        return cell
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
