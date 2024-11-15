//
//  NewsAPIWorker.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//

import Foundation

enum NewsApi {
    static let baseURL = "https://my-json-server.typicode.com/alura-cursos/news-api"
    static let articles = "/articles"
}

class NewsAPIWorker {
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: NewsApi.baseURL + NewsApi.articles) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        networkingService.request(url: url) { (result: Result<[Article], Error>) in
            switch result {
            case .success(let articles):
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
