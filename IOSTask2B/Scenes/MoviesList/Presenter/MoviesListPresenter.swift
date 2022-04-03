//
//  MoviesListPresenter.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import Foundation

class MoviesListPresenter {
    
    weak var view: MoviesListProtocol?
    private var fetchedMovies: Movies?
    private var storage: StorageHandlerProtocol
    
    init(storage: StorageHandlerProtocol) {
        self.storage = storage
    }
    
    private func sendViewData(_ movies: Movies?) {
        guard let moviesTitles = movies?.movies?.map({$0.title ?? ""}) else {return}
        view?.setRows(with: moviesTitles)
    }
}

//MARK:- MoviesListPresenterProtocol
extension MoviesListPresenter: MoviesListPresenterProtocol {
    func onViewDidLoad(view: MoviesListProtocol) {
        self.view = view
        self.fetchedMovies = storage.getMovies()
        sendViewData(fetchedMovies)
    }
    
    func onDidSelect(index: Int) {
        
    }
    
    func didTapSearch() {
        
    }
}
