//
//  ListItemCell.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

class ListItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
        
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
