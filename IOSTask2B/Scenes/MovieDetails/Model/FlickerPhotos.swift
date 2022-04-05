//
//  FlickerPhotos.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation
// MARK: - FlickerPhotos
struct FlickerPhotos: Codable {
    var photos: Photos?
    var stat: String?
}

// MARK: - Photos
struct Photos: Codable {
    var page, pages, perpage, total: Int?
    var photo: [Photo]?
}

// MARK: - Photo
struct Photo: Codable {
    var id, owner, secret, server: String?
    var farm: Int?
    var title: String?
    var ispublic, isfriend, isfamily: Int?
}
