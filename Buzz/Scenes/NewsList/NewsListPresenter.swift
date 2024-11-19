//
//  NewsListPresenter.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//

import Foundation

protocol NewsListPresentationLogic {
    func presentFetchNews(response: NewsListModel.FetchNews.Response)
    func presentError(error: Error)
}

class NewsListPresenter: NewsListPresentationLogic {
    weak var viewController: NewsListDisplayLogic?
    
    func presentFetchNews(response: NewsListModel.FetchNews.Response) {
        let displayedArticles =  response.articles.map { article in
            return NewsListModel.FetchNews.ViewModel.DisplayedArticle(
                id: article.id,
                title: article.title,
                description: article.description,
                author: article.author,
                publishedAt: formatDate(article.publishedAt),
                imageUrl: article.urlToImage)
        }
        
        let viewModel = NewsListModel.FetchNews.ViewModel(displayedArticles: displayedArticles)
        viewController?.displayFetchedNews(viewModel: viewModel)
    }
    
    func presentError(error: any Error) {
        print(error.localizedDescription)
        viewController?.displayError(error: error.localizedDescription)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        return formatter.string(from: date)
    }
}

