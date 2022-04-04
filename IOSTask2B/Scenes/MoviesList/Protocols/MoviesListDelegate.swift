//
//  MoviesListDelegate.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation

protocol MoviesListDelegate: class {
    func didSelect(_ indexPath: IndexPath)
}
