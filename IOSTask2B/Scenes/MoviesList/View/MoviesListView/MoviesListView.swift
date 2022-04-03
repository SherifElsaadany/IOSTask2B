//
//  MoviesListView.swift
//  IOSTask2B
//
//  Created by Elsaadany on 03/04/2022.
//

import UIKit

class MoviesListView: UIView, ReusableView {

    
    private var moviesTitles: [String]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configureTableView()
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        configureTableView()
        registerCells()
    }
    
    private func loadNib() {
        let viewFromXib = Bundle.main.loadNibNamed(Self.reuseIdentifier, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame  = self.bounds
        addSubview(viewFromXib)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func updateList(with titles: [String]) {
        self.moviesTitles = titles
        self.tableView.reloadData()
    }
}

//MARK:- UITableViewDataSource, UITableViewDragDelegate
extension MoviesListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesTitles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let title = moviesTitles?[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
}
