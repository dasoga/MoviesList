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
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let cellId = "cellIdentifier"
    
    var moviesList: [Movie] = []
    var moviesLocations: [String] = []
    
    var moviesByLocation: [[Movie]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call this function to setup navigation bar.
        setupNavBar()
        
        // Call this function to setup view and all the elements inside it.
        setupView()
        // Register movie cell
        moviesTable.register(MovieTableViewCell.self, forCellReuseIdentifier: cellId)
        
        
        Network.sharedInstance.getAllMovies { (movies) in
            guard let allMovies = movies else { return }
            self.moviesList = allMovies
            
            self.setupMoviesSections(movies: allMovies)
        }
    }
    
    // MARK: - Private functions
    /*
        This functions setup the navigation bat with colores, titles and custom elements.
    */
    private func setupNavBar(){
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
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
    
    /*
        Function to setup the sections of table with movies location info.
     */
    private func setupMoviesSections(movies: [Movie]){
        // Save just the movies locations as a filter.
        let moviesLocationsStrings = movies.flatMap { $0.locations }
        // Setup movies by locations.
        setupMoviesByLocation(movies: movies, moviesLocation: moviesLocationsStrings)
    }
    
    /*
        Function to setup the arrays with movies info, and sections with movies location info.
    */
    private func setupMoviesByLocation(movies: [Movie], moviesLocation: [String]){
        self.moviesLocations = moviesLocation
        
        for location in moviesLocation{
            let filterdMovies = movies.filter { $0.locations == location }
            moviesByLocation.append(filterdMovies)
        }
        
        // Let main thread manage the refresh to view.
        DispatchQueue.main.async {
            self.moviesTable.reloadData()
        }
    }
}



/*
 Extension of our controller to conform UITableView protocols and show cells
*/

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    // UITable datasource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.movie = moviesByLocation[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesByLocation[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesLocations.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moviesLocations[section]
    }
    
    // UITable delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapController = MapViewController()
        mapController.movieSelected = moviesByLocation[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(mapController, animated: true)
    }
    
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var alreadyAdded = Set<Iterator.Element>()
        return self.filter { alreadyAdded.insert($0).inserted }
    }
}
