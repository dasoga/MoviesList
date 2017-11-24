//
//  Network.swift
//  MoviesListExample
//
//  Created by Dante Solorio on 11/23/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import Foundation

class Network {
    
    static var sharedInstance: Network = Network()
    
    func getAllMovies(completion:@escaping ([Movie]?)->() ){
        
        guard let moviesDataURL = URL(string: "https://data.sfgov.org/resource/wwmu-gmzc.json") else { return }
        
        URLSession.shared.dataTask(with: moviesDataURL) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            
            //Success
            guard let data = data else { return }
            do {
                let moviesData = try JSONDecoder().decode([Movie].self, from: data)
                completion(moviesData)
            }catch let jsonErr {
                print(jsonErr)
                completion(nil)
            }
            }.resume()
        
    }
    
    func downloadSong(songUrl: String, completion: @escaping (Data?)->()){
        
        
    }
    
}
