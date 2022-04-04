//
//  PhotoCell.swift
//  IOSTask2B
//
//  Created by Elsaadany on 05/04/2022.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell, ReusableView {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(photoUrl: String?) {
        guard let url = URL(string: photoUrl ?? "") else {return}
        imageView.kf.setImage(with: url)
    }

}
