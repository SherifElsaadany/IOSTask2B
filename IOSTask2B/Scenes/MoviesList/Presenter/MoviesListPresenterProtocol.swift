//
//  MoviesListPresenterProtocol.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import Foundation

protocol MoviesListPresenterProtocol: class {
    func onViewDidLoad(view: MoviesListProtocol)
    func onDidSelect(index: Int)
    func didTapSearch()
}
