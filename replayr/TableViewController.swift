//
//  TableViewController.swift
//  MovieViewer
//
//  Created by Andreas Amundsen on 06/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import SwiftSpinner
import SwifterSwift

class TableViewController: UITableViewController {
    var recevecSearchString: String = ""
    var movies: [Movie]?
    var row: Int = 0
    var imageCache = [String : UIImage]()
    var servers: [Server]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies!.count
    }
    
    //Populate cells with data from Movie class
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ViewControllerTableViewCell
        
        let movie = movies?[indexPath.row]
        
        cell.filmTitle.text = movie?.title
        
        if !imageCache.has(key: (movie?.image)!) {
            let imageURL = NSURL(string: (movie?.image)!)
            let imageData = NSData(contentsOf: imageURL! as URL)!
            imageCache[(movie?.image)!] = UIImage(data: imageData as Data)
        }
        
        cell.filmImage.image = imageCache[(movie?.image)!]
        
        SwiftSpinner.hide()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        
        getEpisodes(movie: (movies?[row])!) { servers in
            self.servers = servers
            if servers[0].episodes.count == 1 {
                self.performSegue(withIdentifier: "presentMovie", sender: self)
            } else {
                self.performSegue(withIdentifier: "presentSeries", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "presentMovie") {
            let movieViewController: MovieViewController = segue.destination as! MovieViewController
            movieViewController.movie = movies?[row]
            movieViewController.servers = servers!
        } else if (segue.identifier == "presentSeries") {
            let seriesViewController: SeriesViewController = segue.destination as! SeriesViewController
            seriesViewController.movie = movies?[row]
            seriesViewController.servers = servers!
        }
    }
}
