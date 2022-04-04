//
//  MovieDetailsView.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import UIKit

class MovieDetailsView: UIView, ReusableView {
    
    private var movieDetails: MovieDetails?
    
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MovieDetailsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieDetailsHeader.reuseIdentifier)
    }
    
    func invalidateCollectionView() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func updateDetails(of details: MovieDetails) {
        self.movieDetails = details
        collectionView.reloadData()
    }
}

// MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension MovieDetailsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
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
}
