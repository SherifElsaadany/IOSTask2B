//
//  APIClient.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation
import Alamofire

struct APIClient {
    func performRequest<T: Decodable>(url: String, completion: @escaping (Result<T, AFError>) -> Void) {
        
        guard let url = URL(string: url) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseDecodable(decoder: JSONDecoder()){ (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}

