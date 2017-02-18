//
//  MovieViewController.swift
//  MovieViewer
//
//  Created by Andreas Amundsen on 06/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import EZAlertController
import SwifterSwift
import Cosmos
import SwiftSpinner
import AVPlayerViewControllerSubtitles

class MovieViewController: UIViewController {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    

    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var playMovieButton: UIButton!
    @IBOutlet weak var starRating: CosmosView!
    
    var movie: Movie?
    var servers: [Server]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movie?.title
        
        let imageURL = NSURL(string: (movie?.image)!)
        let imagedData = NSData(contentsOf: imageURL! as URL)!
        movieImage.image = UIImage(data: imagedData as Data)
        
        movieDescription.text = movie?.description
        
        starRating.settings.updateOnTouch = false
        starRating.settings.fillMode = .precise
        starRating.rating = Double((movie?.IMDb)!)/2.0
        
        movieReleaseYear.text = "Release: " + String(describing: (movie?.release)!)
        
        SwiftSpinner.hide()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        playMovieButton.isEnabled = true
    }
    
    @IBAction func playMovie(_ sender: Any) {
        playFilm()
    }
    
    func playFilm() {
        playMovieButton.isEnabled = false
        
        getPlaylist(movie: self.movie!, episode: (servers?[0].episodes[0])!) { playlist in
            let videoURL = NSURL(string: playlist.sources[0].file)
            
            // Movie player
            let moviePlayer = AVPlayerViewController()
            moviePlayer.player = AVPlayer(url: videoURL as! URL)
            self.present(moviePlayer, animated: true, completion: nil)
            
            
            if (playlist.subtitles.count > 0) && (playlist.subtitles[0].language == "English") {
                let subtitleURL = NSURL(string: "http://123movies.is" + playlist.subtitles[0].file)
                
                // Add subtitles
                moviePlayer.addSubtitles().open(file: subtitleURL as! URL)
                moviePlayer.addSubtitles().open(file: subtitleURL as! URL, encoding: String.Encoding.utf8)
                
                // Change text properties
                moviePlayer.subtitleLabel?.textColor = UIColor.red
                
            }
            
            
            
            // Play
            moviePlayer.player?.play()
        }
    }
}
