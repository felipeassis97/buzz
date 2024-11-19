//
//  NewsListDetailsModel.swift
//  Buzz
//
//  Created by Felipe Assis on 17/11/2024.
//

import Foundation

struct NewsListDetailsModel {
    struct Request {
        let articleid: Int
    }
    
    struct Response {
        let article: Article?
    }
    
    struct ViewModel {
        struct DisplayedArticle {
            let title: String
            let author: String
            let content: String
            let description: String
            let url: String
            let imageUrl: String
            let publishedAt: String
        }
        let displayedAritcle: DisplayedArticle
    }
}
