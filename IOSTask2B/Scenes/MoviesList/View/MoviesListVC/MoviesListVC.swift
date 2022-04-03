//
//  MoviesListVC.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import UIKit

class MoviesListVC: UIViewController {
    
    var presenter: MoviesListPresenterProtocol?

    @IBOutlet weak var moviesListView: MoviesListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad(view: self)
    }

}

//MARK:- MoviesListProtocol
extension MoviesListVC: MoviesListProtocol {
    func setRows(with movies: [String]) {
        moviesListView.updateList(with: movies)
    }
}
