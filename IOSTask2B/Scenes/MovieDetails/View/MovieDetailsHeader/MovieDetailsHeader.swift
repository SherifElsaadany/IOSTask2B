//
//  MovieDetailsHeader.swift
//  IOSTask2B
//
//  Created by Elsaadany on 04/04/2022.
//

import UIKit

class MovieDetailsHeader: UICollectionReusableView, ReusableView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var castLbl: UILabel!
    @IBOutlet weak var topAnchorConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    private func loadNib() {
        let viewFromXib = Bundle.main.loadNibNamed(Self.reuseIdentifier, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame  = self.bounds
        addSubview(viewFromXib)
    }
    
    private func configureLayout() {
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    func getContentHeight() -> CGFloat {
        return contentView.bounds.height + 2 * topAnchorConstraint.constant
    }
    
    func configureHeader(_ details: MovieDetails?) {
        guard let details = details else {return}
        self.titleLbl.text = details.title
        self.yearLbl.text = details.year
        self.genresLbl.text = details.genres
        self.castLbl.text = details.cast
    }
}
