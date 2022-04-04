//
//  MoviesListRouter.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import UIKit

class MoviesListRouter {
    private weak var vc: UIViewController?

    init(vc: UIViewController) {
        self.vc = vc
    }
}
// MARK:- MoviesListRoutingProtocol
extension MoviesListRouter: MoviesListRoutingProtocol {
    func show(movie: Movie) {
        // TODO:- push movie details view controller
    }
}