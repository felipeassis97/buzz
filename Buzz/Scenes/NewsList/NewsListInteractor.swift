//
//  NewsListInteractor.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//

import Foundation

protocol NewsListDataStore {
    var articles: [Article] { get set }
}

protocol NewsListBusineesLogic {
    func loadNews(request: NewsListModel.FetchNews.Request)
}

class NewsListInteractor: NewsListBusineesLogic, NewsListDataStore {
    private var worker: NewsAPIWorker
    var articles: [Article] = []
    var presenter: NewsListPresentationLogic?
    
    init(worker: NewsAPIWorker = NewsAPIWorker(networkingService: URLSessionNetworking())) {
        self.worker = worker
    }
    
    func loadNews(request: NewsListModel.FetchNews.Request) {
        worker.fetchNews { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = articles
                    let response = NewsListModel.FetchNews.Response(articles: articles)
                    self.presenter?.presentFetchNews(response: response)
                    print("Fetched Articles: \(self.articles)")
                case .failure(let error):
                    print("Error during fetch news: \(error.localizedDescription)")
                    self.presenter?.presentError(error: error)
                }
            }
        }
    }
}
