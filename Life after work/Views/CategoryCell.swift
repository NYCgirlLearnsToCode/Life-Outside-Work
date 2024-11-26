//
//  categoryCell.swift
//  Life after work
//
//  Created by Lisa J on 10/4/24.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.iconImageView.image = nil
    }
}
