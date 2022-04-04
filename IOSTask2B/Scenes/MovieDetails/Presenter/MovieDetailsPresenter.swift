//
//  MovieDetailsPresenter.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation

class MovieDetailsPresenter {
    
    private weak var view: MovieDetailsViewProtocol?
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    private func getCastStr() -> String? {
        guard let castArray = movie.cast else {return nil}
        let cast = castArray.joined(separator: "\n\n ")
        return "Cast:\n\n \(cast)"
    }
    
    private func getMovieDetails() -> MovieDetails {
        let genres = movie.genres?.joined(separator: ", ")
        let cast = getCastStr()
        let movieDetails = MovieDetails(title: movie.title, year: "\(movie.year ?? 0)", genres: genres, cast: cast)
        return movieDetails
    }
}

//MARK:- MovieDetailsViewProtocol
extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func onViewDidLoad(view: MovieDetailsViewProtocol) {
        self.view = view
        let details = getMovieDetails()
        view.setDetails(of: details)
    }
}
