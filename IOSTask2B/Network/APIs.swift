//
//  APIs.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation

struct APIs {
    static var shared = APIs()
    private let apiKey = "56dee4fccfc0f6b6f670cce65bd87750"
    
    private init() {}
    
    // create url contains the movie name for flicker api
    func getQueryUrl(for query: String) -> String {
        let urlStr = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1&text=\(query)&page=1&per_page=10"
        return urlStr.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
    
    // create photot url from photo object obtained by flicker to download photos
    func getPhotoUrl(_ photo: Photo) -> String? {
        guard
        let farm = photo.farm,
        let server = photo.server,
        let id = photo.id,
        let secret = photo.secret
        else {return nil}
        
        return "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
