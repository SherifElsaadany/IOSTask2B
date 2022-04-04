//
//  ReusableViewProtocol.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import Foundation

protocol ReusableView: class {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

