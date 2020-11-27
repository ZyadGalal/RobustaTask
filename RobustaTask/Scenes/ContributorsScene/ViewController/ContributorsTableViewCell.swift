//
//  ContributorsTableViewCell.swift
//  RobustaTask
//
//  Created by Zyad Galal on 28/11/2020.
//

import UIKit

class ContributorsTableViewCell: UITableViewCell {

    @IBOutlet weak var contributorNameLabel: UILabel!
    @IBOutlet weak var contributorImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
