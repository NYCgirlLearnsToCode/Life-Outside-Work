//
//  ViewController.swift
//  Life after work
//
//  Created by Lisa J on 10/3/24.
//

import UIKit

class SelectCategoryViewController: UIViewController {

    @IBOutlet var selectCategoryView: SelectCategoryView!
    
    let categoriesViewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCategoryView.selectCategoryTableview.delegate = self
        selectCategoryView.selectCategoryTableview.dataSource = self
    }
}

extension SelectCategoryViewController: UITableViewDelegate {
    
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
        print("category\(category.name)")
        cell.categoryLabel.text = category.name
        cell.iconImageView.image = UIImage(systemName: category.icon)
        return cell
    }
}

