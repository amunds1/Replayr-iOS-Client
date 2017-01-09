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

class TableViewController: UITableViewController {
    var recevecSearchString: String = ""
    var movies: [Movie]?
    var row: Int = 0
    
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
        
        cell.filmTitle.text = movie?.getTitle()
        
        let imageURL = NSURL(string: (movie?.getImage())!)
        let imagedData = NSData(contentsOf: imageURL! as URL)!
        cell.filmImage.image = UIImage(data: imagedData as Data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        
        performSegue(withIdentifier: "presentMovie", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presentMovie") {
            let movieViewController: MovieViewController = segue.destination as! MovieViewController
            movieViewController.movie = movies?[row]
        }
    }
}
