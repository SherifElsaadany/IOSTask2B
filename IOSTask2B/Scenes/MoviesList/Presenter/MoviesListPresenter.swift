//
//  MoviesListPresenter.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import Foundation

class MoviesListPresenter {
    
    weak var view: MoviesListProtocol?
    private var storage: StorageHandlerProtocol
    private var allMovies: [MoviesCategories]?
    private var displayedMovies: [MoviesCategories]?
    private let router: MoviesListRoutingProtocol
    
    init(storage: StorageHandlerProtocol, router: MoviesListRoutingProtocol) {
        self.storage = storage
        self.router = router
    }
    
    private func getMovies() -> MoviesCategories? {
        // get movies from local data file and map it to MoviesCategories
        guard let movies = storage.getMovies()?.movies else {return nil}
        let allMovies = MoviesCategories(category: "All", movies: movies)
        return allMovies
    }
    
    private func findMovies(contains text: String) -> [Movie]? {
        // filter fetched movies which its titles contains search text
        let result = allMovies?.first?.movies.filter({
            let title = $0.title?.lowercased() ?? ""
            return title.contains(text.lowercased())
        })
        
        return result
    }
    
    private func getSortedResults(_ result: [Movie]?) -> [MoviesCategories]? {
        // sort results by rating
        guard let sortedResults = result?.sorted(by: {($0.rating ?? 0) > ($1.rating ?? 0)}) else {return nil}
        
        // convert movies list to dicitonary grouped by year
        let moviesDict = Dictionary(grouping: sortedResults, by: { $0.year })
        
        // map dictionary to array of movies categories object contains only top five movies in each year, and sorted by year
        let sortedMovies = moviesDict.map({
            MoviesCategories(category: "\($0.key ?? 0)", movies: Array($0.value.prefix(5)))
        }).sorted(by: {(Int($0.category) ?? 0) > (Int($1.category) ?? 0)})
        return sortedMovies
    }
    
    private func sendViewData(_ movies: MoviesCategories) {
        self.allMovies = [movies]
        self.displayedMovies = [movies]
        guard let displayedMovies = displayedMovies else {return}
        view?.setRows(with: displayedMovies)
    }
}

//MARK:- MoviesListPresenterProtocol
extension MoviesListPresenter: MoviesListPresenterProtocol {
    
    func onViewDidLoad(view: MoviesListProtocol) {
        self.view = view
        guard let allMovies = getMovies() else {return}
        sendViewData(allMovies)
    }
    
    func onDidSelect(section: Int, index: Int) {
        guard let movie = displayedMovies?[section].movies[index] else {return}
        router.show(movie: movie)
    }
    
    func didSearch(for text: String) {
        // filter fetched movies by search text
        let result = findMovies(contains: text)
        
        // get sroted and categorized results
        guard let sortedMovies = getSortedResults(result) else {return}
        self.displayedMovies = sortedMovies
        // send handled search results to view
        view?.setRows(with: sortedMovies)
    }
    
    func didCancelSearch() {
        self.displayedMovies = allMovies
        guard let displayedMovies = self.displayedMovies else {return}
        view?.setRows(with: displayedMovies)
    }
}
