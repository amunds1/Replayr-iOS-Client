//
//  ViewController.swift
//  Color Memory
//
//  Created by Andreas Amundsen on 20/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var colorList = [Int : Array<Any>]()
    var count = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeBackgroundColor), userInfo: nil, repeats: true)
    }
    
    func getRandomColor() -> UIColor{
        count += 1
        
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        let color: Array = [red, green, blue]
        
        colorList.updateValue(color, forKey: count)
    
        if count >= 5 {
            timer.invalidate()
            performSegue(withIdentifier: "guessViewController", sender: self)
        }
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func changeBackgroundColor() {
        self.view.backgroundColor = getRandomColor()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "guessViewController") {
            let guessOrderViewController: GuessOrderViewController = segue.destination as! GuessOrderViewController
            guessOrderViewController.colorList = colorList
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
