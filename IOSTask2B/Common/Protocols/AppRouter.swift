//
//  AppRouter.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import UIKit

final class AppRouter {
    func setRootScreen(in window: UIWindow?) {
        let vc = MoviesListVC()
        let router = MoviesListRouter(vc: vc)
        let presenter = MoviesListPresenter(storage: LocalDataReader(), router: router)
        vc.presenter = presenter
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
