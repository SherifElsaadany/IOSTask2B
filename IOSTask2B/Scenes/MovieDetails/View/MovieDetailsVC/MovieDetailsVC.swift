//
//  MovieDetailsVC.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import UIKit

class MovieDetailsVC: UIViewController {

    var presenter: MovieDetailsPresenterProtocol?
    
    @IBOutlet weak var detailsView: MovieDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DETAILS"
        presenter?.onViewDidLoad(view: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailsView.invalidateCollectionView()
    }

}

//MARK:- MovieDetailsViewProtocol
extension MovieDetailsVC: MovieDetailsViewProtocol {
    
    func setDetails(of movie: MovieDetails) {
        detailsView.updateDetails(of: movie)
    }
    
    func setPhotos(_ photosUrls: [String]) {
        detailsView.updatePhotos(photosUrls)
    }
}
