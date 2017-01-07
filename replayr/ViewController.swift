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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //seque to other viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var searchString: String = searchInput.text!
        searchString = searchString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        let tableViewController: TableViewController = segue.destination as! TableViewController
        
        tableViewController.recevecSearchString = searchString
    }
}

