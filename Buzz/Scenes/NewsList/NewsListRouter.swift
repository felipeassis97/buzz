//
//  NewsListRouter.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//
import UIKit

protocol NewsListRoutingLogic {
    var viewController: NewsListViewController? { get set }
    func routeToNewsDetails(articleId: Int)
}

class NewsListRouter: NewsListRoutingLogic {
    var viewController: NewsListViewController?
    
    func routeToNewsDetails(articleId: Int) {
        let detailsVc = NewsListDetailsViewController(articleId: articleId)
        viewController?.navigationController?.pushViewController(detailsVc, animated: true)
    }
    
    //MARK: - Initial ViewController
    static func createInitialViewController() -> UIViewController {
        let viewController = NewsListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    
}
