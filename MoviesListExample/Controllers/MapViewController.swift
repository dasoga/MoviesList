//
//  MapViewController.swift
//  MoviesListExample
//
//  Created by Dante Solorio on 11/24/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    var movieSelected: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if let movie = movieSelected{
            setupLocation(movie: movie)
        }
    }
    
    // MARK: - Private functions
    private func setupView(){
        view.backgroundColor = .white
        
        setupNavBar()
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func setupNavBar(){
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    private func setupLocation(movie: Movie){
        // Update location with movie location data. eg 37.7577627,-122.4726194
        
        let exampleLocation = CLLocationCoordinate2DMake(37.7577627, -122.4726194)
        
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegion(center: exampleLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let exampleAnotation  = MKPointAnnotation()
        exampleAnotation.coordinate = exampleLocation
        exampleAnotation.title = movie.title
        
        mapView.addAnnotation(exampleAnotation)
    }

}
