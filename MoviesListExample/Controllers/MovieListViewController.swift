//
//  MovieListViewController.swift
//  MoviesListExample
//
//  Created by Dante Solorio on 11/23/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

/*
    This class is controller to show movies list, load Movies model and show in a view with name movie cell.
 */

class MovieListViewController: UIViewController {
    
    lazy var moviesTable: UITableView = {
        let table = UITableView()
//        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let cellId = "cellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call this function to setup navigation bar.
        setupNavBar()
        // Call this function to setup view and all the elements inside it.
        setupView()
        // Register movie cell
        
        moviesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    // MARK: - Private functions
    /*
        This functions setup the navigation bat with colores, titles and custom elements.
    */
    private func setupNavBar(){
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /*
     This functions setup the view bat with colores, titles and custom elements.
     */
    private func setupView(){
        view.backgroundColor = .white
        
        // Add table property
        view.addSubview(moviesTable)
        // Constraints, autolayout for movies table inside the view controller.
        moviesTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        moviesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        moviesTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        moviesTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}


/*
 Extension of our controller to conform UITableView protocols and show cells
*/

extension MovieListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "Index \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
