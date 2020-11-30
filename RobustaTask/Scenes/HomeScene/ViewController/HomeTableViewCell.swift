//
//  HomeTableViewCell.swift
//  RobustaTask
//
//  Created by Zyad Galal on 26/11/2020.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
