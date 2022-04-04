//
//  MovieDetailsPresenter.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import Foundation

class MovieDetailsPresenter {
    
    private let webService: WebServiceProtocol
    private weak var view: MovieDetailsViewProtocol?
    private var movie: Movie
    
    init(movie: Movie, webService: WebServiceProtocol) {
        self.movie = movie
        self.webService = webService
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
    
    private func showPhotos(_ photos: FlickerPhotos) {
        guard let photosList = photos.photos?.photo?.compactMap({APIs.shared.getPhotoUrl($0)}) else {return}
        view?.setPhotos(photosList)
    }
}

//MARK:- MovieDetailsViewProtocol
extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func onViewDidLoad(view: MovieDetailsViewProtocol) {
        self.view = view
        let details = getMovieDetails()
        view.setDetails(of: details)
        if let title = movie.title {
            self.getPhotos(of: title)
        }
    }
}

//MARK:- Networking
extension MovieDetailsPresenter {
    private func getPhotos(of movie: String) {
        self.webService.getPhotos(of: movie) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let photos):
                self.showPhotos(photos)
            case .failure(let error):
                print("fetch photos error \(error)")
            }
        }
    }
}
