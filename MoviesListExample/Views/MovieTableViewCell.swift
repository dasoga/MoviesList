//
//  MovieTableViewCell.swift
//  MoviesListExample
//
//  Created by Dante Solorio on 11/23/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    let movieDirectorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    let movieReleaseYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    var movie: Movie? {
        didSet{
            movieTitleLabel.text = movie?.title
            movieDirectorLabel.text = movie?.director
            movieReleaseYearLabel.text = movie?.releaseYear
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){        
        addSubview(movieTitleLabel)
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        movieTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        movieTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(movieDirectorLabel)
        movieDirectorLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 4).isActive = true
        movieDirectorLabel.leftAnchor.constraint(equalTo: movieTitleLabel.leftAnchor).isActive = true
        movieDirectorLabel.rightAnchor.constraint(equalTo: movieTitleLabel.rightAnchor).isActive = true
        movieDirectorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(movieReleaseYearLabel)
        movieReleaseYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        movieReleaseYearLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        movieReleaseYearLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        movieReleaseYearLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
}
