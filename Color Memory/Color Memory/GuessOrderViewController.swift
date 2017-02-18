//
//  GuessOrderViewController.swift
//  Color Memory
//
//  Created by Andreas Amundsen on 22/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit

class GuessOrderViewController: UIViewController {

    var colorList = [Int : Array<Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (k, v) in colorList {
            print(k, v)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
