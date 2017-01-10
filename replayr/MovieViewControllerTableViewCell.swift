//
//  MovieViewControllerTableViewCell.swift
//  replayr
//
//  Created by Andreas Amundsen on 10/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import UIKit

class MovieViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
