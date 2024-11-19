//
//  NewsListDetailsPresenter.swift
//  Buzz
//
//  Created by Felipe Assis on 17/11/2024.
//

import Foundation

protocol NewsListDetailsPresenterBusinessLogic {
    func presentfetchedNewsId(response: NewsListDetailsModel.Response)
    func presentError(error: Error)
}


class NewsListDetailsPresenter: NewsListDetailsPresenterBusinessLogic {
    weak var viewController: NewsListDetailsViewController?
    
    func presentfetchedNewsId(response: NewsListDetailsModel.Response) {
        let article = response.article
        
        guard let article else { return }
        
        let displayableArticle = NewsListDetailsModel.ViewModel.DisplayedArticle(
            title: article.title,
            author: article.author,
            content: article.content,
            description: article.description,
            url: article.url,
            imageUrl: article.urlToImage,
            publishedAt: formatDate(article.publishedAt))
        
        let viewModel = NewsListDetailsModel.ViewModel(displayedAritcle: displayableArticle)
        self.viewController?.diplayFetchedNews(viewModel: viewModel)
    }
    
    func presentError(error:  Error) {
        self.viewController?.displayError(message: error.localizedDescription)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        return formatter.string(from: date)
    }
}
 
