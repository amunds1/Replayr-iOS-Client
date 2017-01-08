//
//  ViewController.swift
//  MovieViewer
//
//  Created by Andreas Amundsen on 06/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchInput: UITextField!
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ///getMovieInformation(movieId: "Sherlock")
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let phrase = searchInput.text!.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil);
        
        search(phrase: phrase) { movies in
            self.movies = movies
            self.performSegue(withIdentifier: "showTable", sender: self)
        }
    }
    
    //seque to other viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewController: TableViewController = segue.destination as! TableViewController
        
        
        tableViewController.movies = movies
    }
}

