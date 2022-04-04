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
    private var allMovies: [MoviesCategories]?
    private var sortedResult: [MoviesCategories]?
    
    init(storage: StorageHandlerProtocol) {
        self.storage = storage
    }
    
    private func findMovies(contains text: String) -> [Movie]? {
        // filter fetched movies which its titles contains search text
        let result = fetchedMovies?.movies?.filter({
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
        self.sortedResult = sortedMovies
        return sortedMovies
    }
    
    private func sendViewData(_ movies: Movies?) {
        guard let movies = movies?.movies else {return}
        let allMovies = MoviesCategories(category: "All", movies: movies)
        self.allMovies = [allMovies]
        view?.setRows(with: [allMovies])
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
    
    func didSearch(for text: String) {
        // filter fetched movies by search text
        let result = findMovies(contains: text)
        
        // get sroted and categorized results
        guard let sortedMovies = getSortedResults(result) else {return}
        
        // send handled search results to view
        view?.setRows(with: sortedMovies)
    }
    
    func didCancelSearch() {
        guard let allMovies = self.allMovies else {return}
        view?.setRows(with: allMovies)
    }
}
