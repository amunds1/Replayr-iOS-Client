//
//  SeriesViewController.swift
//  replayr
//
//  Created by Andreas Amundsen on 10/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Cosmos
import SwifterSwift

class SeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var movie: Movie?
    var servers = [Server]()
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var moveImage: UIImageView!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet var movieDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movie?.title
        
        let imageURL = NSURL(string: (movie?.image)!)
        let imagedData = NSData(contentsOf: imageURL! as URL)!
        moveImage.image = UIImage(data: imagedData as Data)
        
        movieDescription.text = movie?.description
        
        starRating.settings.updateOnTouch = false
        starRating.settings.fillMode = .precise
        starRating.rating = Double((movie?.IMDb)!)/2.0
        
        movieReleaseYear.text = "Release: " + String(describing: (movie?.release)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servers[0].episodes.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor(red: 18, green: 18, blue: 18)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "seriesCell")
        cell.textLabel?.text = servers[0].episodes[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = servers[0].episodes[indexPath.row]
        getPlaylist(movie: movie!, episode: episode) { playlist in
            let videoURL = NSURL(string: playlist.sources[0].file)
            let player = AVPlayer(url: videoURL! as URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
}
