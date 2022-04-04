//
//  MovieDetailsView.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import UIKit

class MovieDetailsView: UIView, ReusableView {
    
    private var movieDetails: MovieDetails?
    private var photos: [String]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureCollectionView()
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureCollectionView()
        registerCells()
    }
    
    private func loadNib() {
        let viewFromXib = Bundle.main.loadNibNamed(Self.reuseIdentifier, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame  = self.bounds
        addSubview(viewFromXib)
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: PhotoCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        collectionView.register(MovieDetailsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieDetailsHeader.reuseIdentifier)
    }
    
    func invalidateCollectionView() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func updateDetails(of details: MovieDetails) {
        self.movieDetails = details
        collectionView.reloadData()
    }
    
    func updatePhotos(_ photos: [String]) {
        self.photos = photos
        collectionView.reloadData()
    }
}

// MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension MovieDetailsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        let photoUrl = photos?[indexPath.row]
        cell.configure(photoUrl: photoUrl)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let header = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? MovieDetailsHeader {
            return CGSize(width: collectionView.bounds.width, height: header.getContentHeight())
        }
        return CGSize(width: collectionView.bounds.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieDetailsHeader.reuseIdentifier, for: indexPath) as! MovieDetailsHeader
        header.configureHeader(movieDetails)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
