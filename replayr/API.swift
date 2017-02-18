import Foundation
import Alamofire
import SwiftyJSON

let baseUrl = "http://replayr-api.herokuapp.com/" 

func search(phrase: String, callback: @escaping ([Movie]) -> ()) {
    let url = baseUrl + "search/" + phrase
    
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        var movies = [Movie]()

        for movie in json["movies"].arrayValue {
            //movies.append(Movie(id: movie["id"].int! , title: movie["title"].string!, image: movie["image"].string!))
            movies.append(Movie(id: movie["id"].int!, title: movie["title"].string!, image: movie["image"].string!, description: movie["description"].string!, episodes: movie["episodes"].int!, release: movie["release"].int!, IMDb: movie["imdb"].float!))
        }
        
        callback(movies)
    }
}

func getPopularItems(callback: @escaping ([Movie], [Movie]) -> ()) {
    let url = baseUrl + "popular"
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        var mostPopularMovies: [Movie] = []
        var mostPopularSeries: [Movie] = []
        
        for movie in json["movies"].arrayValue {
            if movie["episodes"] > 0 {
                mostPopularSeries.append(Movie(id: movie["id"].int!, title: movie["title"].string!, image: movie["image"].string!, description: movie["description"].string!, episodes: movie["episodes"].int!, release: movie["release"].int!, IMDb: movie["imdb"].float!))
            } else {
                mostPopularMovies.append(Movie(id: movie["id"].int!, title: movie["title"].string!, image: movie["image"].string!, description: movie["description"].string!, episodes: movie["episodes"].int!, release: movie["release"].int!, IMDb: movie["imdb"].float!))
            }
        }
        
        callback(mostPopularMovies, mostPopularSeries)
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

func getPlaylist(movie: Movie, episode: Episode, callback: @escaping (Playlist) -> ()) {
    let url = baseUrl + "playlist/" + String(movie.id) + "/" + String(episode.id)
    
    Alamofire.request(url).responseJSON { response in
        let json = JSON(response.result.value!)
        var sources = [Source]()
        var subtitles = [Subtitle]()
        
        for source in json["playlist"]["sources"].arrayValue {
            sources.append(Source(file: source["file"].string!, quality: source["quality"].string!))
        }
        
        for subtitle in json["playlist"]["subtitles"].arrayValue {
            subtitles.append(Subtitle(file: subtitle["file"].string!, language: subtitle["language"].string!))
        }
        
        callback(Playlist(sources: sources, subtitles: subtitles))
    }
}

class Playlist {
    let sources: [Source]
    let subtitles: [Subtitle]
    
    init(sources: [Source], subtitles: [Subtitle]) {
        self.sources = sources
        self.subtitles = subtitles
    }
}

class Source {
    let file: String
    let quality: String
    
    init(file: String, quality: String) {
        self.file = file
        self.quality = quality
    }
}

class Subtitle {
    let file: String
    let language: String
    
    init(file: String, language: String) {
        self.file = file
        self.language = language
    }
}

class Movie {
    let id: Int
    let title: String
    let image: String
    let description: String
    let episodes: Int
    let release: Int
    let IMDb: Float
    
    //init(id: Int, title: String, image: String)
    init(id: Int, title: String, image: String, description: String, episodes: Int, release: Int, IMDb: Float) {
        self.id = id
        self.title = title
        self.image = image
        self.description = description
        self.episodes = episodes
        self.release = release
        self.IMDb = IMDb
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
