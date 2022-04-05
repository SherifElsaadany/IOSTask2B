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
        // make new line string for each one in the cast arry
        guard let castArray = movie.cast else {return nil}
        let cast = castArray.joined(separator: "\n\n ")
        return "Cast:\n\n \(cast)"
    }
    
    private func getMovieDetails() -> MovieDetails {
        // prepare movie details to br presented in view
        let genres = movie.genres?.joined(separator: ", ")
        let cast = getCastStr()
        let movieDetails = MovieDetails(title: movie.title, year: "\(movie.year ?? 0)", genres: genres, cast: cast)
        return movieDetails
    }
    
    private func showPhotos(_ photos: FlickerPhotos) {
        // get photos urls and sebd it to view
        guard let photosList = photos.photos?.photo?.compactMap({APIs.shared.getPhotoUrl($0)}) else {return}
        view?.setPhotos(photosList)
    }
}

//MARK:- MovieDetailsViewProtocol
extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func onViewDidLoad(view: MovieDetailsViewProtocol) {
        // recieve view did load action from view to prepeare data for presentation
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
    // web service request to get photos from flicker
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
