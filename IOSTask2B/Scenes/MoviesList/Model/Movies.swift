//
//  Movies.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import Foundation
// MARK: - Movies
struct Movies: Codable {
    var movies: [Movie]?
}

// MARK: - Movie
struct Movie: Codable {
    var title: String?
    var year: Int?
    var cast: [String]?
    var genres: [String]?
    var rating: Int?
}
