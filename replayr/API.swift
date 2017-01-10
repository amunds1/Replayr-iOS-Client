//
//  API.swift
//  replayr
//
//  Created by Andreas Amundsen on 07/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let baseUrl = "http://replayr.fshauge.me/" 

func search(phrase: String, callback: @escaping ([Movie]) -> ()) {
    let url = baseUrl + "search/" + phrase
    
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        var movies = [Movie]()

        for movie in json["movies"].arrayValue {
            movies.append(Movie(id: movie["id"].int! , title: movie["title"].string!, image: movie["image"].string!))
        }
        
        callback(movies)
    }
}

func getEpisodes(movie: Movie, callback: @escaping ([Episode]) -> ()) {
    let url = baseUrl + "episodes/" + String(movie.getId())
    
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        var episodes = [Episode]()
        
        for episode in json["episodes"].arrayValue {
            episodes.append(Episode(id: episode["id"].int!, server: episode["server"].int!, title: episode["title"].string!))
        }
        
        callback(episodes)
    }
}

func getSource(movie: Movie, episode: Episode, callback: @escaping (String) -> ()) {
    let url = baseUrl + "source/" + String(movie.getId()) + "/" + String(episode.getId())
    
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        
        callback(json["source"].string!)
    }
}

class Movie {
    let id: Int
    let title: String
    let image: String
    
    init(id: Int, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
    
    func getId() -> Int {
        return id
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getImage() -> String {
        return image
    }
}

class Episode {
    let id: Int
    let server: Int
    let title: String
    
    init(id: Int, server: Int, title: String) {
        self.id = id
        self.server = server
        self.title = title
    }
    
    func getId() -> Int {
        return id
    }
    
    func getServer() -> Int {
        return server
    }
    
    func getTitle() -> String {
        return title
    }
}
