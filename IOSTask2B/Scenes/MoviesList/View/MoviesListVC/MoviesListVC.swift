//
//  MoviesListVC.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import UIKit

class MoviesListVC: UIViewController {
    
    var presenter: MoviesListPresenterProtocol?

    @IBOutlet weak var searchView: SearchBarView!
    @IBOutlet weak var moviesListView: MoviesListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad(view: self)
        searchView.delegate = self
    }

}

//MARK:- MoviesListProtocol
extension MoviesListVC: MoviesListProtocol {
    func setRows(with movies: [MoviesCategories]) {
        moviesListView.updateList(with: movies)
    }
}

//MARK:- SearchViewDelegate
extension MoviesListVC: SearchViewDelegate {
    func didCancelSearch() {
        presenter?.didCancelSearch()
    }
    
    func textDidChange(to text: String) {
        presenter?.didSearch(for: text)
    }
}
