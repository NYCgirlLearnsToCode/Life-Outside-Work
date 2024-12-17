//
//  ViewController.swift
//  Life after work
//
//  Created by Lisa J on 10/3/24.
//

import UIKit

class SelectCategoryViewController: UIViewController, SaveCategoryDelegate {

    @IBOutlet var selectCategoryView: SelectCategoryView!
    
    var categoriesViewModel = CategoriesViewModel()
    var selectedCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - temporary for testing, remove
        CategoryPersistenceHelper.manager.deleteItems()
        selectCategoryView.selectCategoryTableview.delegate = self
        selectCategoryView.selectCategoryTableview.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        selectCategoryView.delegate = self
        selectCategoryView.selectCategoryTableview.dataSource = self
        selectCategoryView.setupView()
    }
    
    func saveSelectedCategories() {
        for row in 0..<selectCategoryView.selectCategoryTableview.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            
            if let cell = selectCategoryView.selectCategoryTableview.cellForRow(at: indexPath) {
                if cell.accessoryType == .checkmark {
                    let category = categoriesViewModel.categories[indexPath.row]
                    selectedCategories.append(category)
                }
            }
        }
        
        if selectedCategories.isEmpty {
            let alert = UIAlertController(title: "No categories selected", message: "Please select some categories :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        CategoryPersistenceHelper.manager.save(categories: selectedCategories, completion: {_ in
            // TODO: navigate to vc with selected categories or refresh the tableview with the selected categories
            // once successfully saved, navigate to viewcontroller displaying the list of selected categories
            // dismiss select category vc
            let selectedCategoriesVC = SelectedCategoriesViewController()
            if let navController = self.navigationController {
                navController.pushViewController(selectedCategoriesVC, animated: true)
                print("done pushing")
            } else {
                print("this vc is not embedded in a nav controller")
            }
        }, onFailure: {
            print("couldn't save")
        })
    }
}

extension SelectCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        // Toggle the selection state in the data model
        categoriesViewModel.categories[indexPath.row].isSelected.toggle()

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

