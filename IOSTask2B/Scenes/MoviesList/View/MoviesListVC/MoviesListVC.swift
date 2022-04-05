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
        self.title = "MOVIES"
        presenter?.onViewDidLoad(view: self)
        searchView.delegate = self
        moviesListView.delegate = self
        configureNavigationBar()
    }
    
    // set navigation bar colors and remove title from back button
    private func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.backgroundColor = .darkGray
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

//MARK:- MoviesListProtocol
extension MoviesListVC: MoviesListProtocol {
    // recieve movies data from presenter and send it to list view
    func setRows(with movies: [MoviesCategories]) {
        moviesListView.updateList(with: movies)
    }
}

//MARK:- SearchViewDelegate
extension MoviesListVC: SearchViewDelegate {
    // inform presenter that search is canceled to resend the oiginal data
    func didCancelSearch() {
        presenter?.didCancelSearch()
    }
    
    // send search query to presenter so it return the results
    func textDidChange(to text: String) {
        presenter?.didSearch(for: text)
    }
}

//MARK:- MoviesListDelegate
extension MoviesListVC: MoviesListDelegate {
    // inform presenter when user select a movie from a list to show details
    func didSelect(_ indexPath: IndexPath) {
        presenter?.onDidSelect(section: indexPath.section, index: indexPath.row)
    }
}
