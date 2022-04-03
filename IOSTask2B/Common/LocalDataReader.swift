//
//  LocalDataReader.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import Foundation

class LocalDataReader {
    func loadJson(filename fileName: String) -> Movies? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil}
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Movies.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
            return nil
        }
    }
}

//MARK:- StorageHandlerProtocol
extension LocalDataReader: StorageHandlerProtocol {
    func getMovies() -> Movies? {
        return loadJson(filename: "movies")
    }
}
