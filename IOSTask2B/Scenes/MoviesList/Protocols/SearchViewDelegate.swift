//
//  SearchViewDelegate.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation

protocol SearchViewDelegate: class {
    func textDidChange(to text: String)
    func didCancelSearch()
}
