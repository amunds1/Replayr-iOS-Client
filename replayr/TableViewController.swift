//
//  TableViewController.swift
//  MovieViewer
//
//  Created by Andreas Amundsen on 06/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var recevecSearchString: String = ""
    var movies: [String]?
    var movieSelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // return number of films
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.filmTitle.text = "movie"
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = "movie"
        
        
        performSegue(withIdentifier: "presentMovie", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presentMovie") {
            let movieViewController: MovieViewController = segue.destination as! MovieViewController
            movieViewController.selectedMovie = movieSelected
        }
    }
}














