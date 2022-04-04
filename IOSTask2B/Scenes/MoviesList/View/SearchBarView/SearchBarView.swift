//
//  SearchBarView.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import UIKit

class SearchBarView: UIView, ReusableView {
    
    weak var delegate: SearchViewDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        searchBar.delegate = self
    }
    
    private func loadNib() {
        let viewFromXib = Bundle.main.loadNibNamed(Self.reuseIdentifier, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame  = self.bounds
        addSubview(viewFromXib)
    }
}

//MARK:- UISearchBarDelegate
extension SearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            delegate?.didCancelSearch()
            return
        }
        
        delegate?.textDidChange(to: searchText)
    }
}
