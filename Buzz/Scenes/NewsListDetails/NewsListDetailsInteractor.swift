//
//  NewsListDetailsInteractor.swift
//  Buzz
//
//  Created by Felipe Assis on 17/11/2024.
//

import Foundation

protocol NewsListDetailsBusineesLogic {
    func loadNewsFromId(request: NewsListDetailsModel.Request)
}

protocol NewsListDetailsDataStore: AnyObject {
    var article: Article? { get set }
}

class NewsListDetailsInteractor: NewsListDetailsBusineesLogic, NewsListDetailsDataStore {
    var article: Article?
    private var worker: NewsAPIWorker
     var presenter: NewsListDetailsPresenterBusinessLogic?
    
    init(worker: NewsAPIWorker = NewsAPIWorker(networkingService: URLSessionNetworking())) {
        self.worker = worker
    }
    
    func loadNewsFromId(request: NewsListDetailsModel.Request) {
        worker.fetchArticleById(id: request.articleid) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let article):
                    let response = NewsListDetailsModel.Response(article: article)
                    self?.presenter?.presentfetchedNewsId(response: response)
                    self?.article = article
                case .failure(let error):
                    print("Error fetching article: \(error.localizedDescription)")
                }
            }
        }
    }
}
