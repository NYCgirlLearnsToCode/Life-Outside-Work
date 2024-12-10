//
//  SelectedCategoriesView.swift
//  Life after work
//
//  Created by Lisa J on 11/26/24.
//

import UIKit

class SelectedCategoriesView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What I am focusing on this week"
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        return tableView
    }()
    
    private func setupViews() {
        self.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1.0)
        setupTitleLabel()
        setupTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    // TODO: standardize with other views, next step is to init in it's corresponding vc, this view should take up the whole vc page
    
    private func commonInit() {
        setupViews()
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0).isActive = true
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
    }
}
