//
//  WebServiceProtocol.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation
import Alamofire

protocol WebServiceProtocol {
    func getPhotos(of movie: String, completion: @escaping (Result<FlickerPhotos, AFError>) -> Void)
}
