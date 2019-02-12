//
//  NamesCell.swift
//  RxSwift
//
//  Created by mac on 1/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NamesCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    var person : Person! {
        didSet {
            nameLabel.text = person.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
