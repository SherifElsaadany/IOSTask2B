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
        configureSearchBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureSearchBar()
    }
    
    private func loadNib() {
        let viewFromXib = Bundle.main.loadNibNamed(Self.reuseIdentifier, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame  = self.bounds
        addSubview(viewFromXib)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for a movie"
    }
}

//MARK:- UISearchBarDelegate
extension SearchBarView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            delegate?.didCancelSearch()
            return
        }
        
        delegate?.textDidChange(to: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didCancelSearch()
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
