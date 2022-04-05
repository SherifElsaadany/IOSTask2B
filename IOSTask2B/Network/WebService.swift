//
//  WebService.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation
import Alamofire

struct WebServices: WebServiceProtocol {
    private let networkProvider = APIClient()
    
    // photos request from flicker
    func getPhotos(of movie: String, completion: @escaping (Result<FlickerPhotos, AFError>) -> Void) {
        let url = APIs.shared.getQueryUrl(for: movie)
        networkProvider.performRequest(url: url) { (result: Result<FlickerPhotos, AFError>) in
            completion(result)
        }
    }
}
