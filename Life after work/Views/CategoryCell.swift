//
//  categoryCell.swift
//  Life after work
//
//  Created by Lisa J on 10/4/24.
//

import UIKit

class CategoryCell: UITableViewCell {
    let padding: CGFloat = 8.0
    let imageSize: CGFloat = 20.0

    lazy var iconImageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CategoryCell")
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.iconImageView.image = nil
    }
    
    private func setupViews() {
        setupImageView()
        setupCategoryLabel()
    }
    
    private func setupImageView() {
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: imageSize),
            iconImageView.heightAnchor.constraint(equalToConstant: imageSize),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    private func setupCategoryLabel() {
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: padding),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
