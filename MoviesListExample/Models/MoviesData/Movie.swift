//
//  Movie.swift
//  MoviesListExample
//
//  Created by Dante Solorio on 11/23/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String?
    let locations: String?
    let releaseYear: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case locations
        case releaseYear = "release_year"
    }
}

