//
//  WebServiceProtocol.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation
import Alamofire

protocol WebServiceProtocol {
    // any web service class should have this function which used y the presenter
    func getPhotos(of movie: String, completion: @escaping (Result<FlickerPhotos, AFError>) -> Void)
}
