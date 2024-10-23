//
//  ViewController.swift
//  Life after work
//
//  Created by Lisa J on 10/3/24.
//

import UIKit

class SelectCategoryViewController: UIViewController {

    @IBOutlet var selectCategoryView: SelectCategoryView!
    
    var categoriesViewModel = CategoriesViewModel()
    var selectedCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCategoryView.selectCategoryTableview.delegate = self
        selectCategoryView.selectCategoryTableview.dataSource = self
        selectCategoryView.setupView()
    }
}

extension SelectCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        categoriesViewModel.categories[indexPath.row].isSelected = !categoriesViewModel.categories[indexPath.row].isSelected

        if categoriesViewModel.categories[indexPath.row].isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}

extension SelectCategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesViewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categoriesViewModel.categories[indexPath.row]
        cell.categoryLabel.text = category.name
        cell.iconImageView.image = UIImage(systemName: category.icon)
        return cell
    }
}

