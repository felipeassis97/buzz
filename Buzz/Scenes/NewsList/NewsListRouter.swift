//
//  NewsListRouter.swift
//  Buzz
//
//  Created by Felipe Assis on 14/11/2024.
//
import UIKit

class NewsListRouter {
    static func createInitialViewController() -> UIViewController {
        let viewController = NewsListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
