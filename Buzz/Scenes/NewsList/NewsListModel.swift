//
//  NewsListModel.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//

import Foundation

struct NewsListModel {
    struct FetchNews {
        struct Request {}
        struct Response {
            let articles: [Article]
        }
        
        struct ViewModel {
            struct DisplayedArticle {
                let title: String
                let description: String
                let author: String
                let publishedAt: String
                let imageUrl: String
            }
            let displayedArticles: [DisplayedArticle]
        }
    }
}
