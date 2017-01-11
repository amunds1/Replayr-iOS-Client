//
//  ViewControllerTableViewCell.swift
//  MovieViewer
//
//  Created by Andreas Amundsen on 07/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit
import Cosmos

class ViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var filmReleaseYear: UILabel!
    @IBOutlet weak var filmDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
