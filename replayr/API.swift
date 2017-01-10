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
            //movies.append(Movie(id: movie["id"].int!, title: movie["title"].string!, image: movie["image"].string!, description: movie["description"].string!, release: movie["release"].int!, IMDb: movie["imdb"].float!))
        }
        
        callback(movies)
    }
}

func getEpisodes(movie: Movie, callback: @escaping ([Server]) -> ()) {
    let url = baseUrl + "episodes/" + String(movie.id)
    
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        var servers = [Server]()
        
        for server in json["servers"].arrayValue {
            var episodes = [Episode]()
            for episode in server["episodes"].arrayValue {
                episodes.append(Episode(id: episode["id"].int!, title: episode["title"].string!))
            }
            servers.append(Server(id: server["id"].int!, episodes: episodes))
        }
        callback(servers)
    }
}

func getSource(movie: Movie, episode: Episode, callback: @escaping (String) -> ()) {
    let url = baseUrl + "source/" + String(movie.id) + "/" + String(episode.id)
    
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        
        callback(json["source"].string!)
    }
}

class Movie {
    let id: Int
    let title: String
    let image: String
    /*
    let description: String
    let release: Int
    let IMDb: Float
    */
    
    //init(id: Int, title: String, image: String, description: String, release: Int, IMDb: Float)
    init(id: Int, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
        /*
        self.description = description
        self.release = release
        self.IMDb = IMDb
        */
    }
}

class Server {
    let id: Int
    let episodes: [Episode]
    
    init(id: Int, episodes: [Episode]) {
        self.id = id
        self.episodes = episodes
    }
}

class Episode {
    let id: Int
    let title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
